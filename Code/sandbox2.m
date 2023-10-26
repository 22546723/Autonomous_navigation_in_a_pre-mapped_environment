torque = out.simout.torque.Data;
w_L = out.simout.w_L_act.Data;
w_R = out.simout.w_R_act.Data;
v_L = out.simout.v_L.Data;
v_R = out.simout.v_R.Data;


hold on
yyaxis left
plot(torque(1:length(w_L)), w_L)
plot(torque(1:length(w_R)), w_R)

yyaxis right
plot(torque(1:length(v_L)), v_L)
plot(torque(1:length(v_R)), v_R)

hold off
grid on

yyaxis left
ylabel("Wheel speed [rad/s]")
legend("Left wheel", "Right wheel")

yyaxis right
ylabel("Wheel speed [m/s]")
legend("Left wheel", "Right wheel")

xlabel("Torque [Nm]")
title("Torque vs wheel speed")