function [ frames ] = createFramesArray(image_paths, camera_params)
%CREATEVIEWSFILE Summary of this function goes here
%   Detailed explanation goes here

N = size(image_paths, 2);

ims = cell(1,N);
Ps = cell(1,N);
Ks = cell(1,N);
Rs = cell(1,N);
Ts = cell(1,N);
sils = cell(1,N);
K = camera_params.IntrinsicMatrix';
for i = 1:N
    ims{1,i} = imread(image_paths{1,i});
    R = camera_params.RotationMatrices(:,:,i)';
    Rs{1,i} = R;
    T = camera_params.TranslationVectors(i,:)';
    Ts{1,i} = T;
    E = horzcat(R, T);
    Ps{1,i} = K*E;
    Ks{1,i} = K;
end
frames = struct('image', ims, 'P', Ps, 'K', Ks, 'R', Rs, 'T', Ts, 'silhouette', sils);
end

