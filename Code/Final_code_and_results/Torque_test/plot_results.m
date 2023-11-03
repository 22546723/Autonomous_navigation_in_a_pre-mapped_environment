data = load("Final_code_and_results/Torque_test/straight_step.mat");
%data = load("Final_code_and_results/Torque_test/turn_step.mat");
data = data.data;

R_L = data.R_L;
%R_R = data.R_R;
T_L = data.T_L;
T_R = data.T_R;
w_R = data.w_R_act;
w_L = data.w_L_act;

len = length(w_L.Data);
stop = (4/0.01)+1;

hold on
yyaxis left
plot(R_L, '--b')
%plot(R_R, '--r')
plot(w_L, '-b')
plot(w_R, '-r')

yyaxis right
plot(T_L, '-.b')
plot(T_R, '-.r')

hold off

yyaxis left 
ylabel("Speed [rad/s]")

yyaxis right
ylabel("Torque [Nm]")

xlabel("Time [s]")
legend("Reference speed", "Left wheel", "Right wheel", ...
    "Left torque", "Right torque")
% legend("Left reference", "Right reference", "Left wheel", "Right wheel")
% title("Torque controller step turn response")
grid on
