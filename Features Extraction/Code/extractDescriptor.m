% extract descriptor
%
% Input:
%   keyPoints     - detected keypoints in a 2 x n matrix holding the key
%                   point coordinates
%   img           - the gray scale image
%   
% Output:
%   descr         - w x n matrix, stores for each keypoint a
%                   descriptor. m is the size of the image patch,
%                   represented as vector
function descr = extractDescriptor(corners, img)
numKeyPoints = size(corners,2);
descr = zeros(81, numKeyPoints);
for i=1:numKeyPoints
    A = img((corners(1,i) - 4 : corners(1,i) + 4) , (corners(2,i) - 4 : corners(2,i) + 4));
    descr(:,i) = reshape(A,[81,1]);
end
end