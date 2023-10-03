% pnt = [2; 1];
% R = 1;
% x = pnt(1)-R:0.2:pnt(1)+R;
% 
% dx = x-pnt(1);
% theta = acos(dx/R);
% y = R*sin(theta); 
% yp = pnt(2) + abs(y);
% yn = pnt(2) - abs(y);
% 
% plot(x, yp, x, yn)
% grid on

theta = 0:(2*pi/10):2*pi;
pnt1 = [-0.0316; 0.0949];
pnt2 = []