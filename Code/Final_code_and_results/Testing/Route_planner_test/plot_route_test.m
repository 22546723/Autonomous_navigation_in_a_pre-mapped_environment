data = load("Route_planner_test/route_test.mat");
data = data.data;

s_node = data.s_node;
t_node = data.t_node;
ref_angle = data.ref_angle;
speed = data.speed;
target_reached = data.targetReached;
distance = data.distance;
segment = data.segment;
x = data.x;
y = data.y;
base_speed = data.base_speed;

%%%
% Get reference route
%%%
planner = route_planner();
[path, ~]  = plot_route(planner, s_node.Data, t_node.Data);
ref = get_ref_array(planner, s_node.Data, t_node.Data);

map = planner.map;

nodes = map.nodes;
len = length(nodes);

id = zeros(len, 1, 1, "double");
xn = zeros(len, 1, 1, "double");
yn = zeros(len, 1, 1, "double");

for n=1:len
    id(n) = nodes{n}.id;
    xn(n) = nodes{n}.x_coord;
    yn(n) = nodes{n}.y_coord;
end

ref_len = size(ref, 2);
xr = zeros(ref_len+1, 1, 1, "double");
yr = zeros(ref_len+1, 1, 1, "double");

figure
hold on
for n=1:ref_len
    xr(n) = ref(1, n);
    yr(n) = ref(2, n);

    xr(n+1) = ref(3, n);
    yr(n+1) = ref(4, n);
end

%%%
% get input angle
%%%
angle = zeros(length(ref_angle), 1, 1);

for n=1:length(ref_angle)
    angle(n) = atan2(y.Data(n), x.Data(n));
end

angle = timeseries(angle, ref_angle.Time);

%%%
% get base speed
%%%
base_speed = timeseries(base_speed.Data(1), speed.Time);

%%%
% Plotting
%%%

t = tiledlayout(2, 3, 'TileSpacing','compact');
title(t, "Route planner test results")

%%%
% Plot xy graph
%%%
nexttile(4, [1,1])

hold on
% G = map.weighted_graph;
% p = plot(G, 'XData', xn, 'YData', yn, 'EdgeLabel', G.Edges.Weight, 'LineWidth',0.75);
% highlight(p, path, 'EdgeColor', 'red', 'LineWidth',0.75)
plot(xr, yr, '-k', 'LineWidth',0.75)
plot(x.Data, y.Data, '--c')
hold off
xlabel("X [m]")
ylabel("Y [m]")
legend("Reference", "Input")
title("Route taken")
grid on

%%%
% dist, targetReached, segment num
%%%
nexttile(1, [1,3])

hold on
yyaxis left
plot(distance)

yyaxis right
plot(segment)
plot(target_reached, 'k')
hold off
xlabel("Time [s]")
title("Segment tracking")
legend("Distance to next node", "Current segment", "Target reached")

yyaxis left
ylabel("Distance [m]")

yyaxis right
ylabel("Counter")
grid on

%%%
% angle & speed
%%%
nexttile(5, [1,2])
hold on
yyaxis left
plot(ref_angle)

yyaxis right
plot(speed)
hold off
xlabel("Time [s]")
yyaxis left
ylabel("Angle [rad]")
yyaxis right
ylabel("Speed [m/s]")
title("Reference angle and speed")
legend("Angle", "Speed")
grid on
% 
% %%%
% % speeds
% %%%
% nexttile(11, [1, 2])
% hold on
% plot(base_speed)
% plot(speed)
% hold off
% xlabel("Time [s]")
% ylabel("Speed [m/s]")
% title("Speeds")
% legend("Base speed", "Reference speed")

