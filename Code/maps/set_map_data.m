s = [1 1 2];
t = [2 3 3];
w = [2 4 3];

graph_data = [s; t; w;];
save('weighted_graph', 'graph_data')

nodes = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];

coord_data = [nodes; x_coords; y_coords];
save('node_coords', "coord_data")

map_data = map(coord_data, graph_data);
save('map', 'map_data')