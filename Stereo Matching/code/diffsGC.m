function diffs = diffsGC(img1, img2, dispRange, windowsize)
    % Read image sizes and pad if not of the same size
    
    [heightL, widthL, ~] = size(img1);
    [heightR, widthR, ~] = size(img2);
    
    if widthL > widthR
        widthR = widthL;
        img2(:,end+1:widthL,:) = 0;
    elseif widthR > widthL
        widthL = widthR;
        img1(:,end+1:widthR,:) = 0;
    end
    
    if heightL > heightR
        heightR = heightL;
        img2(end+1:heightL,:,:) = 0;
    elseif heightR > heightL
        heightL = heightR;
        img1(end+1:heightR,:,:) = 0;
    end
    
    % Initialization

    diffs = zeros([size(img1), length(dispRange)]);

    % For each disparity d
    for i=1:length(dispRange)
        d = dispRange(i); 
        imgShifted = shiftImage(img2,d); % Shift entire image by d
        SSD = (img1 - imgShifted).^2; % Compute image difference (SSD)
        diffs(:,:,i) = conv2(SSD,fspecial('average',windowsize),'same');
    end
end