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

        function coords = convert_to_ref(obj, path)
            nodes = obj.map.nodes;
            path_len = length(path);

            coords = zeros(2, path_len, 1, "double"); %x-y coordinates

            for n = 1:path_len
                id = path(n);
                node = nodes{id};
                x = node.x_coord;
                y = node.y_coord;
                coords(1, n) = x;
                coords(2, n) = y;
            end

            %break coords into line segments
        end %convert

    end %methods

    methods (Access = private)
        function [start_turn, end_turn, R] = calc_turn(A, B, C)
            R_min = 0.1; %m

            if B(1)==A(1)
                m1 = B(2) - A(2);
            else
                m1 = (B(2) - A(2))/(B(1) - A(1));
            end

            if B(1)==C(1)
                m2 = C(2) - B(2);
            else
                m2 = (C(2) - B(2))/(C(1) - B(1));
            end

            c1 = B(2) - m1*B(1);
            c2 = B(2) - m2*B(1);

            pt1 = calc_point(A, B, m1, c1, R_min);
            pt2 = calc_point(C, B, m2, c2, R_min);

            [m1p, c1p] = get_perp_line(pt1, m1);
            [m2p, c2p] = get_perp_line(pt2, m2);

            x_mid = (c2p - c1p)/(m1p - m2p);
            y_mid = m1p*x_mid + c1p;

            R = sqrt((x_mid - pt1(1))^2 + (y_mid - pt1(2))^2);
            start_turn = pt1;
            end_turn = pt2;

        end%calc turn

        function [m, c] = get_perp_line(point, m_old)
            m = -1/m_old;
            c = point(2) - m*point(1);
        end %perp line 

        function point = calc_point(start, stop, m, c, d)
            x1 = stop(1) - d/sqrt(1+m^2);
            y1 = m*x1 + c;
            d1 = sqrt((x1 - start(1))^2 + (y1 - start(2))^2);

            x2 = stop(1) + d/sqrt(1+m^2);
            y2 = m*x2 + c;
            d2 = sqrt((x2 - start(1))^2 + (y2 - start(2))^2);

            d_base = sqrt((start(1) - stop(1))^2 + (start(2) - stop(2))^2);

            if (d1 <= d_base)
                point = [x1; y1];
            elseif (d2 <= d_base)
                point = [x2, y2];
            else
                point = [0; 0];
            end
        end %calc point
    end %private methods
end %classdef