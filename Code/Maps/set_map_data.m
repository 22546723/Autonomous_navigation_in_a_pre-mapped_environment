% Generates map objects

%file
file_name = "Maps/straight_line_test";

%nodes
nodes = [1 2 3];
x_coords = [0 2 3];
y_coords = [0 2 0];

node_data = [nodes; x_coords; y_coords];

%weighted graph
s = [1 2];
t = [2 3];

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