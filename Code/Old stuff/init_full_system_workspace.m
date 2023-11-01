file_name = "Maps/straight_line_test_setup";
load(file_name);

cam_intrinsics = load('calibration/camera_params.mat');
cam_intrinsics = cam_intrinsics.params.Intrinsics;