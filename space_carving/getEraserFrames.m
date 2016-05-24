addpath(genpath('functions'));

% Define images to process
imageFileNames = {'eraser/IMG_0031.jpg',...
    'eraser/IMG_0032.jpg',...
    'eraser/IMG_0033.jpg',...
    'eraser/IMG_0034.jpg',...
    'eraser/IMG_0035.jpg',...
    'eraser/IMG_0036.jpg',...
    'eraser/IMG_0037.jpg',...
    'eraser/IMG_0038.jpg',...
    'eraser/IMG_0039.jpg',...
    'eraser/IMG_0041.jpg',...
    'eraser/IMG_0042.jpg',...
    'eraser/IMG_0043.jpg',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 1;  % in units of 'in'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'in', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', []);

frames = createFramesArray(imageFileNames, cameraParams);
save('eraser_frames.mat', 'frames');