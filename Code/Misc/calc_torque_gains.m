ts = 0.2;
zeta = 0.7071;

sigma = 4/ts;
wn = sigma/zeta;
wd = wn*sqrt(1-zeta^2);

s = -sigma + 1i*wd

J_left = 0.089673222326686;
J_right = 0.074059531932167;

c = J_left/J_right;

G_left = 1/(J_left*s);
G_right = 1/(J_right*s);

K_left = 1/abs(G_left)
K_right = 1/abs(G_right)

Kl = c*K_right