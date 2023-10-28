% ts_des = 0.2;
% zeta_des = 0.7071;
% 
% sigma_des = 4/ts_des
% wn_des = sigma_des/zeta_des
% wd_des = wn_des*sqrt(1-zeta_des^2);
% s_des = -sigma_des + 1i*wd_des
% % 
% % G = 16/s
% % 
% % Kp = 1/abs(G)
% 
% G = s_des*(s_des+19.32+1i*9.36)*(s_des+19.32-1i*9.36);
% G = 461/G;
% 
% D = (s_des+2.8)*(s_des-7.82)/s_des;
% 
% Kd = 1/abs(D*G)


sigma = 24.5:0.5:50.5;
sigma = sigma.';
len = length(sigma);

%w = zeros(length(sigma), 1, 1);
w = 40:0.5:66.5;
w = w.';

% a3 = zeros(length(sigma), 1, 1);
% a4 = zeros(length(sigma), 1, 1);

res = {'sigma', 'w', 'a3', 'a4', 'a'};

for n=1:len %sigma

    for k=1:len %w
        a3 = 360 - atand((w(k) - 13.64)/(sigma(n) - 20));
        a4 = atand((w(k) + 13.64)/(sigma(n) - 20));
        a = a3+a4;

        if (a>360)
            a = a-360;
        end

        if (a<0)
            a = a+360;
        end

        if ((a>=184.3)&&(a<=184.32)) || ((a>=4.3)&&(a<=4.32))
            temp = {sigma(n), w(k), a3, a4, a};
            res = [res; temp];
        end
    end

end

disp(res)

