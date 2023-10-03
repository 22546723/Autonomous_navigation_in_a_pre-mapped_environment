%file
file_name = "Maps/path_segment_test";

%nodes
nodes = [1 2 3 4 5];
x_coords = [0 1 -1 0 1];
y_coords = [3 4 1 0 0];

coord_data = [nodes; x_coords; y_coords];

%weighted graph
s = [1 1 1 2 2 3 4];
t = [2 3 4 4 5 4 5];
%w = [2 4 3];


graph_data = [s; t];
%save(folder_name + 'weighted_graph', 'graph_data')


%save(folder_name + 'node_coords', "coord_data")

%markers
markers = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];
angles = [0 0 0];

marker_data = [markers; x_coords; y_coords; angles];

%save(folder_name + 'marker_coords', 'marker_data')

%map
map_data = map(coord_data, graph_data, marker_data);
save(file_name, 'map_data')