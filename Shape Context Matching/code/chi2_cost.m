function [C] = chi2_cost(s1,s2)
    % This function computes a cost matrix between two sets of shape context descriptors.
    
    K = (size(s1,2));
    C = zeros(size(s1,1),size(s2,1));
    
    for i = 1:size(s1,1)
        for j = 1:size(s2,1)
            for k = 1:K
                C(i,j) = C(i,j) + ((s1(i,k)-s2(j,k))^2/(s1(i,k)+s2(j,k)+0.00001)/2);
            end
        end
    end
end

