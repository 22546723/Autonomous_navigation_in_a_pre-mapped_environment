x_meas = ans.simout.x;
y_meas = ans.simout.y;
ref_angle = ans.simout.ref_angle;
meas_angle = ans.simout.meas_angle;
error_angle = ans.simout.error_angle;
ref_speed = ans.simout.ref_speed;
meas_speed = ans.simout.v_car;
ref_w = ans.simout.ref_w;
meas_w = ans.simout.w_car;

results = cell(num_sims, 11); 
results(n, :) = {s_node, t_node, x_meas, y_meas, ref_angle, meas_angle, error_angle, ref_speed, meas_speed, ref_w, meas_w};

%%% plot %%%%%%
t = tiledlayout(3, 4);
title(t, "Simulation results")
% 
% %%%%% XY %%%%%%
nexttile(1, [2, 2])
hold on
plot(xr, yr, LineWidth=0.75)
plot(x.Data, y.Data, LineWidth=0.75)

r = 0.1;
theta = linspace(0,2*pi);
for n=2:ref_len
    xc = r*cos(theta) + xr(n);
    yc = r*sin(theta) + yr(n);
    plot(xc, yc)
end

%plt = plot(xn, yn, 'o');
% row = dataTipTextRow("ID",id);
% plt.DataTipTemplate.DataTipRows = row;
% 
% for n=1:len
%     dt = datatip(plt,xn(n),yn(n));
% end
hold off
grid on
xlabel("X [m]")
ylabel("Y [m]")
title("Car coordinates")
legend("Reference", "Actual")

%%%%% angles %%%%%%%
nexttile(3, [2, 2])
hold on
plot(ref_angle, LineWidth=0.75)
plot(meas_angle, LineWidth=0.75)
plot(error_angle, '--r', LineWidth=0.75)
hold off
xlabel("Time [s]")
ylabel("Angle [rad]")
title("Car angles")
legend("Reference", "Measured", "error")


