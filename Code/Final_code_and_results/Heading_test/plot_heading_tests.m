data = load("Heading_test/speed_ramp.mat");
data = data.data;

w_control = data.ref_w;
w_out = data.w_car;
w_L = data.w_L;
w_R = data.w_R;
v_ref = data.ref_speed;
v_out = data.v_car;
R_L = data.R_L;
R_R = data.R_R;
ref_angle = data.ref_angle;
meas_angle = data.meas_angle;
error_angle = data.error_angle;

t = tiledlayout(2, 2);
title(t, "Heading controller speed step response")

nexttile
hold on
yyaxis left
plot(v_ref, '-b')
plot(v_out, '--r')
hold off
xlabel("Time [s]")
ylabel("Speed [m/s]")
legend("Reference", "Measured")
title("Car speed")
grid on

% nexttile
% hold on
% plot(ref_angle)
% plot(meas_angle)
% plot(error_angle, '--r')
% hold off
% xlabel("Time [s]")
% ylabel("Angle [rad]")
% legend("Reference", "Measured", "Error")
% title("Car angles")
% grid on
% 
% nexttile
% hold on 
% plot(R_L)
% plot(R_R)
% plot(w_L)
% plot(w_R)
% hold off
% xlabel("Time [s]")
% ylabel("Speed [rad/s]")
% legend("Left reference", "Right reference", "Left measured", "Right measured")
% title("Wheel speed")
% grid on
% 
% nexttile
% hold on
% plot(w_control)
% plot(w_out)
% hold off
% xlabel("Time [s]")
% ylabel("Angular velocity [rad/s^2]")
% legend("Control", "Measured")
% title("Angular velocity")
% grid on
