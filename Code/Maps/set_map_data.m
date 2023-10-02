%file
folder_name = "Maps/weighted_graph_test/";

%weighted graph
s = [1 1 2];
t = [2 3 3];
w = [2 4 3];

graph_data = [s; t; w;];
save(folder_name + 'weighted_graph', 'graph_data')

%nodes
nodes = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];

coord_data = [nodes; x_coords; y_coords];
save(folder_name + 'node_coords', "coord_data")

%markers
markers = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];
angles = [0 0 0];

marker_data = [markers; x_coords; y_coords];
save(folder_name + 'marker_coords', 'marker_data')

%map
map_data = map(coord_data, graph_data, marker_data);
save(folder_name + 'map', 'map_data')