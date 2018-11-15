% intro
close all; clear all;
path(path, 'sift');
path(path, 'GCMex');

imgNameL = 'images/0018.png';
imgNameR = 'images/0019.png';
camNameL = 'images/0018.camera';
camNameR = 'images/0019.camera';

% scale = 0.5^2; % try this scale first
scale = 0.5^3; % if it takes too long switch to this one

imgL = imresize(imread(imgNameL), scale);
imgR = imresize(imread(imgNameR), scale);

figure(1);
subplot(121); imshow(imgL);
subplot(122); imshow(imgR);
saveas(1,'output/fig_1.png');

[K R C] = readCamera(camNameL);
PL = K * [R, -R*C];
[K R C] = readCamera(camNameR);
PR = K * [R, -R*C];

[imgRectL, imgRectR, Hleft, Hright, maskL, maskR] = ...
    getRectifiedImages(imgL, imgR);

figure(4);
subplot(121); imshow(imgRectL);
subplot(122); imshow(imgRectR);
saveas(4,'output/fig_4.png');

se = strel('square', 15);
maskL = imerode(maskL, se);
maskR = imerode(maskR, se);
%%
% set disparity range
% [x1s, x2s] = getClickedPoints(imgRectL, imgRectR); 
% close all;

% Feature Matching
Ia = single(rgb2gray(imgRectL));
Ib = single(rgb2gray(imgRectR));
peak_thresh = 0.033;

[x1s, descr1] = vl_sift(Ia,'PeakThresh', peak_thresh);
[x2s, descr2] = vl_sift(Ib,'PeakThresh', peak_thresh);

x1s = [x1s(1:2,:); ones(1, size(x1s, 2))];
x2s = [x2s(1:2,:); ones(1, size(x2s, 2))];

[matches, ~] = vl_ubcmatch(descr1, descr2);
matches1 = x1s(:,matches(1,:));
matches2 = x2s(:,matches(2,:));

for k=length(matches1):-1:1
    delta = abs(matches1(2,k) - matches2(2,k));
    if or(delta > 0.01 * size(imgRectL,1), delta > 0.25 * size(imgRectL,2))
        matches1(:,k) = [];
        matches2(:,k) = [];
    end
end

% RANSAC
[~, inliers] = fundamentalMatrixRANSAC(matches1, matches2);
matches1 = matches1(:,inliers);
matches2 = matches2(:,inliers);

% Largest Disparity found post RANSAC
rmax = ceil(max(abs(matches1(1,:)-matches2(1,:))));
% If disparity is very large, cap it to 40 (according to the image)
rmax = min(rmax, 40);

dispRange = -rmax:rmax;

% for now try these fixed ranges
% dispRange = -30:30;
% dispRange = -40:40;
%%
% Window 3x3
dispStereoL = ...
    stereoDisparity(rgb2gray(imgRectL), rgb2gray(imgRectR), dispRange, 100);
dispStereoR = ...
    stereoDisparity(rgb2gray(imgRectR), rgb2gray(imgRectL), dispRange, 100);

figure(5);
subplot(121); imshow(dispStereoL, [dispRange(1) dispRange(end)]);
subplot(122); imshow(dispStereoR, [dispRange(1) dispRange(end)]);
saveas(5,'output/fig_5.png');

thresh = 8;

maskLRcheck = leftRightCheck(dispStereoL, dispStereoR, thresh);
maskRLcheck = leftRightCheck(dispStereoR, dispStereoL, thresh);

maskStereoL = double(maskL).*maskLRcheck;
maskStereoR = double(maskR).*maskRLcheck;

