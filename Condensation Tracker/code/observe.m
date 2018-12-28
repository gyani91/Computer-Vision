function particles_w = observe(particles,frame,H,W,hist_bin,hist_target,sigma_observe)
    num_particles = size(particles,1);
    particles_w = zeros(num_particles,1);
    for i=1:num_particles
        hist_pred = color_histogram(particles(i,1)-0.5*W,particles(i,2)-0.5*H,particles(i,1)+0.5*W,particles(i,2)+0.5*H,frame,hist_bin);
        dist = chi2_cost(hist_pred, hist_target);
        particles_w(i,1) = (1/(sqrt(2*pi)*sigma_observe))*exp(-dist/2*sigma_observe^2);
    end
    sum_w=sum(particles_w);
    particles_w(:)=particles_w(:)./sum_w;
end