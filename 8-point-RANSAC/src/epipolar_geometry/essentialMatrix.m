% Compute the essential matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xn matrices
%
% Output
% 	Eh 			Essential matrix with the det F = 0 constraint and the constraint that the first two singular values are equal
% 	E 			Initial essential matrix obtained from the eight point algorithm
%

function [Eh, E] = essentialMatrix(x1s, x2s, K)
s = size(x1s, 2);

K_inv = inv(K);
x1s = K_inv*x1s;
x2s = K_inv*x2s;
[x1, T1] = normalizePoints2d(x1s);
[x2, T2] = normalizePoints2d(x2s);
x1=[x1(1,:)' x1(2,:)'];
x2=[x2(1,:)' x2(2,:)'];

% Af=0 
A=[x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2) x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2), ones(s,1)];

% Get E matrix
[U D V] = svd(A);
E=reshape(V(:,9), 3, 3)';
% contraint
[U D V] = svd(E);
Eh=U*diag([1 1 0])*V';
% Denormalize
Eh = T2'*Eh*T1;
end
