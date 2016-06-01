addpath(genpath('functions'));

% Define images to process
imageFileNames = {
    'redcap/1.jpg',...
    'redcap/2.jpg',...
    'redcap/3.jpg',...
    'redcap/4.jpg',...
    'redcap/5.jpg',...
    'redcap/6.jpg',...
    'redcap/7.jpg',...
    'redcap/8.jpg',...
    'redcap/9.jpg',...
    };
% 
% for k = 1:length(imageFileNames)
%     impath = imageFileNames{k};
%     resize_im = resizeImage(impath, 1024, 768);
%     out_path = sprintf('%s', impath);
%     imwrite(resize_im, out_path);
% end

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 0.866;  % in units of 'in'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'in', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', []);

frames = createFramesArray(imageFileNames, cameraParams, worldPoints);
save('redcap_frames.mat', 'frames');

figure; showExtrinsics(cameraParams,'patternCentric');