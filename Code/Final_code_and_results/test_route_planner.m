% Runs route_planner.m and displays the results
s_node = 1;
t_node = 10;

%now gets set in route planner class
% map =  load('Maps/straight_line_test.mat');
% map = map.map_data;
%mapfile = 'Maps/multi_route_test.mat';

planner = route_planner();
[path, distance]  = plot_route(planner, s_node, t_node);
%ref_signal = convert_to_ref(planner, path);
ref = get_ref_array(planner, s_node, t_node);

map = planner.map;

nodes = map.nodes;
len = length(nodes);

%t = tiledlayout(1, 2);
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
%plot weighted graph
%nexttile
figure
G = map.weighted_graph;
p = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', G.Edges.Weight, 'LineWidth',0.75);
highlight(p, path, 'EdgeColor', 'red', 'LineWidth',0.75)
title("Weighted graph")
grid on
xlabel('X [m]')
ylabel('Y [m]')

%%%%%%%%%%%%%%%%%%
%plot reference signal
%nexttile%(2, [2 1])
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
% offset = 0.05;
% caption = sprintf('%.2f', id(n));
% text(xr(1), yr(1)+offset, 'Start');
% text(xr(ref_len+1), yr(ref_len+1)+offset, 'Stop');


plot(xr, yr, 'LineWidth',0.75)
plot(xp, yp, '--', 'LineWidth',0.75)
plot(xr(1), yr(1), 'o', 'LineWidth',2)
plot(xr(ref_len+1), yr(ref_len+1), 'x', 'LineWidth',2)
% row = dataTipTextRow(" ",["Start", "Stop"]);
% plt.DataTipTemplate.DataTipRows = row;
% dt = datatip(plt,xr(1),yr(1));
% dt = datatip(plt,xr(ref_len+1),yr(ref_len+1));

hold off
title("Route")
xlabel("X [m]");
ylabel("Y [m]");
legend("Curved reference route", "Original reference route", "Start", "Stop")
grid on
%%%%%%%%%%%%%%%%%%
%plot node coordinates
% id = zeros(len, 1, 1, "double");
% x = zeros(len, 1, 1, "double");
% y = zeros(len, 1, 1, "double");
% 
% for n=1:len
%     id(n) = nodes{n}.id;
%     x(n) = nodes{n}.x_coord;
%     y(n) = nodes{n}.y_coord;
% end
% 
% nexttile
% plt = plot(x, y, 'o');
% row = dataTipTextRow("ID",id);
% plt.DataTipTemplate.DataTipRows = row;
% 
% for n=1:len
%     dt = datatip(plt,x(n),y(n));
% end
% grid on
% title("Node coordinates")
% xlabel("X [m]");
% ylabel("Y [m]");
%%%%%%%%%%%%%%%%%%%%%%

temp = "Plotted route from node "+s_node+" to node "+t_node;
%title(t, temp)

%set(gcf, 'Position', [10, 10, 1300, 550])