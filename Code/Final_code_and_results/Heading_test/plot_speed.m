data = load("Heading_test/speed_step.mat");
data = data.data;

v_ref_step = data.ref_speed;
v_out_step = data.v_car;

data = load("Heading_test/speed_ramp.mat");
data = data.data;

v_ref_ramp = data.ref_speed;
v_out_ramp = data.v_car;

t = tiledlayout(1, 2, 'TileSpacing','compact');
title(t, "Heading controller speed response")

nexttile
hold on
yyaxis left
plot(v_ref_step, '-b')
plot(v_out_step, '--r')
hold off
xlabel("Time [s]")
ylabel("Speed [m/s]")
legend("Reference", "Measured")
title("Step response")
grid on

nexttile
hold on
yyaxis left
plot(v_ref_ramp, '-b')
plot(v_out_ramp, '--r')
hold off
xlabel("Time [s]")
ylabel("Speed [m/s]")
legend("Reference", "Measured")
title("Ramp response")
grid on