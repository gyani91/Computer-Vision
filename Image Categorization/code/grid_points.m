function vPoints = grid_points(img,nPointsX,nPointsY,border)
    height = size(img, 1);
    width = size(img, 2);
    
    stepX = floor((height-(2*border)-1)/(nPointsX-1));
    stepY = floor((width-(2*border)-1)/(nPointsY-1));
    
    X = (border+1:stepX:height-border);
    Y = (border+1:stepY:width-border);
    
    vPoints = zeros(nPointsX*nPointsY,2);
    idx = 1;
    for i=1:nPointsX
        for j=1:nPointsY
           vPoints(idx,:) = [X(i) Y(j)];
           idx = idx + 1;
        end
    end
end
