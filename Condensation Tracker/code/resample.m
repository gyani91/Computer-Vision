function [particles, particles_w] = resample(particles, particles_w)
    num_particles = size(particles,1);
    indices = randsample(num_particles,num_particles,true,particles_w);
    particles = particles(indices,:);
    particles_w = particles_w(indices);
    % normalization
    sum_w=sum(particles_w);
    particles_w(:)=particles_w(:)./sum_w;
end