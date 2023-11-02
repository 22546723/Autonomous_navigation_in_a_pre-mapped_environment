classdef route_planner

    properties
        map;
    end 

    methods

        % Initialize the class
        function obj = route_planner()
            map =  load('Final_code_and_results/reduced_route_test.mat');
            obj.map = map.map_data;
        end 

        % Determine a node path (used when testing only the route planner)
        function [path, distance]  = plot_route(obj, s_node, t_node)
            graph = obj.map.weighted_graph;
            [path, distance] = shortestpath(graph, s_node, t_node);
        end

        % Determine a reference path
        function ref_array = get_ref_array(obj, s_node, t_node)
            graph = obj.map.weighted_graph;
            path = shortestpath(graph, s_node, t_node);

            %%%
            % Get the coordinates of the nodes on the path
            %%%

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

            %%%
            % Break the coordinate path into line segments
            %%%
            
            % Format: [x_start; y_start; x_stop; y_stop]
            ref_array = zeros(4, (2*path_len-3), 1, "double"); 

            % Set the start of the first and end of the last segment
            ref_array(1:2, 1) = coords(:, 1);
            ref_array(3:4, (2*path_len-3)) = coords(:, path_len);


            for n = 1:(path_len - 2)
                A = coords(:, n);
                B = coords(:, n+1);
                C = coords(:, n+2);

                % Get points a distance from B on both lines
                [start_turn, end_turn] = get_points(obj, A, B, C); 
                
                % Add the turn points to the segment path
                seg_count = 2*n;
                ref_array(1:2, seg_count) = start_turn;
                ref_array(3:4, seg_count) = end_turn;
                ref_array(3:4, seg_count-1) = start_turn;
                ref_array(1:2, seg_count+1) = end_turn;
            end 
        end 
    
        % Determine points a distance from B on both lines
        function [start_point, end_point] = get_points(obj, A, B, C)
            %%%
            % Calculate the angles of lines AB and BC
            %%%    
            BA = (A(2)-B(2))/(A(1)-B(1));
            BC = (C(2)-B(2))/(C(1)-B(1));
            angle_BA = atan(BA);
            angle_BC = atan(BC);

            %%%
            % Determine the points a distance from B on each line
            %%%
            R_min = 0.6; % minimum turn radius

            % Get the points on both sides of B
            d_BA_x = R_min*cos(angle_BA);
            d_BA_y = R_min*sin(angle_BA);
            d_BC_x = R_min*cos(angle_BC);
            d_BC_y = R_min*sin(angle_BC);

            d_BA = sqrt((A(2)-B(2))^2 + (A(1)-B(1))^2);
            d_BC = sqrt((C(2)-B(2))^2 + (C(1)-B(1))^2);

            % Determine the correct point on line AB
            pt1 = B + [d_BA_x; d_BA_y];
            pt2 = B - [d_BA_x; d_BA_y];
            d1 = sqrt((A(2)-pt1(2))^2 + (A(1)-pt1(1))^2);
            if d1<=d_BA
                start_point = pt1;
            else
                start_point = pt2;
            end

            % Determine the correct point on line BC
            pt1 = B + [d_BC_x; d_BC_y];
            pt2 = B - [d_BC_x; d_BC_y];
            d1 = sqrt((C(2)-pt1(2))^2 + (C(1)-pt1(1))^2);
            if d1<=d_BC
                end_point = pt1;
            else
                end_point = pt2;
            end
        end     
    end 
end 