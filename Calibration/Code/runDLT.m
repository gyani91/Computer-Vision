function [K, R, t, error] = runDLT(xy, XYZ)

IMG_NAME = 'images_my_camera/IMG_6.jpg';

%normalize data points
num_points = size(xy,2);
xy = [xy; ones(1,num_points)];
XYZ = [27*XYZ; ones(1,num_points)];

[xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ);

%compute DLT
[P_normalized] = dlt(xy_normalized, XYZ_normalized);

%denormalize camera matrix
P = inv(T)*P_normalized*U;
P = P./P(3,4);

%factorize camera matrix in to K, R and t
M = P(:,1:3);
[R K] = qr(inv(M));
R = inv(R);
K = inv(K);
K = K./K(3,3);

[~,~,V]=svd(P);
C = V(4,:)';
C = C/C(4,1);

t = -R*C(1:3);

%compute reprojection error
xy_reproj = P*XYZ;
xy_reproj = xy_reproj./xy_reproj(3,:);

error=mean((xy_reproj-xy).^2,2);

AP=[];
for i=0:6
    for k=0:9
        temp=[27*i 0 27*k 1]';
        AP = [AP temp];
    end
end
for j=0:7
    for k=0:9
        temp=[0 27*j 27*k 1]';
        AP = [AP temp];
    end
end

all_points = P*AP;
all_points = all_points./all_points(3,:);

%visualize reprojected points
figure;
imshow(IMG_NAME);
hold on;
for i=1:num_points
    scatter(xy(1,i), xy(2,i), 50, 'r','filled');
    scatter(xy_reproj(1,i), xy_reproj(2,i), 70, 'b');
end
for i=1:150
    scatter(all_points(1,i), all_points(2,i), 70, 'g');
end
hold off;

end