function [matchingCostMatrix] = compute_matching_costs(objects,nsamp)

nobj = max(size(objects));
matchingCostMatrix = zeros(nobj);

for i = 1:nobj
    img1 = get_samples_1(objects(i).X,nsamp);
    %img1 = get_samples(objects(i).X,nsamp);
    for j = 1:nobj
        if i == j
            matchingCostMatrix(i,j) = inf;
            continue
        end
        img2 = get_samples_1(objects(j).X,nsamp);
        %img2 = get_samples(objects(j).X,nsamp);
        matchingCostMatrix(i,j) = shape_matching(img1,img2,false);
    end
end
imagesc(matchingCostMatrix)
end

