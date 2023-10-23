% syms wt X
% 
% x = @(wt) X*sin(wt);
% a = @(wt) 0;
% b = @(wt) 312.5*x(wt) - 437.5;
% c = @(wt) 104.14*x(wt) - 125;
% d = @(wt) 45.14*x(wt) - 31.25;
% 
% t1 = asin(1.4/X);
% t2 = asin(1.5/X);
% t3 = asin(1.6/X);

%syms X
X = 3;
s = tf('s');

A = 1.4;
B = 1.5;
C = 1.6;

a = asin(A/X);
b = asin(B/X);
c = asin(C/X);

K1 = 312.5;
J1 = 437.5;

K2 = 104.14;
J2 = 125;

K3 = 45.14;
J3 = 31.25;

T1 = getB(a, b, A, B, K1, J1, X);
T2 = getB(b, c, B, C, K2, J2, X);
T3 = getB(c, pi-c, C, C, K3, J3, X);
T4 = getB(pi-c, pi-b, C, B, K2, J2, X);
T5 = getB(pi-b, pi-a, B, A, K1, J1, X);

B1 = @(X) (T1+T2+T3+T4+T5)/pi
B1 = (T1+T2+T3+T4+T5)/pi

T1 = getA(a, b, A, B, K1, J1, X);
T2 = getA(b, c, B, C, K2, J2, X);
T3 = getA(c, pi-c, C, C, K3, J3, X);
T4 = getA(pi-c, pi-b, C, B, K2, J2, X);
T5 = getA(pi-b, pi-a, B, A, K1, J1, X);

A1 = T1+T2+T3+T4+T5;
A1 = A1/pi

% N = @(X) B1/X
N = B1/X

% G_s = 12.28*N/s;
% sisotool('rlocus', G_s)
K = 2.7851;



function Bn = getB(m, n, M, N, K, J, X)
%     Bn = @(X) (( K*X * (((n-m)/2) + (2*M*sqrt(X^2 - M^2) - ...
%         (2*N*sqrt(X^2 - N^2)))/X) ) + J*(sqrt(1-(N/X)^2) - ...
%         sqrt(1-(M/X)^2)));
    Bn = (( K*X * (((n-m)/2) + (2*M*sqrt(X^2 - M^2) - ...
        (2*N*sqrt(X^2 - N^2)))/X) ) + J*(sqrt(1-(N/X)^2) - ...
        sqrt(1-(M/X)^2)));
    
end

function An = getA(m, n, M, N, K, J, X)
    An = 2*K*(N^2 - M^2) + J*(M-N);
    An = An/X;
end
