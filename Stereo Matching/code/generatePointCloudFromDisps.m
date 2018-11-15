function coords = generatePointCloudFromDisps(dispStereoL, PL, PR)
    
% for each pixel (x,y) find the corresponding 3D point

coords = zeros([size(dispStereoL) 3]);

for x=1:size(dispStereoL,1)
    for y=1:size(dispStereoL,2)
        coords(x,y,:) = linTriang([x,y], [x+dispStereoL(x,y),y], PL, PR);
    end
end
