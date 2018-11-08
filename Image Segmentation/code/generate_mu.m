% Generate initial values for mu
% K is the number of segments
function mu = generate_mu(K)
    mu = zeros(3,K);
    for i=1:K
        mu(:,i) = floor(rand(3,1) * 255);
    end
end