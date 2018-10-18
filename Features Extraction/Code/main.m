% Exercise 1
%
close all;
clear all;

IMG_NAME1 = 'images/I1.jpg';
IMG_NAME2 = 'images/I2.jpg';

% read in image
img1 = im2double(imread(IMG_NAME1));
img2 = im2double(imread(IMG_NAME2));

img1 = imresize(img1, 1);
img2 = imresize(img2, 1);

% convert to gray image
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

% Task 2.1 - extract Harris corners
[corners1, H1] = extractHarrisCorner(imgBW1', 0.045);
[corners2, H2] = extractHarrisCorner(imgBW2', 0.045);

% show images with Harris corners
showImageWithCorners(img1, corners1, 10);
showImageWithCorners(img2, corners2, 11);

% Task 2.2 - extract your own descriptors
descr1 = extractDescriptor(corners1, imgBW1');
descr2 = extractDescriptor(corners2, imgBW2');

% Task 2.3 - match the descriptors
matches = matchDescriptors(descr1, descr2, 0.1);

showFeatureMatches(img1, corners1(:, matches(1,:)), img2, corners2(:, matches(2,:)), 12);

% Task 2.4 - SIFT features via VLFeat
[vlfmatches, fa, fb, da, db] = vlfeat(imgBW1, imgBW2, 0.033);

% show images with SIFT features
showSIFTFeatures(img1, fa, da, 21);
showSIFTFeatures(img2, fb, db, 22);

% show sift match the descriptors
showFeatureMatches(img1, fa(1:2, vlfmatches(1,:)), img2, fb(1:2, vlfmatches(2,:)), 23);

