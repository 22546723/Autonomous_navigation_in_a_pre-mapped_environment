data = load("Final_code_and_results/Torque_to_speed/torque_to_speed_tfs.mat");
data = data.data;

torque = data.torque;
left_speed = data.w_L_act;
right_speed = data.w_R_act;
left_tf = data.left_tf;
right_tf = data.right_tf;


start = (0.98/0.001)+1;
stop = (1.03/0.001);

hold on
yyaxis left
plot(left_speed.Time(start:stop), left_speed.Data(start:stop), '-b')
plot(left_tf.Time(start:stop+4), left_tf.Data(start:stop+4), '--b')

plot(right_speed.Time(start:stop), right_speed.Data(start:stop), '-r')
plot(right_tf.Time(start:stop+4), right_tf.Data(start:stop+4), '--r')

yyaxis right
plot(torque.Time(start:stop+4), torque.Data(start:stop+4), '-g')


hold off

xlabel("Time [s]")
yyaxis left
ylabel("Wheel speed [rad/s]")

yyaxis right
ylabel("Torque [Nm]")

legend("Left wheel", "Left transfer function", "Right wheel", "Right transfer function", "Torque")
title("Torque vs speed results")
grid on