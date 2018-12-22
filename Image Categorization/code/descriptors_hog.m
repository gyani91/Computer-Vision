function [descriptors,patches] = descriptors_hog(img,vPoints,cellWidth,cellHeight)
    nBins = 8;
    w = cellWidth; % set cell dimensions
    h = cellHeight;
    nCells = 4;

    nPoints = size(vPoints,1);
    descriptors = zeros(nPoints,nBins*4*4); % one histogram for each of the 16 cells
    patches = zeros(nPoints,4*w*4*h); % image patches stored in rows    
    
    [gradX,gradY]=gradient(img);
    angles = atan2(gradY,gradX);
    magnitudes = ((gradY.^2) + (gradX.^2)).^.5;
    
    for i = 1:nPoints % for all local feature points
        topCorner = vPoints(i,:)-[(nCells/2)*w, (nCells/2)*h];
        for cX = 0:nCells-1
            xDist = topCorner(1) + (cX * w);
            for cY = 0:nCells-1        
                yDist = topCorner(2) + (cY * h);
                xIdx = xDist : (xDist + w - 1);
                yIdx = yDist : (yDist + h - 1);
                cAngles = angles(xIdx, yIdx); 
                cMagnitudes = magnitudes(xIdx, yIdx);
                cDescriptors(cX + 1, cY + 1, :) = Histogram(cMagnitudes(:), cAngles(:), nBins);
            end
        end
        descriptors(i,:) = cDescriptors(:);
        patch = img(topCorner(1):(topCorner(1) + (nCells * w -1)),topCorner(2):(topCorner(2) + (nCells * h -1)));
        patches(i,:) = patch(:);
    end
end

function Hist = Histogram(magnitudes, angles, nBins)
    bSize = pi / nBins;
    min = 0;

    angles(angles < 0) = angles(angles < 0) + pi;
    leftIdx = round((angles - min) / bSize);
    rightIdx = leftIdx + 1;

    rightSide = angles - (((leftIdx - 0.5) * bSize) - min);
    leftSide = bSize - rightSide;
    rightSide = rightSide / bSize;
    leftSide = leftSide / bSize;

    leftIdx(leftIdx == 0) = nBins;
    rightIdx(rightIdx == (nBins + 1)) = 1;

    Hist = zeros(1, nBins);
    for i = 1:nBins
        pixels = (leftIdx == i);
        Hist(1, i) = Hist(1, i) + sum(leftSide(pixels)' * magnitudes(pixels));
        pixels = (rightIdx == i);
        Hist(1, i) = Hist(1, i) + sum(rightSide(pixels)' * magnitudes(pixels));
    end
end
