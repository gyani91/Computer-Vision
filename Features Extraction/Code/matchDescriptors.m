% match descriptors
%
% Input:
%   descr1        - k x n descriptor of first image
%   descr2        - k x m descriptor of second image
%   thresh        - scalar value to threshold the matches
%   
% Output:
%   matches       - 2 x w matrix storing the indices of the matching
%                   descriptors
function matches = matchDescriptors(descr1, descr2, thresh)
    sz1 = size(descr1,2);
    sz2 = size(descr2,2);
    
    % allowed ratio with the second best point
    ratio = 0.8;
    
    pos = zeros(1,sz1);
    
    for i=1:sz1
        %set min
        min  = sum((descr1(:,i) - descr2(:,1)).^2);
        min2 = sum((descr1(:,i) - descr2(:,1)).^2);
        pos(1,1) = 0;

        for j=2:sz2
            %distance
            dist = sum((descr1(:,i) - descr2(:,j)).^2);
            %check threshold, replace closest and second closest
            if min > dist && dist < thresh
               min2 = min;
               min = dist;
               pos(1,i) = j;
            end
        end
        % discard if doesn't pass ratio validation
        validation = min / min2;
        if validation > ratio
           pos(1,i) = 0;
        end
    end
    matches=[];
    for i=1:sz1
        if pos(1,i) ~= 0
            matches = [matches [i,pos(1,i)]'];
        end
    end  
end