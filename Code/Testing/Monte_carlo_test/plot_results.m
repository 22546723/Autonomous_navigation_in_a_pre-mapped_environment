results = load("Monte_carlo_test/results.mat");
results = results.results;

s_nodes = results(:, 1);
t_nodes = results(:, 2);
x_meas = results(:, 3);
y_meas = results(:, 4);
ref_angle = results(:, 5);
meas_angle = results(:, 6);
error_angle = results(:, 7);
ref_speed = results(:, 8);
meas_speed = results(:, 9);
ref_w = results(:, 10);
meas_w = results(:, 11);
target_reached = results(:, 12);

num_sims = length(s_nodes);
planner = route_planner();
map = planner.map;
nodes = map.nodes;
len = length(nodes);

%%%
% plot setup
%%%
t=tiledlayout(2, 6,"TileSpacing","compact");
title(t, "Monte Carlo simulation results for "+num_sims+" simulations")

%%%
% Plot map
%%%

id = zeros(len, 1, 1, "double");
x = zeros(len, 1, 1, "double");
y = zeros(len, 1, 1, "double");

for n=1:len
    id(n) = nodes{n}.id;
    x(n) = nodes{n}.x_coord;
    y(n) = nodes{n}.y_coord;
end

nexttile(1, [2,2])
hold on
G = map.weighted_graph;
p = plot(G, 'XData', x, 'YData', y, 'LineWidth',0.75, "EdgeColor",'k', 'LineStyle','--', "NodeColor",'k');

r = 0.1;
theta = linspace(0,2*pi);
for n=1:len
    xc = r*cos(theta) + x(n);
    yc = r*sin(theta) + y(n);
    plot(xc, yc)
end


%%%
% Plot measured coordinates
%%%
labels = string.empty(0, num_sims);

for n=1:num_sims
    plot(x_meas{n}.Data, y_meas{n}.Data)
    labels(n) = "Node "+s_nodes(n)+" to node "+t_nodes(n);
end

hold off    
grid on
legend("Possible routes");
xlabel("X [m]")
ylabel("Y [m]")
title("Routes taken")


%%%
% plot avg error angles
%%%
time = 0:0.001:60;
tot_error = zeros(length(time), 1, 1);
error_count = 0;

for n=1:num_sims
    for i=1:length(error_angle{n}.Data)
        tot_error(i) = tot_error(i) + error_angle{n}.Data(i);
        error_count = error_count+1;
    end
end
avg_error = timeseries(tot_error/error_count, time);
labels = cell(1, num_sims);
labels(:) = {''};

nexttile(3, [1,2])
hold on
for n=1:num_sims
    plot(error_angle{n})
end
plot(avg_error, '-k', 'LineWidth',1)
hold off
legend(labels{:}, "Average")
ylabel("Angle [rad]")
grid on
xlim([0 45])

angle_error_avg = 0;
for n=1:length(avg_error)
    angle_error_avg = angle_error_avg+avg_error.Data(n);
end
angle_error_avg = angle_error_avg/length(avg_error);
title("Angle errors (Average error: "+angle_error_avg*10^6+" \murad)")

%%%

nexttile(9, [1,2])
hold on
for n=1:num_sims
    plot(error_angle{n})
end
plot(avg_error, '-k', 'LineWidth',1)
hold off
legend(labels{:}, "Average")
ylabel("Angle [rad]")
xlabel("Time [s]")
grid on
xlim([0 45])
ylim([-1 1])

%%%
% plot avg speed error
%%%
time = 0:0.001:60;
tot_error = zeros(length(time), 1, 1);
speed_error = cell(10,1);
error_count = 0;

for n=1:num_sims
    speed_error{n} = timeseries(meas_speed{n}.Data-ref_speed{n}.Data, meas_speed{n}.Time);
    for i=1:length(speed_error{n}.Data)
        tot_error(i) = tot_error(i) + speed_error{n}.Data(i);
        error_count = error_count+1;
    end
end
avg_error = timeseries(tot_error/error_count, time);
labels = cell(1, num_sims);
labels(:) = {''};
xlim([0 45])
ylim([-1 1])

nexttile(5, [1,2])
hold on
for n=1:num_sims
    plot(speed_error{n})
end
plot(avg_error, '-k', 'LineWidth',1)
hold off
legend(labels{:}, "Average")

ylabel("Speed [m/s]")

grid on

speed_error_avg = 0;
for n=1:length(avg_error)
    speed_error_avg = speed_error_avg+avg_error.Data(n);
end
speed_error_avg = speed_error_avg/length(avg_error);

title("Speed errors (Average error: "+speed_error_avg*10^6+" \mum/s)")

xlim([0 45])
%%%
nexttile(11, [1,2])
hold on
for n=1:num_sims
    plot(speed_error{n})
end
plot(avg_error, '-k', 'LineWidth',1)
hold off
legend(labels{:}, "Average")
ylabel("Speed [m/s]")
xlabel("Time [s]")
xlim([0 45])
ylim([-0.025 0.025])

grid on