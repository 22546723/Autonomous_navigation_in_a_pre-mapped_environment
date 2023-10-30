% Generates map objects

%file
file_name = "Maps/s_route_test";

%nodes
nodes =    [1 2 3 4 5 6];
x_coords = [0 2 4 4.2 5 7];
y_coords = [0 2 0 -7 -10 -12];

node_data = [nodes; x_coords; y_coords];

%weighted graph
s = [1 2 3 4 5];
t = [2 3 4 5 6];

graph_data = [s; t];

%markers
markers = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];
angles = [0 0 0];

marker_data = [markers; x_coords; y_coords; angles];

%map
map_data = map(node_data, graph_data, marker_data);
save(file_name, 'map_data')