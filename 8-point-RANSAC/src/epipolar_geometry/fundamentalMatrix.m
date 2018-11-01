% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences
%
% Output
% 	Fh 			Fundamental matrix with the det F = 0 constraint
% 	F 			Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatrix(x1s, x2s)
s = size(x1s, 2);
[x1, T1] = normalizePoints2d(x1s);
[x2, T2] = normalizePoints2d(x2s);
x1=[x1(1,:)' x1(2,:)'];  
x2=[x2(1,:)' x2(2,:)'];

% Af=0 
A=[x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2) x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2), ones(s,1)];

% Get F matrix
[U D V] = svd(A);
F=reshape(V(:,9), 3, 3)';
% contraint
[U D V] = svd(F);
Fh=U*diag([D(1,1) D(2,2) 0])*V';
% Denormalize
Fh = T2'*Fh*T1;
% Denormalize
F = T2'*F*T1;
end