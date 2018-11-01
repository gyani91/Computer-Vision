% Normalization of 2d-pts
% Inputs: 
%           xs = 2d points
% Outputs:
%           nxs = normalized points
%           T = 3x3 normalization matrix
%               (s.t. nx=T*x when x is in homogenous coords)
function [nxs, T] = normalizePoints2d(xs)
%data normalization
num_points = size(xs,2);
%first compute centroid
xy_centroid=mean(xs,2);

%then, compute scale
distance_ip = ones(1,num_points);

for i=1:num_points
    distance_ip(i)=sqrt((xs(1,i)-xy_centroid(1))^2+(xs(2,i)-xy_centroid(2))^2);
end

average_ip=mean(distance_ip);

scaled_ip=sqrt(2)/average_ip;

%create T and U transformation matrices
T = [scaled_ip 0 -scaled_ip*xy_centroid(1);
    0 scaled_ip -scaled_ip*xy_centroid(2);
    0 0 1];

%and normalize the points according to the transformations
nxs = T*xs;
end
