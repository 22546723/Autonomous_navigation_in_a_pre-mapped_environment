ts = 0.2;
zeta = 0.7071;

sigma = 4/ts

wn = sigma/zeta

wd = wn*sqrt(1-zeta^2);


s = -sigma + 1i*wd
% 
% G = 16/s
% 
% Kp = 1/abs(G)

G = s*(s+19.32+1i*9.36)*(s+19.32-1i*9.36);
G = 461/G;

D = (s+2.8)*(s-7.82)/s;

Kd = 1/abs(D*G)