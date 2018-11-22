% =========================================================================
% Exercise 8
% =========================================================================

close all; clear all;
% Initialize VLFeat (http://www.vlfeat.org/)

%K Matrix for house images (approx.)
K = [  670.0000     0     393.000
         0       670.0000 275.000
         0          0        1];

%Load images
imgName1 = 'data/house.000.pgm';
imgName2 = 'data/house.004.pgm';

img1 = single(imread(imgName1));
img2 = single(imread(imgName2));

%extract SIFT features and match
[fa, da] = vl_sift(img1);
[fb, db] = vl_sift(img2);

%don't take features at the top of the image - only background
filter = fa(2,:) > 100;
fa = fa(:,find(filter));
da = da(:,find(filter));

[matches1, ~] = vl_ubcmatch(da, db);

showFeatureMatches(img1, fa(1:2, matches1(1,:)), img2, fb(1:2, matches1(2,:)), 1);

%% Compute essential matrix and projection matrices and triangulate matched points

% use 8-point ransac ransac - compute and decompose the essential matrix 
% and create the projection matrices

x1 = fa(1:2, matches1(1,:));
x2 = fb(1:2, matches1(2,:));
t = 0.04;
[F, inliers1] = ransacfitfundmatrix(x1, x2, t);

% Epipolar geometry of the initialization image1
figure(2), imshow(img1, []); hold on, plot(fa(1, matches1(1,inliers1(1,:))), fa(2, matches1(1,inliers1(1,:))), '*r');

for k = 1:size(inliers1,2)
    drawEpipolarLines(F'*[fb(1:2, matches1(2,inliers1(1,k)));1], img1);
end

% Epipolar geometry of the initialization image2
figure(3), imshow(img2, []); hold on, plot(fb(1, matches1(2,inliers1(1,:))), fb(2, matches1(2,inliers1(1,:))), '*b');

for k = 1:size(inliers1,2)
    drawEpipolarLines(F*[fa(1:2, matches1(1,inliers1(1,k)));1], img2);
end

showFeatureMatches(img1, fa(1:2, matches1(1,inliers1(1,:))), img2, fb(1:2, matches1(2,inliers1(1,:))), 4);
outliers1 = setdiff(matches1(1,:),inliers1(1,:));
showFeatureMatches(img1, fa(1:2, outliers1), img2, fb(1:2, outliers1), 5);

E = K'*F*K; 
fa_inliers = fa(1:2, matches1(1,inliers1(1,:)));
%and decompose the essential matrix and create the projection matrices

x1_calibrated = K\[fa(1:2, matches1(1,inliers1(1,:))); ones(1,size(inliers1,2))];
x2_calibrated = K\[fb(1:2, matches1(2,inliers1(1,:))); ones(1,size(inliers1,2))];

Ps{1} = eye(4);
Ps{2} = decomposeE(E, x1_calibrated, x2_calibrated);

%triangulate the inlier matches with the computed projection matrix
[XS1, ~] = linearTriangulation(Ps{1}, x1_calibrated, Ps{2}, x2_calibrated);

%% Add an addtional view of the scene 

imgName3 = 'data/house.001.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

%match against the features from image 1 that where triangulated
[matches2, ~] = vl_ubcmatch(da(:,matches1(1,inliers1(1,:))), dc);

%run 6-point ransac
x3_calibrated = K\[fc(1:2, matches2(2,:));ones(1,size(matches2,2))];
[Ps{3}, inliers2] = ransacfitprojmatrix(x3_calibrated(1:2,:), XS1(1:3,matches2(1,:)), t);

%save inliers of triangulated pair of initial pair of images for plotting
XS1_inliers = XS1(1:3,matches2(1,inliers2(1,:)));

showFeatureMatches(img1, fa_inliers(1:2, matches2(1,inliers2(1,:))), img3, fc(1:2, matches2(2,inliers2(1,:))), 6);
outliers2 = setdiff(matches2(1,:),inliers2(1,:));
showFeatureMatches(img1, fa(1:2, outliers2), img3, fc(1:2, outliers2), 7);

if (det(Ps{3}(1:3,1:3)) < 0 )
    Ps{3}(1:3,:) = -Ps{3}(1:3,:);
end

%triangulate the inlier matches with the computed projection matrix
[XS2, ~] = linearTriangulation(Ps{1}, x1_calibrated(:,matches2(1,inliers2(1,:))), Ps{3}, x3_calibrated(:,inliers2(1,:)));
%% Add more views...

imgName4 = 'data/house.002.pgm';
img4 = single(imread(imgName4));
[fd, dd] = vl_sift(img4);

%match against the features from image 1 that where triangulated
[matches3, ~] = vl_ubcmatch(da(:,matches1(1,inliers1(1,:))), dd);

%run 6-point ransac
x4_calibrated = K\[fd(1:2, matches3(2,:));ones(1,size(matches3,2))];
[Ps{4}, inliers3] = ransacfitprojmatrix(x4_calibrated(1:2,:), XS1(1:3,matches3(1,:)), t);

showFeatureMatches(img1, fa_inliers(1:2, matches3(1,inliers3(1,:))), img4, fd(1:2, matches3(2,inliers3(1,:))), 8);
outliers3 = setdiff(matches3(1,:),inliers3(1,:));
showFeatureMatches(img1, fa(1:2, outliers3), img4, fd(1:2, outliers3), 9);

if (det(Ps{4}(1:3,1:3)) < 0 )
    Ps{4}(1:3,:) = -Ps{4}(1:3,:);
end

%triangulate the inlier matches with the computed projection matrix
[XS3, ~] = linearTriangulation(Ps{1}, x1_calibrated(:,matches3(1,inliers3(1,:))), Ps{4}, x4_calibrated(:,inliers3(1,:)));

imgName5 = 'data/house.003.pgm';
img5 = single(imread(imgName5));
[fe, de] = vl_sift(img5);

%match against the features from image 1 that where triangulated
[matches4, ~] = vl_ubcmatch(da(:,matches1(1,inliers1(1,:))), de);

%run 6-point ransac
x5_calibrated = K\[fe(1:2, matches4(2,:));ones(1,size(matches4,2))];
[Ps{5}, inliers4] = ransacfitprojmatrix(x5_calibrated(1:2,:), XS1(1:3,matches4(1,:)), t);

showFeatureMatches(img1, fa_inliers(1:2, matches4(1,inliers4(1,:))), img5, fe(1:2, matches4(2,inliers4(1,:))), 10);
outliers4 = setdiff(matches4(1,:),inliers4(1,:));
showFeatureMatches(img1, fa(1:2, outliers4), img5, fe(1:2, outliers4), 11);

if (det(Ps{5}(1:3,1:3)) < 0 )
    Ps{5}(1:3,:) = -Ps{5}(1:3,:);
end

%triangulate the inlier matches with the computed projection matrix
[XS4, ~] = linearTriangulation(Ps{1}, x1_calibrated(:,matches4(1,inliers4(1,:))), Ps{5}, x5_calibrated(:,inliers4(1,:)));

%% Plot stuff

fig = 20;
figure(fig);
hold on;

%use plot3 to plot the triangulated 3D points
scatter3(XS1_inliers(1,:),XS1_inliers(2,:),XS1_inliers(3,:), 20, 'r', 'diamond', 'filled');
scatter3(XS2(1,:),XS2(2,:),XS2(3,:), 25, 'g', 'diamond', 'filled');
scatter3(XS3(1,:),XS3(2,:),XS3(3,:), 25, 'b', 'diamond', 'filled');
scatter3(XS4(1,:),XS4(2,:),XS4(3,:), 25, 'm', 'diamond', 'filled');

%draw cameras
drawCameras(Ps, fig);

hold off;

%% Stereo Matching and 3D Reconstruction
path(path, 'GCMex');

scale = 0.5^3; % if it takes too long switch to this one

imgL = imresize(imread(imgName1), scale);
imgR = imresize(imread(imgName3), scale);

[imgRectL, imgRectR, Hleft, Hright, maskL, maskR] = ...
    getRectifiedImages(imgL, imgR);

se = strel('square', 15);
maskL = imerode(maskL, se);
maskR = imerode(maskR, se);

Ia = single(imgRectL);
Ib = single(imgRectR);
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

% compute disparities using graphcut
Labels = ...
    gcDisparity(imgRectL, imgRectR, dispRange);
dispsGCL = double(Labels + dispRange(1));
Labels = ...
    gcDisparity(imgRectR, imgRectL, dispRange);
dispsGCR = double(Labels + dispRange(1));

thresh = 1;

maskLRcheck = leftRightCheck(dispsGCL, dispsGCR, thresh);
maskRLcheck = leftRightCheck(dispsGCR, dispsGCL, thresh);

maskGCL = double(maskL).*maskLRcheck;
maskGCR = double(maskR).*maskRLcheck;

dispsGCL = double(dispsGCL);
dispsGCR = double(dispsGCR);

% for each pixel (x,y), compute the corresponding 3D point 
coords = generatePointCloudFromDisps(dispsGCL, Ps{1}, Ps{3});

imwrite(imgRectL, 'imgRectL.png');
imwrite(imgRectR, 'imgRectR.png');

% use meshlab to open generated textured model
generateObjFile('modelGC', 'imgRectL.png', ...
    coords, maskGCL.*maskGCR);