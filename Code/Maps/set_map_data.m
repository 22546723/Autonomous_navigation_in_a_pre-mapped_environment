file_name = "Maps/multi_route_test";

% Place nodes
nodes =    [1 2 3   4   5 6  7  8 9 10 11];
x_coords = [0 1 -2  -1  4 6  7  8 5 9  8.5];
y_coords = [0 2 1.5 -5 -1 -7 -1 1 3 9  -4];

node_data = [nodes; x_coords; y_coords];

% Set up the weighted graph
s = [1 1 1 2 3 4 4 5 6 6  7 8  9];
t = [2 3 8 5 4 5 6 7 9 11 9 10 10];

graph_data = [s; t];

% Save as a map
map_data = map(node_data, graph_data);
save(file_name, 'map_data')