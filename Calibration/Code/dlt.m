function [P_normalized] = dlt(xy_normalized, XYZ_normalized)
%computes DLT, xy and XYZ should be normalized before calling this function
num_points = size(xy_normalized,2);
A = [];
for i=1:num_points
    A = [A;
       xy_normalized(3,i)*XYZ_normalized(:,i)' 0 0 0 0 -xy_normalized(1,i)*XYZ_normalized(:,i)';
       0 0 0 0 -xy_normalized(3,i)*XYZ_normalized(:,i)' xy_normalized(2,i)*XYZ_normalized(:,i)'];
end

[~,~,V] = svd(A);
P_normalized = V(:,12);
P_normalized = reshape(P_normalized, 4, 3)';
P_normalized = P_normalized./P_normalized(3,4);
end

