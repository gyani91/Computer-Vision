% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - 2 x k matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength
function [corners, H] = extractHarrisCorner(img, thresh)
    % Compute intensity gradients in x and y direction
    % [Ix,Iy] = gradient(img);

    % Blur images to get rid of noise
    % F = fspecial('gaussian',30,2);
    % img = imfilter(img, F, 'replicate');
    % imshow(img');

    k = 0.04;
    sigma = 1;
    halfwid = sigma * 3;

    [xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);

    Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

    Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
    Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

    numOfRows = size(img, 1);
    numOfColumns = size(img, 2);

    % Compute Harris response

    Ix = conv2(Gx, img);
    Iy = conv2(Gy, img);

    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;

    Sx2 = conv2(Gxy, Ix2);
    Sy2 = conv2(Gxy, Iy2);
    Sxy = conv2(Gxy, Ixy);

    im = zeros(numOfRows, numOfColumns);
    for x=1:numOfRows
       for y=1:numOfColumns
           % Define at each pixel(x, y) the matrix H
           H = [Sx2(x,y) Sxy(x,y); Sxy(x,y) Sy2(x,y)];

           % Compute the response of the detector at each pixel
           R = det(H) - k * (trace(H) ^ 2);

           % Threshold on value of R
           if (R > thresh)
              im(x,y) = R;
           end
       end
    end

    patch = ones(7);
    patch(4,4)=0;

    % Non-Maximum-Suppression
    output = im > imdilate(im, patch);
    %output = im ~= 0; % if you do not want to use NMS
    corners = [];

    for x=1:numOfRows
       for y=1:numOfColumns
           if output(x,y)
               corners = [corners [x y]'];
           end
       end
    end
end