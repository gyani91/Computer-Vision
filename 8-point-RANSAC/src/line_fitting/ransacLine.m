function [k, b] = ransacLine(data, iter, threshold)
% data: a 2xn dataset with #n data points
% iter: the number of iterations
% threshold: the threshold of the distances between points and the fitting line

num_pts = size(data,2); % Total number of points
best_inliers = 0;       % Best fitting line with largest number of inliers
k=0; b=0;               % parameters for best fitting line

data = data';
for i=1:iter
    % Randomly select 2 points and fit line to these
    % Tip: Matlab command randperm is useful here
    CurrentInliers = [];
	inliers = 0;
	rand_num = floor(rand(1,2) * num_pts); %randomly choose one of the points
	rand_num( rand_num == 0 ) = 1; %there is no point 0
    
    P1 = data(rand_num(1),:);
	P2 = data(rand_num(2),:);
    
    % Model is y = k*x + b
    
	[A, B, C] = FindLine(P1, P2);
    
    % Compute the distances between all points with the fitting line
    % Compute the inliers with distances smaller than the threshold
    for counter = 1:num_pts
		d = DistancePointToLine(A,B,C,data(counter,:));
        %label the point an inlier if its distance to the line is below the threshold
        if d < threshold
			inliers = inliers + 1;
			CurrentInliers(inliers) = counter; %keep track of which points are inliers on wrt this line
        end
    end
    % Update the number of inliers and fitting model if better model is found
    if inliers > best_inliers
		WinningLineParams = [A B C];
		best_inliers = inliers;
		GoodInliers = CurrentInliers;
		GoodPoints = rand_num;
    end   
end
A = WinningLineParams(1);
B = WinningLineParams(2);
C = WinningLineParams(3);
k = -A/B;
b = -C/B;
end
