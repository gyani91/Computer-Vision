function hist = color_histogram(xMin,yMin,xMax,yMax,frame,hist_bin)
    xMin = floor(xMin);
    xMax = floor(xMax);
    yMin = floor(yMin);
    yMax = floor(yMax);
    sizeFrame = size(frame);
    H = zeros([hist_bin hist_bin hist_bin]);
    for i=xMin:xMax
        for j=yMin:yMax
            if (j <= sizeFrame(1) && j > 0 && i <= sizeFrame(2) && i > 0)
                q = double(reshape(frame(j,i,:), [1 3]));
                q = floor(q/(256/hist_bin)) + 1;
                H(q(1),q(2),q(3)) = H(q(1),q(2),q(3)) + 1;
            end
        end
    end
    hist = H(:);
end