% % Determines the camera intrinsics
% 
% downloadURL  = "https://github.com/AprilRobotics/apriltag-imgs/archive/master.zip";
% dataFolder   = fullfile(tempdir,"apriltag-imgs",filesep); 
% options      = weboptions('Timeout', Inf);
% zipFileName  = fullfile(dataFolder,"apriltag-imgs-master.zip");
% folderExists = exist(dataFolder,"dir");
% 
% % Create a folder in a temporary directory to save the downloaded file.
% if ~folderExists  
%     mkdir(dataFolder); 
%     disp("Downloading apriltag-imgs-master.zip (60.1 MB)...") 
%     websave(zipFileName,downloadURL,options); 
%     
%     % Extract contents of the downloaded file.
%     disp("Extracting apriltag-imgs-master.zip...") 
%     unzip(zipFileName,dataFolder); 
% end

% Set the properties of the calibration pattern.
tagArrangement = [5,8];
tagFamily = "tag36h11";
% 
% % Generate the calibration pattern using AprilTags.
% tagImageFolder = fullfile(dataFolder,"apriltag-imgs-master",tagFamily);
% imdsTags = imageDatastore(tagImageFolder);
% calibPattern = helperGenerateAprilTagPattern(imdsTags,tagArrangement,tagFamily);

% Read and localize the tags in the calibration pattern.
calibPattern = imread("april_board.png");
[tagIds, tagLocs] = readAprilTag(calibPattern,tagFamily);

% Sort the tags based on their ID values.
[~, sortIdx] = sort(tagIds);
tagLocs = tagLocs(:,:,sortIdx);

% Reshape the tag corner locations into an M-by-2 array.
tagLocs = reshape(permute(tagLocs,[1,3,2]),[],2);

% Convert the AprilTag corner locations to checkerboard corner locations.
checkerIdx = helperAprilTagToCheckerLocations(tagArrangement);
imagePoints = tagLocs(checkerIdx(:, 1:5),:);


% Create an imageDatastore object to store the captured images.
imdsCalib = imageDatastore("frames/");
%imgCalib = imread("Screenshot from calib.avi - 3.png");

% Detect the calibration pattern from the images.
[imagePoints,boardSize] = helperDetectAprilTagCorners(imdsCalib,tagArrangement,tagFamily);

% Generate world point coordinates for the pattern.
tagSize = 16; % in millimeters
worldPoints = generateCheckerboardPoints(boardSize, tagSize);

% Determine the size of the images.
%I = readimage(imdsCalib,1);
imageSize = size(imdsCalib,1:2);

% Estimate the camera parameters.
params = estimateCameraParameters(imagePoints,worldPoints,ImageSize=imageSize);
