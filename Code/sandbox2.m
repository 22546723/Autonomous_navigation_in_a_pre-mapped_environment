map =  load('Maps/path_segment_test.mat');
map = map.map_data;

planner = route_planner(map);
[path, distance]  = plot_route(planner, 1, 5);
ref_signal = convert_to_ref(planner, path);

