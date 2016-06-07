%% SETUP
clear all; close all; clc;
addpath(genpath('functions'));

% Load the data
object = 'bluebowl2';
segmentation = 'kmeans';
load(sprintf('%s_frames.mat', object));

partE = 0; % change to 1 for part E
%% PART A: Generate the silhouette for each image
for c=1:numel(frames)
    if partE
        frames(c).silhouette = frames(c).trueSilhouette;
    else
        frames(c).silhouette = generateSilhouette( frames(c).image );
    end
end

%% Plot the silhouette to make sure that we did it correctly.
figure();
i = 8;
subplot(1,2,1);
imshow( frames(i).image  );
title( 'Image' );
axis off;

subplot(1,2,2);
imshow( generateSilhouette( frames(i).image ) );
title( 'Silhouette' );
axis off;
%% PART B: Generate the voxel grid
% Find an estimate of the bounds of the object we are about to carve
num_voxels = 6000000; % decrease number of voxels for easier debugging
[xlim,ylim,zlim] = getVoxelBounds( frames , partE);
voxels = formInitialVoxels( [10., 15.], [0., 5.], [-5., 5.], num_voxels);
starting_volume = size(voxels);

% Show the whole scene
figure();

plotCamerasAndSurf( frames, voxels );
%% Part C: Test out the first carving
voxels = carve( voxels, frames(8) );

% Show Result
figure();

plotCamerasAndSurf( frames(1), voxels );
title( 'Result after 1 carving' )
%% Part D+E: Result after all carvings (remember to change variable in setup for part E)
num_voxels = 60000; % decrease number of voxels for easier debugging
initialVoxels = formInitialVoxels( [-15., 15.], [-10., 10.], [-10., 10.], num_voxels);
%%
for i = 1:1    
    voxels = initialVoxels;
    num_frames = 7;
    frames_to_use = frames(randsample(numel(frames), num_frames));
    for c=1:numel(frames_to_use)
        prev_voxels = voxels;
        voxels = carve( voxels, frames_to_use(c) );
        if size(voxels, 1) < 10
            voxels = prev_voxels;
        end
    end

    dir = sprintf('%s_%s_voxels/%d/%d', object, segmentation, num_voxels, num_frames);
    if ~exist(dir, 'dir')
        mkdir(sprintf('%s_%s_voxels', object, segmentation));
        mkdir(sprintf('%s_%s_voxels/%d', object, segmentation, num_voxels));
        mkdir(sprintf('%s_%s_voxels/%d/%d', object, segmentation, num_voxels, num_frames));
    end

    saveVoxels(voxels, sprintf('%s_%s_voxels/%d/%d/%d.voxels', object, segmentation, num_voxels, num_frames, randi(100000)));
    
    % Show Result
%     figure();
%     plotCamerasAndSurf( frames_to_use, voxels );
%     title( 'Result after all carvings' );
% 
    figure();
    plotSurface( voxels );
    title( 'Result after all carvings' );
end