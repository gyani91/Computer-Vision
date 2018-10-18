function [xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ)

%data normalization
num_points = size(xy,2);
%first compute centroid
xy_centroid=mean(xy,2);
XYZ_centroid=mean(XYZ,2);

%then, compute scale
distance_ip = ones(1,num_points);

for i=1:num_points
    distance_ip(i)=sqrt((xy(1,i)-xy_centroid(1))^2+(xy(2,i)-xy_centroid(2))^2);
end

distance_op = ones(1,num_points);

for i=1:num_points
    distance_op(i)=sqrt((XYZ(1,i)-XYZ_centroid(1))^2+(XYZ(2,i)-XYZ_centroid(2))^2+(XYZ(3,i)-XYZ_centroid(3))^2);
end

average_ip=mean(distance_ip);
average_op=mean(distance_op);

scaled_ip=sqrt(2)/average_ip;
scaled_op=sqrt(3)/average_op;

%create T and U transformation matrices
T = [scaled_ip 0 -scaled_ip*xy_centroid(1);
    0 scaled_ip -scaled_ip*xy_centroid(2);
    0 0 1];

U = [scaled_op 0 0 -scaled_op*XYZ_centroid(1);
    0 scaled_op 0 -scaled_op*XYZ_centroid(2);
    0 0 scaled_op -scaled_op*XYZ_centroid(3);
    0 0 0 1];

%and normalize the points according to the transformations
xy_normalized = T*xy;
XYZ_normalized = U*XYZ;

end