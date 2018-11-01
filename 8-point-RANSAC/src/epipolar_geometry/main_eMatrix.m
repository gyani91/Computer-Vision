% =========================================================================
% Exercise 4.3: Essential matrix
% =========================================================================
clear
addpath helpers
addpath images

clickPoints = false;
% dataset = 0;   % Your pictures
% dataset = 1; % ladybug
% dataset = 2; % rect
dataset = 3; % pumpkin

% image names
if(dataset==0)
    imgName1 = '';
    imgName2 = '';

    % Your camera calibration
    K = [];

elseif(dataset==1)
	imgName1 = 'images/ladybug_Rectified_0768x1024_00000064_Cam0.png';
	imgName2 = 'images/ladybug_Rectified_0768x1024_00000080_Cam0.png';

	K = [130.5024      0  500.0005
	      0  130.5024  372.3164
	      0         0    1.0000];
elseif(dataset==2)
	imgName1 = 'images/rect1.jpg';
	imgName2 = 'images/rect2.jpg';

	K = [  	1653.5  0    	0982.7;
			0    	1655.3 	0725.4;
			0.0		0.0		1.0 ];
elseif(dataset==3)
	imgName1 = 'images/pumpkin1.jpg';
	imgName2 = 'images/pumpkin2.jpg';

    K = [1197, 0,      466.19;
        0,     1199.1, 314.13;
        0,     0,      1];
end

% read in images
img1 = im2double(imread(imgName1));
img2 = im2double(imread(imgName2));

[pathstr1, name1] = fileparts(imgName1);
[pathstr2, name2] = fileparts(imgName2);

cacheFile = [pathstr1 filesep 'matches_' name1 '_vs_' name2 '.mat'];

% get point correspondences
if (clickPoints)
    [x1s, x2s] = getClickedPoints(img1, img2);
	save(cacheFile, 'x1s', 'x2s', '-mat');
else
	load('-mat', cacheFile, 'x1s', 'x2s');
end



%% YOUR CODE HERE

K_inv = inv(K);
% estimate fundamental matrix
[Eh, E] = essentialMatrix(x1s, x2s, K);


% show clicked points
figure(1),hold off, imshow(img1, []); hold on, plot(x1s(1,:), x1s(2,:), '*r');
figure(2),hold off, imshow(img2, []); hold on, plot(x2s(1,:), x2s(2,:), '*b');


% compute the corresponding epipolar lines from F=K_inv'*E*K_inv
FF=K_inv'*Eh*K_inv;
% draw epipolar lines in img 1
figure(1)
for k = 1:size(x1s,2)
    drawEpipolarLines(FF'*x2s(:,k), img1);
end
% draw epipolar lines in img 2
figure(2)
for k = 1:size(x2s,2)
    drawEpipolarLines(FF*x1s(:,k), img2);
end


%%
% =========================================================================
% Exercise 4.4: Camera matrix
% =========================================================================
% Now you should use your essential matrix estimate to extract a camera pair

% TODO: implement decomposeE
P1 = [eye(3) [0;0;0]];
P2 = decomposeE(Eh, x1s, x2s, K);

% TODO: triangulate 3D points and plot together with cameras
% The function showCameras.m is can be useful here

[XS, err] = linearTriangulation(P1, x1s, P2, x2s);
figId=3;
figure(3);
scatter3(XS(1,:), XS(2,:), XS(3,:));
CAM = cell(2,1);
CAM{1} = P1;
CAM{2} = P2;
showCameras(CAM, figId);



