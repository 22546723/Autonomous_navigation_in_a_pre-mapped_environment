cam_intrinsics = load('Camera_calibration/new_params.mat');
intrinsics = cam_intrinsics.params.Intrinsics;

data = load("marker_test.mat", "data");
data = data.data;

id = data.id.Data;
loc = data.loc.Data;
pose = data.pose.Data;
gotMarker = data.gotMarker.Data;
x = data.x.Data;
y = data.y.Data;

% len = length(gotMarker);
% marker_coord = [2 0 0.15]; 
% x_disp = zeros(len, 1, 1);
% y_disp = zeros(len, 1, 1);
% xm = zeros(len, 1, 1);
% ym = zeros(len, 1, 1);
% 
% k = 0;
% 
% for n = 1:len
%     if gotMarker(n)==1
%         k = k+1;
%         [xm(k), ym(k)] = getCoords(pose(:, :, n), marker_coord);
%         x_disp(k) = x(n);
%         y_disp(k) = y(n);        
%     end
% end
% 
% hold on
% plot(x_disp(1:k), y_disp(1:k))
% plot(xm(1:k), ym(1:k))
% hold off
% legend('actual', 'est')

n = 200;   %t = 2 sec
A = pose(:, :, n);
img_coords = loc(:, :, n);
tform = rigidtform3d(A);
t = tform.Translation; %/1000   %convert mm to m?
marker_coord = [2 0 0.15];  
car_len = 0.5; 
cam_dist = [0.22754 0 0];
cam_height = 0.28737;


act_points = [x(n), y(n)]

R1 = [0 0 1; 1 0 0; 0 -1 0];  %x = z_c | y = x_c | z = -y_c
Ta = blkdiag(R1,1); 
Tb = eye(4);

im_x = (max(img_coords(:, 1)) + min(img_coords(:, 1)))/2;
im_y = (max(img_coords(:, 2)) + min(img_coords(:, 2)))/2;

im_x = (im_x - 1640); %/1000;
im_y = (im_y -1232); %/1000; 

po = A*[im_x; im_y; 1701.8; 1];
po = po/1000;
at = Tb*Ta*po;
am = at(1:3).'
ac = marker_coord - am
% 
% 
% function [x, y] = getCoords(pose, marker_coords)
% tform = rigidtform3d(pose);
% t = tform.Translation;
% 
% R1 = [0 0 1; 1 0 0; 0 -1 0];  %x = z_c | y = x_c | z = -y_c
% Ta = blkdiag(R1,1);
% Tb = eye(4);
% 
% po = [t(:); 1];
% p = Tb*Ta*po;
% meas = p(1:3).';
% coord = marker_coords - meas;
% x = coord(1);
% y = coord(2);
% end