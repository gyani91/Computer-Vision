% Exercise 1
%
clear all;
close all;

IMG_NAME = 'images_my_camera/IMG_6.jpg';

%This function displays the calibration image and allows the user to click
%in the image to get the input points. Left click on the chessboard corners
%and type the 3D coordinates of the clicked points in to the input box that
%appears after the click. You can also zoom in to the image to get more
%precise coordinates. To finish use the right mouse button for the last
%point.
%You don't have to do this all the time, just store the resulting xy and
%XYZ matrices and use them as input for your algorithms.

% Getting the clicked points and saving them in a .mat file
%[xy XYZ] = getpoints(IMG_NAME);
%save('xy.mat','xy');
%save('XYZ.mat','XYZ');

% Loading the clicked point and the corresponding 3D points
load('xy.mat');
load('XYZ.mat');

% additional points
% [xy1 XYZ1] = getpoints(IMG_NAME);
% 
% xy = [xy xy1];
% XYZ = [XYZ XYZ1];

% === Task 2 DLT algorithm ===
%[K, R, t, error] = runDLT(xy, XYZ);

% === Task 3 Gold Standard algorithm ===

[K, R, t, error] = runGoldStandard(xy, XYZ);

% === Bonus: Gold Standard algorithm with radial distortion estimation ===

%[K, R, t, error] = runGoldStandardRadial(xy, XYZ);



