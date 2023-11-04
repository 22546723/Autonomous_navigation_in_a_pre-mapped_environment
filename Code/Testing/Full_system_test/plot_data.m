results = load("Monte_carlo_test/results.mat");
results = results.results;

sim_num = 1;

s_node = results{sim_num, 1};
t_node = results{sim_num, 2};
x = results{sim_num, 3};
y = results{sim_num, 4};
ref_angle = results{sim_num, 5};
meas_angle = results{sim_num, 6};
error_angle = results{sim_num, 7};
ref_speed = results{sim_num, 8};
meas_speed = results{sim_num, 9};
w_control = results{sim_num, 10};
w_out = results{sim_num, 11};
target_reached = results{sim_num, 12};

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
f = figure;
t = tiledlayout(3, 4, "TileSpacing","compact");
title(t, "Simulation results from node "+s_node+" to node "+t_node)
f.Position = [100 100 900 500];
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
legend("Reference", "Measured")

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
legend("Reference", "Measured", "Error")
grid on
% 
%%%% speeds %%%%%
nexttile(9, [1, 2])
hold on
plot(ref_speed, LineWidth=0.75)
plot(meas_speed, LineWidth=0.75) 
hold off
xlabel("Time [s]")
ylabel("Speed [m/s]")
title("Speeds")
legend("Reference", "Measured")
grid on
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
grid on