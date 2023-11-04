data = load("Heading_test/angle_step_pos.mat");
data = data.data;

ref_angle_pos = data.ref_angle;
meas_angle_pos = data.meas_angle;
error_angle_pos = data.error_angle;

data = load("Heading_test/angle_step_neg.mat");
data = data.data;

ref_angle_neg = data.ref_angle;
meas_angle_neg = data.meas_angle;
error_angle_neg = data.error_angle;

% t = tiledlayout(1,2,"TileSpacing","compact");
% title(t, "Heading controller accelerating response")
% 
% nexttile
hold on
plot(ref_angle_pos, '-b')
plot(meas_angle_pos, '-r')
plot(error_angle_pos, '--r')

plot(ref_angle_neg, '-b')
plot(meas_angle_neg, '-r')
plot(error_angle_neg, '--r')

hold off
xlabel("Time [s]")
ylabel("Angle [rad]")
legend("Reference", "Measured", "Error")
title("Heading controller step response")
grid on

% nexttile
% hold on
% plot(ref_angle_neg, '-b')
% plot(meas_angle_neg, '-r')
% plot(error_angle_neg, '--r')
% hold off
% xlabel("Time [s]")
% ylabel("Angle [rad]")
% legend("Reference", "Measured", "Error")
% title("Negative reference angle")
% grid on