figure(6);
subplot(121); imshow(maskStereoL);
subplot(122); imshow(maskStereoR);
saveas(6,'output/fig_6.png');
% 
% % % Window 5x5
% dispStereoL = ...
%     stereoDisparity(rgb2gray(imgRectL), rgb2gray(imgRectR), dispRange, 5);
% dispStereoR = ...
%     stereoDisparity(rgb2gray(imgRectR), rgb2gray(imgRectL), dispRange, 5);
% 
% figure(7);
% subplot(121); imshow(dispStereoL, [dispRange(1) dispRange(end)]);
% subplot(122); imshow(dispStereoR, [dispRange(1) dispRange(end)]);
% saveas(7,'output/fig_7.png');
% 
% thresh = 8;
% 
% maskLRcheck = leftRightCheck(dispStereoL, dispStereoR, thresh);
% maskRLcheck = leftRightCheck(dispStereoR, dispStereoL, thresh);
% 
% maskStereoL = double(maskL).*maskLRcheck;
% maskStereoR = double(maskR).*maskRLcheck;
% 
% figure(8);
% subplot(121); imshow(maskStereoL);
% subplot(122); imshow(maskStereoR);
% saveas(8,'output/fig_8.png');
% 
% % Window 7x7
% dispStereoL = ...
%     stereoDisparity(rgb2gray(imgRectL), rgb2gray(imgRectR), dispRange, 7);
% dispStereoR = ...
%     stereoDisparity(rgb2gray(imgRectR), rgb2gray(imgRectL), dispRange, 7);
% 
% figure(9);
% subplot(121); imshow(dispStereoL, [dispRange(1) dispRange(end)]);
% subplot(122); imshow(dispStereoR, [dispRange(1) dispRange(end)]);
% saveas(9,'output/fig_9.png');
% 
% thresh = 8;
% 
% maskLRcheck = leftRightCheck(dispStereoL, dispStereoR, thresh);
% maskRLcheck = leftRightCheck(dispStereoR, dispStereoL, thresh);
% 
% maskStereoL = double(maskL).*maskLRcheck;
% maskStereoR = double(maskR).*maskRLcheck;
% 
% figure(10);
% subplot(121); imshow(maskStereoL);
% subplot(122); imshow(maskStereoR);
% saveas(10,'output/fig_10.png');
%%
% compute disparities using graphcut
% exercise 5.2
Labels = ...
    gcDisparity(rgb2gray(imgRectL), rgb2gray(imgRectR), dispRange);
dispsGCL = double(Labels + dispRange(1));
Labels = ...
    gcDisparity(rgb2gray(imgRectR), rgb2gray(imgRectL), dispRange);
dispsGCR = double(Labels + dispRange(1));

figure(11);
subplot(121); imshow(dispsGCL, [dispRange(1) dispRange(end)]);
subplot(122); imshow(dispsGCR, [dispRange(1) dispRange(end)]);
saveas(11,'output/fig_11.png');

thresh = 1;

maskLRcheck = leftRightCheck(dispsGCL, dispsGCR, thresh);
maskRLcheck = leftRightCheck(dispsGCR, dispsGCL, thresh);

maskGCL = double(maskL).*maskLRcheck;
maskGCR = double(maskR).*maskRLcheck;

figure(12);
subplot(121); imshow(maskGCL);
subplot(122); imshow(maskGCR);
saveas(12,'output/fig_12.png');
%%
dispStereoL = double(dispStereoL);
dispStereoR = double(dispStereoR);
dispsGCL = double(dispsGCL);
dispsGCR = double(dispsGCR);

S = [scale 0 0; 0 scale 0; 0 0 1];

% for each pixel (x,y), compute the corresponding 3D point 
% use S for computing the rescaled points with the projection 
% matrices PL PR
% exercise 5.3
coords = generatePointCloudFromDisps(dispsGCL, PL, PR);
% ... do same for other winner-takes-all
coords2 = generatePointCloudFromDisps(dispStereoL, PL, PR);

imwrite(imgRectL, 'imgRectL.png');
imwrite(imgRectR, 'imgRectR.png');

% use meshlab to open generated textured model
generateObjFile('modelGC', 'imgRectL.png', ...
    coords, maskGCL.*maskGCR);
% ... do same for other winner-takes-all
generateObjFile('modelStereo', 'imgRectL.png', ...
    coords2, maskStereoL.*maskStereoR);