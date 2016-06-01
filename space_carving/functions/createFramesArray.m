function [ frames ] = createFramesArray(image_paths, camera_params, worldPoints)
%CREATEVIEWSFILE Summary of this function goes here
%   Detailed explanation goes here

N = size(image_paths, 2);

ims = cell(1,N);
Ps = cell(1,N);
Ks = cell(1,N);
Rs = cell(1,N);
Ts = cell(1,N);
sils = cell(1,N);
for i = 1:N
%     ims{1,i} = undistortImage(imread(image_paths{1,i}), camera_params);
%     % Find reference object in new image.
%     [imagePoints, ~] = detectCheckerboardPoints(ims{1,i});
% 
%     % Compute new extrinsics.
%     [rotationMatrix, translationVector] = extrinsics(imagePoints, worldPoints, camera_params);
% 
%     % Calculate camera matrix
%     P = cameraMatrix(camera_params, rotationMatrix, translationVector);
    ims{1,i} = imread(image_paths{1,i});
    Rs{1,i} = -camera_params.RotationMatrices(:,:,i)';
    Ts{1,i} = -camera_params.TranslationVectors(i,:)';
    Ks{1,i} = camera_params.IntrinsicMatrix';
    Ps{1,i} = cameraMatrix(camera_params, camera_params.RotationMatrices(:,:,i), camera_params.TranslationVectors(i,:))';
%     Ks{1,i} * horzcat(Rs{1,i}, Ts{1,i});
end
frames = struct('image', ims, 'P', Ps, 'K', Ks, 'R', Rs, 'T', Ts, 'silhouette', sils);
end

