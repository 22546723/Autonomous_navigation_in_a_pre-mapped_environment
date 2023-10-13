map = load("Maps/straight_line_test.mat", "map_data");
map = map.map_data;

planner = route_planner(map);
[path, distance]  = plot_route(planner, 1, 3);
ref_signal = convert_to_ref_array(planner, path);


