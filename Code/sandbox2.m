% R1 = [0 0 1; -1 0 0; 0 -1 0];
% Ta = blkdiag(R1,1); % The camera frame z-axis points forward and y-axis points down
% Tb = eye(4);
% syms x y z
% t = [x; y; z; 1]
% po = Tb*Ta*t
% 
% estimator = pose_estimator;
% 
img = imread("test.png");
% coords = estimate(estimator, img)

cam_data = load("calibration/camera_params.mat");
intrinsics = cam_data.params.Intrinsics;
tag_size = 0.07; %tag size in m
img = undistortImage(img, intrinsics, OutputView="same");
[id, loc, pose] = readAprilTag(img, "tag36h11", intrinsics, tag_size);
%save pose.mat pose
% pose.R
% pose.Translation
% pose.A
% loc

R1 = [0 0 1; -1 0 0; 0 -1 0];
Ta = blkdiag(pose.R,1) % The camera frame z-axis points forward and y-axis points down
Tb = eye(4);

t = pose.Translation/1000; %convert from m to mm
po = [t(:); 1];
p = Tb*Ta*po

