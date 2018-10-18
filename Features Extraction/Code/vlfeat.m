function [matches, fa, fb, da, db] = vlfeat(img1,img2,peak_thresh)
    % Extracting frames and descriptors
    Ia = single(img1);
    Ib = single(img2);

    %Features and Descriptors
    [fa, da] = vl_sift(Ia,'PeakThresh', peak_thresh);
    [fb, db] = vl_sift(Ib,'PeakThresh', peak_thresh);

    % Matching
    [matches, ~] = vl_ubcmatch(da, db);
end
