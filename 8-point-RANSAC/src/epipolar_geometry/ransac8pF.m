function [in1, in2, out1, out2, m, F] = ransac8pF(x1, x2, threshold)
num_pts = size(x1,2); % Total number of points
best_inliers = 0;% Best fitting line with largest number of inliers

[nx1, ~] = normalizePoints2d(x1);
[nx2, ~] = normalizePoints2d(x2);

nx1=nx1';
nx2=nx2';
iter=1000;
m=1000;
for i=1:iter
    % Randomly select 2 points and fit line to these
    % Tip: Matlab command randperm is useful here
    inliers1 = [];
    inliers2 = [];
    outliers1 = [];
    outliers2 = [];
	inliers = 0; outliers = 0;
	rand_num = floor(rand(1,8) * num_pts); %randomly choose one of the points
	rand_num( rand_num == 0 ) = 1; %there is no point 0
    
    x1_sample = zeros(3,8);
    x2_sample = zeros(3,8);
    for counter = 1:8
        x1_sample(:,counter) = nx1(rand_num(counter),:);
        x2_sample(:,counter) = nx2(rand_num(counter),:);
    end
	
    % Model is y = k*x + b
    
    [Fh, F] = fundamentalMatrix(x1_sample, x2_sample);
    
    % Compute the distances between all points with the fitting line
    % Compute the inliers with distances smaller than the threshold
    for counter = 1:num_pts
		d = distPointLine(nx1(counter,:)', nx2(counter,:)', Fh);
        %label the point an inlier if its distance to the line is below the threshold
        if d < threshold
			inliers = inliers + 1;
			%CurrentInliers(inliers) = counter; %keep track of which points are inliers on wrt this line
            inliers1(:,inliers) = x1(:,counter);
            inliers2(:,inliers) = x2(:,counter);
        else
            outliers = outliers + 1;
            outliers1(:,outliers) = x1(:,counter);
            outliers2(:,outliers) = x2(:,counter);
        end
    end
    % Update the number of inliers and fitting model if better model is found
    if inliers > best_inliers
		F = Fh;
		best_inliers = inliers;
        in1 = inliers1;
        in2 = inliers2;
        out1 = outliers1;
        out2 = outliers2;
		GoodPoints = rand_num;
    end
    p = 1 - (1 - (inliers\num_pts)^8)^i;
    if p > 0.99
        m = i;
        break;
    end
end
end


