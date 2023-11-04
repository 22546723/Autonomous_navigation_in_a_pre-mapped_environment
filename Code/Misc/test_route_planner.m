% Runs route_planner.m and displays the results

s_node = 1;
t_node = 10;

planner = route_planner();
[path, distance]  = plot_route(planner, s_node, t_node);
ref = get_ref_array(planner, s_node, t_node);

map = planner.map;

nodes = map.nodes;
len = length(nodes);

%%%%%% get node coords %%%%%
id = zeros(len, 1, 1, "double");
x = zeros(len, 1, 1, "double");
y = zeros(len, 1, 1, "double");

for n=1:len
    id(n) = nodes{n}.id;
    x(n) = nodes{n}.x_coord;
    y(n) = nodes{n}.y_coord;
end

path_len = length(path);
xp = zeros(path_len, 1, 1);
yp = zeros(path_len, 1, 1);
path_count = 1;

for n=1:len
    if ismember(id(n), path)
        xp(path_count) = x(n);
        yp(path_count) = y(n);
        path_count = path_count+1;
    end
end

%%%%%%%%%%%%%%%
figure
G = map.weighted_graph;
p = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', G.Edges.Weight, 'LineWidth',0.75);
highlight(p, path, 'EdgeColor', 'red', 'LineWidth',0.75)
title("Weighted graph")
grid on
xlabel('X [m]')
ylabel('Y [m]')

%%%%%%%%%%%%%%%%%%
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

plot(xr, yr, 'LineWidth',0.75)
plot(xp, yp, '--', 'LineWidth',0.75)
plot(xr(1), yr(1), 'o', 'LineWidth',2)
plot(xr(ref_len+1), yr(ref_len+1), 'x', 'LineWidth',2)

hold off
title("Route")
xlabel("X [m]");
ylabel("Y [m]");
legend("Curved reference route", "Original reference route", "Start", "Stop")
grid on

