close all; clear;
load('../data/params.mat');

params.num_particles = 300;
params.hist_bin = 8;

% trial 1: video 1 - no motion
params.model = 0;
condensationTracker('video1',params);

% trial 2: video 1 - constant velocity
params.model = 1;
condensationTracker('video1',params);

% trial 3: video 2 - no motion
params.model = 0;
condensationTracker('video2',params);

params.sigma_velocity = 1;
params.sigma_position = 15;
params.sigma_observe = 0.2;
params.initial_velocity = [8,0];
params.model = 1;

% trial 4: video 2 - constant motion
condensationTracker('video2',params);

% trial 5: video 3 - constant motion
condensationTracker('video3',params);

params.sigma_observe = 0.5;
params.initial_velocity = [10,0];
params.sigma_velocity = 1;

% trial 6: video 3 - constant motion with sigma_observe increased
condensationTracker('video3',params);

% trial 7: video 3 - no motion
params.model = 0;
condensationTracker('video3',params);