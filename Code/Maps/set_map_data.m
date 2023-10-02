%weighted graph
s = [1 1 2];
t = [2 3 3];
w = [2 4 3];

graph_data = [s; t; w;];
save('weighted_graph', 'graph_data')

%nodes
ids = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];

len = length(ids);
nodes = cell(len, 1);

for n=1:len
    nodes{n} = node(ids(n), x_coords(n), y_coords(n));
end

save('node_list', 'nodes')

%markers
ids = [1 2 3];
x_coords = [2 0 4];
y_coords = [0 4 2];

len = length(ids);
markers = cell(len, 1);

for n=1:len
    markers{n} = marker(ids(n), x_coords(n), y_coords(n));
end

save('marker_list', 'markers')

%map
map_data = map(coord_data, graph_data);
save('map', 'map_data')