file_name = "Final_code_and_results/reduced_route_test";

% Place nodes
nodes =    [1 2  3 4  5  6 7 8 9];
x_coords = [0 1  4 6  7  8 5 9 8.5];
y_coords = [0 2 -1 -7 -1 1 3 9 -4];

node_data = [nodes; x_coords; y_coords];

% Set up the weighted graph
s = [1 2 3 3 3 4 5 6 7];
t = [2 3 4 5 7 9 6 8 8];

graph_data = [s; t];

% Save as a map
map_data = map(node_data, graph_data);
save(file_name, 'map_data')