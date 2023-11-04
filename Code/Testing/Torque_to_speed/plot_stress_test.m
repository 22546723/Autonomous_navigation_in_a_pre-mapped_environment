data = load("Final_code_and_results/Torque_to_speed/torque_to_speed_stress_test.mat");
data = data.data;

left_speed = data.w_L_act;
right_speed = data.w_R_act;
left_torque = data.left_torque;
right_torque = data.right_torque;
accel = data.acceleration;


% hold on
% yyaxis left
% plot(left_speed, '-b')
% plot(right_speed, '-r')
% 
% yyaxis right
% plot(accel, '-g')
% 
% 
% hold off
% 
% xlabel("Time [s]")
% yyaxis left
% ylabel("Wheel speed [rad/s]")
% 
% yyaxis right
% ylabel("Acceleration [rad/s^2]")
% 
% legend("Left wheel", "Right wheel", "Acceleration")
% title("Maximum wheel acceleration")
% grid on

plot(left_torque)