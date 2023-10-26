syms s
ts = 0.148;

zeta = 1;
sigma = 4/ts
wn = sigma/zeta
wd = wn* sqrt(1-zeta^2)

poles = [(-sigma + 1i*wd); (-sigma - 1i*wd)]
cl = (s - poles(1))*(s - poles(2))

temp = [1 (-poles(1) - poles(2)) (poles(1)*poles(2))]



