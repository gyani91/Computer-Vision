function particles_new = propagate(particles, sizeFrame, params)
    if params.model==1
        % constant velocity motion model
        A = [[1,0]',[0,1]',[1,0]',[0,1]']; 
    else
        % just noise
        A = [1 0;0 1];
    end

    particles_new = zeros(params.num_particles, size(particles(1,:),2));
    i = 1;
    while i <= params.num_particles
        particles_new(i,1:2) = floor((A*particles(i,:)')' + normrnd(0,params.sigma_position,[1 2]));
        if (particles_new(i,1) < sizeFrame(2) && particles_new(i,1) > 0 && particles_new(i,2) < sizeFrame(1) && particles_new(i,2) > 0)
            if (params.model==1)
                particles_new(i,3:4) = params.initial_velocity + normrnd(0,params.sigma_velocity,[1 2]);
            end
            i = i + 1;
        end
    end
end