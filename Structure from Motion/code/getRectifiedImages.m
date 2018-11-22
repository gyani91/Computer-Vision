function [imgRectL, imgRectR, Hleft, Hright, maskL, maskR] = getRectifiedImages(imgL,imgR)

% extract features

Ia = single(imgL);
Ib = single(imgR);
peak_thresh = 0.033;

%Features and Descriptors
[x1s, descr1] = vl_sift(Ia,'PeakThresh', peak_thresh);
[x2s, descr2] = vl_sift(Ib,'PeakThresh', peak_thresh);

x1s = [x1s(1:2,:); ones(1, size(x1s, 2))];
x2s = [x2s(1:2,:); ones(1, size(x2s, 2))];

% [matches] = siftmatch(descr1, descr2);
[matches, ~] = vl_ubcmatch(descr1, descr2);

% compute F
[F, inliers] = fundamentalMatrixRANSAC(x1s(:, matches(1,:)), x2s(:, matches(2,:)));

% using F, compute the rectified images with the code provided
[imgRectL, imgRectR, Hleft, Hright, maskL, maskR] = rectifyImages(imgL, imgR, [x1s(1:2, matches(1, inliers))', x2s(1:2, matches(2, inliers))'], F);
