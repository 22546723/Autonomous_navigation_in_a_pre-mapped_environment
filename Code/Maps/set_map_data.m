% Generates map objects

%file
file_name = "Maps/path_segment_test";

%nodes
nodes = [1 2 3 4 5];
x_coords = [0 1 -1 0 1];
y_coords = [3 4 1 0 0];

node_data = [nodes; x_coords; y_coords];

%weighted graph
s = [1 1 1 2 2 3 4];
t = [2 3 4 4 5 4 5];

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