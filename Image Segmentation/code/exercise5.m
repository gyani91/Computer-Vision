function run_ex5()

% load image
img = imread('cow.jpg');
%img = imread('zebra_b.jpg');


% for faster debugging you might want to decrease the size of your image
% img = imresize(img,0.25);

figure, imshow(img), title('original image');

% smooth image

% imgSmoothed = imgaussfilt(img,5);

H = fspecial('gaussian',[5 5],5);
imgSmoothed = imfilter(img,H);

figure, imshow(imgSmoothed), title('smoothed image');

% Convert to L*a*b* image

% imglab = rgb2lab(imgSmoothed);
% figure, imshow(imglab(:,:,1),[0 100]), title('l*a*b* image');

cform = makecform('srgb2lab');
imglab = applycform(imgSmoothed,cform);

figure, imshow(imglab), title('l*a*b* image');


% Mean-Shift Segmentation
imgVector = single(Img2Ary(imglab)) ./ 255;
[mapMS, peak]= meanshiftSeg(imgVector', 0.05, img);
visualizeSegmentationResults(mapMS,peak');


% EM Segmentation
[mapEM, cluster] = EM(imglab,3);
visualizeSegmentationResults(mapEM,cluster);
[mapEM, cluster] = EM(imglab,4);
visualizeSegmentationResults(mapEM,cluster);
[mapEM, cluster] = EM(imglab,5);
visualizeSegmentationResults(mapEM,cluster);
end