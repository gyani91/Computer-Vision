function meanState = estimate(particles, particles_w)
    length = size(particles(1,:),2);
    for i=1:length
        meanState(i) = sum(particles(:,i).*particles_w);
    end
end