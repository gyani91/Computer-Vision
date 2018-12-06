function [d] = sc_compute(X,nbBins_theta,nbBins_r,smallest_r,biggest_r)
    % This function computes the shape context descriptors for a set of points
    % INPUTS :
    % set of points, X
    % number of bins in the angular dimension, nbBins_theta
    % number of bins in the radial dimension, nbBins_r
    % the length of the smallest radius, smallest_r
    % the length of the biggest radius, biggest_r
    %
    % OUTPUTS :
    % shape context descriptors for all input points, d
    X = X';
    nc = mean2(sqrt(dist2(X,X)));  

    smallest_r = smallest_r*nc;
    biggest_r = biggest_r*nc;

    size_theta = 360/nbBins_theta ;
    delta_r(1) = smallest_r ;
    
    for i = 1:nbBins_r
        delta_r(i+1) =  exp(log(smallest_r) + (log(biggest_r) - log(smallest_r))*i/nbBins_r);
    end

    d = zeros(max(size(X)), size_theta*nbBins_r);
 
    for i = 1:size(X,1)
        for j = 1:size(X,1)
            distance_r = norm(X(i,:)-X(j,:));
            if  (distance_r < biggest_r && distance_r > smallest_r)
                delta_x = X(j,1) - X(i,1) ;
                delta_y = X(j,2) - X(i,2) ;
                theta = rad2deg(atan2(delta_y,delta_x));
                if theta<0
                    theta = 360 + theta;
                end
                
                theta_index = ceil(theta/nbBins_theta);
                
                if theta_index == 0 
                    theta_index = 1;
                end
                r_index = max(find(distance_r >= delta_r));
                d(i,theta_index + (r_index-1)*size_theta) = ...
                                            d(i,theta_index + (r_index-1)*size_theta)+1; 
            end
        end
    end
end
