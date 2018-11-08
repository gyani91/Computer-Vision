% Generate initial values for the K
% covariance matrices

function cov = generate_cov(K)
    cov = zeros(3,3,K);
    for i=1:K
        cov(:,:,i) = diag([255 255 255]);
    end
end