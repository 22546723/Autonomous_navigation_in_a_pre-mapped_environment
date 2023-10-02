classdef route_planner
    properties
        map;
    end %properties
    methods
        function obj = route_planner(map)
            obj.map = map;
        end %route_planner

        function [path, distance, edgepath]  = plot_route(obj, s_node, t_node)
            graph = obj.map.weighted_graph;
            [path, distance, edgepath] = shortestpath(graph, s_node, t_node);
        end %plot_route

        function ref_signal = convert_to_ref(obj, path)
            nodes = obj.map.nodes;
            path_len = length(path);

            ref_signal = zeros(2, path_len, 1, "double"); %x-y coordinates

            for n = 1:path_len
                id = path(n);
                node = nodes{id};
                x = node.x_coord;
                y = node.y_coord;
                ref_signal(1, n) = x;
                ref_signal(2, n) = y;
            end
        end %convert

    end %methods
end %classdef