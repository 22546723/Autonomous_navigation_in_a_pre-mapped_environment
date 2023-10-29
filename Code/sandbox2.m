cam_intrinsics = load('Camera_calibration/new_params.mat');
intrinsics = cam_intrinsics.params.Intrinsics;

data = load("marker_test.mat", "data");
data = data.data;

id = data.id;
loc = data.loc;
pose = data.pose;
gotMarker = data.gotMarker;
x = data.x;
y = data.y;

n = 1501;   %t = 1.5 sec
A = pose.Data(:, :, n);
img_coords = loc.Data(:, :, n);
tform = rigidtform3d(A);
t = tform.Translation; %/1000   %convert mm to m?
marker_coord = [-1.5, 0.04 0];  %check
car_len = 0.5;                  %check

act_points = [x.Data(n), y.Data(n)]

R1 = [0 0 -1; -1 0 0; 0 -1 0];  %translate coord systems -> check
Ta = blkdiag(R1,1); 
Tb = eye(4);


po = [t(:); 1];
p = Tb*Ta*po;
meas = p(1:3).'
coord = marker_coord - meas


