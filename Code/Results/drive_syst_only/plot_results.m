data = load("Results//drive_syst_only/torque_control_results.mat");
data = data.data;

% figure
% plot_speeds(data)
% 
% figure
plot_angles(data)

function plot_speeds(data)
t = tiledlayout(2, 1);
vals = zeros(length(data.v_out), 1, 1);

for n = 1:length(data.v_out)
    vals(n) = data.v_in.Data(1);
end

v_in = timeseries(vals, data.v_out.Time);

nexttile
hold on
plot(v_in)
plot(data.v_out)
hold off
grid on
xlabel("Time [s]")
ylabel("Speed [m/s]")
title("Car speed response")
legend("Reference speed", "Measured speed")

nexttile
hold on
plot(data.R_L)
plot(data.R_R)
plot(data.w_L_act)
plot(data.w_R_act)
hold off
grid on
xlabel("Time [s]")
ylabel("Speed [rad/s]")
title("Wheel speed response")
legend("Left wheel reference speed", "Right wheel reference speed", ...
    "Left wheel measured speed", "Right wheel measured speed");

title(t, "Response of the controlled drive system")
end

function plot_angles(data)
hold on
plot(data.w_in)
plot(data.w_out)
hold off
grid on
xlabel("Time [s]")
ylabel("Angular velocity [rad/s]")
title("Drive system response")
legend("Reference angular velocity", "Measured angular velocity")
end


