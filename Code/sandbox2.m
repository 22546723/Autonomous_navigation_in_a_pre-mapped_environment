ts = 0.1;
zeta = 0.9;

sigma = 4/ts

wn = sigma/zeta

wd = wn*sqrt(1-zeta^2)


s = -40 + 1i*19.37;

den_G = den(1)*s^2 + den(2)*s + den(3);
G = 100/s

Kd = 1/abs(G)