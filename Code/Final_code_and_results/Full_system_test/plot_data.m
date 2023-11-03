data = load("Final_code_and_results/Full_system_test/1_9.mat");
data = data.data;


%%% Read results %%%%%
s_node = data.s_node.Data;
t_node = data.t_node.Data;
x = data.x;
y = data.y;
meas_speed = data.v_car;
ref_speed = data.ref_speed;
ref_angle = data.ref_angle;
meas_angle = data.meas_angle;
w_out = data.w_car;
w_control = data.ref_w;
error_angle = data.error_angle;

%%%%% get reference coords %%%%
planner = route_planner();
[path, distance]  = plot_route(planner, s_node, t_node);
ref = get_ref_array(planner, s_node, t_node);

map = planner.map;

nodes = map.nodes;
len = length(nodes);

ref_len = size(ref, 2);
xr = zeros(ref_len+1, 1, 1, "double");
yr = zeros(ref_len+1, 1, 1, "double");

for n=1:ref_len
    xr(n) = ref(1, n);
    yr(n) = ref(2, n);

    xr(n+1) = ref(3, n);
    yr(n+1) = ref(4, n);
end

id = zeros(len, 1, 1, "double");
xn = zeros(len, 1, 1, "double");
yn = zeros(len, 1, 1, "double");

for n=1:len
    id(n) = nodes{n}.id;
    xn(n) = nodes{n}.x_coord;
    yn(n) = nodes{n}.y_coord;
end

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
% 
%%%% speeds %%%%%
nexttile(9, [1, 2])
hold on
plot(ref_speed, LineWidth=0.75)
plot(meas_speed, LineWidth=0.75)    %Replace with actual speed
hold off
xlabel("Time [s]")
ylabel("Speed [m/s]")
title("Speeds")
legend("Reference", "Measured")

%%%% w %%%%%
nexttile(11, [1, 2])
hold on
plot(w_control, LineWidth=0.75)
plot(w_out, LineWidth=0.75)
hold off
xlabel("Time [s]")
ylabel("Angular velocity [rad/s]")
title("Angular velocities")
legend("Control", "Measured")