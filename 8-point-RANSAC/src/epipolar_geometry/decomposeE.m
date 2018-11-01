% Decompose the essential matrix
% Return P = [R|t] which relates the two views
% You will need the point correspondences to find the correct solution for P
function P = decomposeE(E, x1, x2, K)
% SVD of E
[U,S,V] = svd(E);

%W
W = [0,-1,0;1,0,0;0,0,1];        

PXcam = zeros(3,4,4);
R1 = U*W*V';
R2 = U*W'*V';
T1 = U(:,3);
T2 = -U(:,3);

% 4 solutions
PXcam(:,:,1) = [R1, T1];
PXcam(:,:,2) = [R1, T2];
PXcam(:,:,3) = [R2, T1];
PXcam(:,:,4) = [R2, T2];

% Choosing the correct one
% Two matching points in image coordinates (x in image 1 and xp in
    % image 2)
    x = x1(:,1);
    xp = x2(:,2);
  
    % The first camera matrix is taken P = [I|0] and the other 
    Pcam = [eye(3),zeros(3,1)];
    P = K*Pcam;
    xhat = inv(K)*x;
      
    
    % For each camera matrix (Pxcam), reproject the pair of points in 3D
    % and determine the depth in 3D of the point
    X3D = zeros(4,4);
    Depth = zeros(4,2);
    for i=1:4
        
        % First the point is converted
        xphat = inv(K)*xp;

        % We build the matrix A
        A = [Pcam(3,:).*xhat(1,1)-Pcam(1,:);
             Pcam(3,:).*xhat(2,1)-Pcam(2,:);
             PXcam(3,:,i).*xphat(1,1)-PXcam(1,:,i);
             PXcam(3,:,i).*xphat(2,1)-PXcam(2,:,i)];
        
        % Normalize A
        A1n = sqrt(sum(A(1,:).*A(1,:)));
        A2n = sqrt(sum(A(2,:).*A(2,:)));
        A3n = sqrt(sum(A(1,:).*A(1,:)));
        A4n = sqrt(sum(A(1,:).*A(1,:))); 
        Anorm = [A(1,:)/A1n;
                 A(2,:)/A2n;
                 A(3,:)/A3n;
                 A(4,:)/A4n];
             
        % Obtain the 3D point
        [Uan,San,Van] = svd(Anorm);
        X3D(:,i) = Van(:,end);
        
        % Check depth on second camera
        xi = PXcam(:,:,i)*X3D(:,i);
        w = xi(3);
        T = X3D(end,i);
        m3n = sqrt(sum(PXcam(3,1:3,i).*PXcam(3,1:3,i)));
        Depth(i,1) = (sign(det(PXcam(:,1:3,i)))*w)/(T*m3n);
        
        % Check depth on first camera
        xi = Pcam(:,:)*X3D(:,i);
        w = xi(3);
        T = X3D(end,i);
        m3n = sqrt(sum(Pcam(3,1:3).*Pcam(3,1:3)));
        Depth(i,2) = (sign(det(Pcam(:,1:3)))*w)/(T*m3n);
         
    end

    % Check which solution is the right one and return
    if(Depth(1,1)>0 && Depth(1,2)>0)
        P = PXcam(:,:,1);
    elseif(Depth(2,1)>0 && Depth(2,2)>0)
        P = PXcam(:,:,2);    
    elseif(Depth(3,1)>0 && Depth(3,2)>0)
        P = PXcam(:,:,3);
    elseif(Depth(4,1)>0 && Depth(4,2)>0)
        P = PXcam(:,:,4);
    end
end