function [mapMS, peak] = meanshiftSeg(X, radius, img)
X = X';
threshold = 0.001;
sigma = 1;

BefShift = X;
max_dist = Inf;

% Set up Neighbor function and Kernel function
Neighbor = @(x) (BallNeighbor(x, radius, 0));

% Kernel function
Kernel = @(x) (GaussKernel(x, sigma, 0));

i = 0; % Iteration count

% Stop iteration if max movement is within the threshold
while sqrt(max_dist) > threshold 
    % Shift each point to the center of its mode
    [AftShift, peak_unmerged, mapMS_unmerged]= Shift_Meanshift(BefShift, Neighbor, Kernel);
    % Calculate the distance each point moves, and picks out the maximum
    dist = VecNorm2Sq(AftShift - BefShift);
    max_dist = max(dist);
    % Iterate on moved data points
    BefShift = AftShift;
    i = i + 1;
end

N = size(AftShift, 2);
Out = zeros(1,N);
index = 0;
peak = [];

radius_half = radius/2;

for i = 1:N
    if Out(i)
        continue
    end
    index = index + 1;
    Out(i) = index;
    notset = ~Out((i+1):N);
    inball = (VecNorm2Sq(AftShift(:,(i+1):N)-AftShift(:, i)) < radius_half.^2);
    flag = notset & inball;
    Out((i+1):N) = Out((i+1):N) + flag .* index;
    peak = [peak AftShift(:,i)];
end

[sz1,sz2,~] = size(img);
mapMS = Ary2Img(Out, [sz1 sz2]);
end

function [Out, peak, mapMS] = Shift_Meanshift(In, Neighbor, Kernel)
N = size(In, 2); 
Out = zeros(size(In));
mapMS = zeros(1,N);

% Flag of each data point of whether being moved
filled = zeros(1,N, 'logical');
peak = [];
index =0;
for i = 1:N % For each data point
    if filled(i)
        continue % Skip if already moved
    end
    filled(i) = 1;
    index = index + 1;
    Ni = Neighbor(In - In(:,i)); % Entries within the mode
    k = sum(Ni);                % Count # of entries
    Ni = Ni .* (1:N);           % Assign indexies in the array
    Ni( :, ~any(Ni,1) ) = [];   % Remove zero columns
    NNi = In(:, Ni);            % Find out the neighbor set
    Diff = (NNi - In(:,i));     % Difference to the current data point
    KernDiff = Kernel(Diff);    % Calculate their weight in the mode
    % Sum up their mass
    SumMass = sum(KernDiff .* NNi, 2); % MxN -> Mx1
    % Sum up the weight
    SumKern = sum(KernDiff); % 1xN -> 1x1    
    NewPos = SumMass ./ SumKern; % New center
    % Set position of all points within the mode to the center of the mode
    Out(:,Ni) = repmat(NewPos, 1, k);
    mapMS(1,Ni) = repmat(index, 1, k);
    peak = [peak NewPos];
    % Mark all inliers as "moved"
    filled(Ni) = 1;
end
end

function [ Out ] = BallNeighbor(In, dist, x0)
Out = VecNorm2Sq(In - x0) < dist.^2;
end

function [ Out ] = GaussKernel(In, sigma, x0)
x = VecNorm2Sq(In-x0);
Out = exp(-x./(2.*sigma.^2));
end