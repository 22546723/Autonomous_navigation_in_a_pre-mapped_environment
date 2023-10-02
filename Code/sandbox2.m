map =  load('/home/22546723/Documents/MATLAB/Skripsie/Code/maps/weighted_graph_test/map.mat');
map = map.map_data;

planner = route_planner(map);
[path, distance, edgepath]  = plot_route(planner, 1, 3);
ref_signal = convert_to_ref(planner, path);

G = map.weighted_graph;
p = plot(G, 'EdgeLabel', G.Edges.Weight);
highlight(p, 'Edges', edgepath)
