map =  load('/home/22546723/Documents/MATLAB/Skripsie/Code/maps/weighted_graph_test/map.mat');
map = map.map_data;

planner = route_planner(map);
[path, distance, edgepath]  = plot_route(planner, 1, 3);
ref_signal = convert_to_ref(planner, path);

nodes = map.nodes;
len = length(nodes);

tiledlayout(2, 2);

%%%%%%%%%%%%%%%
nexttile
G = map.weighted_graph;
p = plot(G, 'EdgeLabel', G.Edges.Weight);
highlight(p, 'Edges', edgepath)
title("Weighted graph")

%%%%%%%%%%%%%%%%%%
nexttile
plot(ref_signal(1, :), ref_signal(2, :))
title("Route")
xlabel("X");
ylabel("Y");
%%%%%%%%%%%%%%%%%%

id = zeros(len, 1, 1, "double");
x = zeros(len, 1, 1, "double");
y = zeros(len, 1, 1, "double");

for n=1:len
    id(n) = nodes{n}.id;
    x(n) = nodes{n}.x_coord;
    y(n) = nodes{n}.y_coord;
end

nexttile
plt = plot(x, y, 'o');
row = dataTipTextRow("ID",id);
plt.DataTipTemplate.DataTipRows = row;

for n=1:len
    dt = datatip(plt,x(n),y(n));
end
grid on
title("Node coordinates")
xlabel("X");
ylabel("Y");
%%%%%%%%%%%%%%%%%%%%%%