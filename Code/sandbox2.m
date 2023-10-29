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

m_check = 0;
t = 0;
n = 1;
% 
% while m_check==0
%     if gotMarker.Data(n)==1
%         m_check = 1;
%         t = n;
%     else
%         n = n+1;
%     end
% end

A = pose.Data(:, :, 36);
img_coords = loc.Data(:, :, 36);
tform = rigidtform3d(A);
marker_coord = [-4 0.04];

tag_size = 0.1;

act_points = [x.Data(36), y.Data(36)]
% 
% ym = (min(img_coords(:, 2)) + max(img_coords(:, 2)))/2;
% xm = (min(img_coords(:, 1)) + max(img_coords(:, 1)))/2;
% 
% % u = ym;
% % v = xm;
% % w = 0;
% coords = [1683.87145996094,	1557.64196777344;
% 1593.36523437500,	1557.62780761719;
% 1591.03442382813,	1573.48950195313;
% 1685.92846679688,	1572.92797851563];

temp = img2world2d(img_coords, tform, intrinsics);
x_c = (min(temp(:, 1)) + max(temp(:, 1)))/2;
y_c = (min(temp(:, 2)) + max(temp(:, 2)))/2;
coords = [y_c, x_c]

% meas_coords = A * [xm; ym; 0; 1]
% 
% x_pos = marker_coord(1) + meas_coords(2);
% y_pos = marker_coord(2) + meas_coords(1);
% pos = [x_pos, y_pos]

