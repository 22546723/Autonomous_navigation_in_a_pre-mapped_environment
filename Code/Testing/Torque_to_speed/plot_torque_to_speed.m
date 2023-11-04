data = load("Final_code_and_results/Torque_to_speed/torque_to_speed_test.mat");
data = data.data;

torque = data.torque;
left_speed = data.w_L_act;
right_speed = data.w_R_act;
car_speed = data.v_out;

start = 901;
stop = 1100;

n1 = 1001;
n2 = 1011;

t1 = torque.Time(n1);
t2 = right_speed.Time(n2);
dt = t2-t1;

a_left = (left_speed.Data(n2) - left_speed.Data(n1))/dt;
a_right = (right_speed.Data(n2) - right_speed.Data(n1))/dt;

T = torque.Data(n1);

J_left = T/a_left;
J_right = T/a_right;

left_val = 1/J_left;
right_val = 1/J_right;
% 
% hold on
% yyaxis right
% plot(torque.Time(start:stop), torque.Data(start:stop))
% 
% yyaxis left
% plot(left_speed.Time(start:stop), left_speed.Data(start:stop))
% plot(right_speed.Time(start:stop), right_speed.Data(start:stop))
% hold off
% 
% xlabel("Time [s]")
% yyaxis left
% ylabel("Wheel speed [rad/s]")
% 
% yyaxis right
% ylabel("Torque [Nm]")
% 
% legend("Torque", "Left wheel", "Right wheel")
% title("Torque vs speed results")
% grid on
