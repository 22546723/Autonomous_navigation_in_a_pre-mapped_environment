classdef route_planner
    % route_planner     plots a route and reference signal for a given map
    %
    % route_planner Properties:
    %   map - Map object
    %   See also map
    %
    % route_planner Methods:
    %   route_planner - class initialisation
    %   plot_route - determines the shortest node path between two nodes
    %   convert_to_ref - converts a node path to a reference signal that
    %                    can be used for control
    %
    % route_planner Methods(private):
    %   calc_turn - calculates the turning details for three connected
    %               nodes
    %   get_perp_line - calculates the slope and offset of a line
    %                   perpindicular to the given line
    %   calc_point - calculates a point on a line that is a distance
    %                from the end of the line

    properties
        map;
    end %properties
    methods
        function obj = route_planner(map)
            % route_planner     initialise route_planner class
            % Inputs:
            %   map : map object
            %         See also map
            % Outputs:
            %   obj : route_planner object

            obj.map = map;
        end %route_planner

        function [path, distance]  = plot_route(obj, s_node, t_node)
            % plot_route    determines the shortest node path between two nodes
            % Inputs:
            %   s_node  : starting node id
            %   t_node  : target node id
            % Outputs:
            %   path        : array of node IDs on the shortest path
            %   distance    : total length of the shortest path

            graph = obj.map.weighted_graph;
            [path, distance] = shortestpath(graph, s_node, t_node);
        end %plot_route

        function ref_signal = convert_to_ref(obj, path)
            % convert_to_ref    converts a node path to a reference signal 
            %                   that can be used for control
            %
            % This function uses the coordinates of the nodes on a path and
            % the minimum turn radius of the vehicle to determine a
            % reference signal that can be used by a control system
            %
            % Inputs: 
            %   path        : array of node IDs on the shortest path
            % Outputs:
            %   ref_signal  : cell array of path_segments that describes 
            %                 the plotted route
            %                 See also path_segment

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
            end %for

            %break coords into line segments
            ref_signal = cell(1, path_len); %array of path segments
            
            if path_len==2
                ref_signal{1} = path_segment(coords(:, 1), coords(:, 2), 0, [0; 0]);
            end

            for n = 1:(path_len - 2)
                A = coords(:, n);
                B = coords(:, n+1);
                C = coords(:, n+2);

                [start_turn, end_turn, R, mid_pt] = calc_turn(obj, A, B, C);                

                %break into segments
                ref_signal{n} = path_segment(A, start_turn, 0, [0; 0]);
                ref_signal{n+1} = path_segment(start_turn, end_turn, R, mid_pt);
                ref_signal{n+2} = path_segment(end_turn, C, 0, [0; 0]);
            end %for

        end %convert

    end %methods

    methods (Access = private)
        function [start_turn, end_turn, R, mid_pt] = calc_turn(obj, A, B, C)
            % calc_turn     calculated the start, end and radius of the
            % turn required for three connected nodes
            %
            % NOTE: The nodes MUST be connected in the following way:
            %   A-B-C
            % otherwise the function WILL NOT WORK
            %
            % Inputs:
            %   A   : [x; y] coordinates of the starting node
            %   B   : [x; y] coordinates of the middle node
            %   C   : [x; y] coordinates of the ending node
            % Outputs:
            %   start_turn  : [x; y] coordinates of the start of the turn
            %   end_turn    : [x; y] coordinates of the end of the turn
            %   R           : radius of the turn
            %   mid_pt      : [x; y] coordinates of the centre of the
            %                 circle that describes the turn. NOTE: used 
            %                 only for display

            R_min = 0.1; % minimum turn radius

            % get slopes
            if B(1)==A(1)
                m1 = 0;
            else
                m1 = (B(2) - A(2))/(B(1) - A(1));
            end

            if B(1)==C(1)
                m2 = 0;
            else
                m2 = (C(2) - B(2))/(C(1) - B(1));
            end

            if m1==m2
                if (A(1)==B(1))&&(B(2)==C(2)) % A-B vertical; B-C horizontal
                    c1 = B(1);
                    c2 = B(2);
                    pt1 = c2 + (abs(A(2)-B(2))/A(2)-B(2))*R_min;
                    pt2 = c1 + (abs(C(1)-B(1))/C(1)-B(1))*R_min;
                    x_mid = pt2;
                    y_mid = pt1;

                    % get radius & set outputs
                    R = R_min;
                    start_turn = [B(1); pt1];
                    end_turn = [pt2; B(2)];
                    mid_pt = [x_mid; y_mid];
                elseif ((A(2)==B(2))&&(B(1)==C(1))) % A-B horizontal; B-C vertical
                    c1 = B(2);
                    c2 = B(1);
                    pt1 = c2 + (abs(A(1)-B(1))/A(1)-B(1))*R_min;
                    pt2 = c1 + (abs(C(2)-B(2))/C(2)-B(2))*R_min;
                    x_mid = pt1;
                    y_mid = pt2;

                    % get radius & set outputs
                    R = R_min;
                    start_turn = [pt1; B(2)];
                    end_turn = [B(1); pt2];
                    mid_pt = [x_mid; y_mid];
                else %straight line
                    R = 0; 
                    start_turn = A;
                    end_turn = C;
                    mid_pt = [0; 0];
                end
            else
                % get offsets
                c1 = B(2) - m1*B(1);
                c2 = B(2) - m2*B(1);

                % calculate a point R away from B on both lines
                pt1 = calc_point(obj, A, B, m1, c1, R_min);
                pt2 = calc_point(obj, C, B, m2, c2, R_min);

                % calculate perpindicular lines going through these points
                [m1p, c1p] = get_perp_line(obj, pt1, m1);
                [m2p, c2p] = get_perp_line(obj, pt2, m2);

                % where the perpindicular lines meet
                x_mid = (c2p - c1p)/(m1p - m2p);
                y_mid = m1p*x_mid + c1p;

                % get radius & set outputs
                R = sqrt((x_mid - pt1(1))^2 + (y_mid - pt1(2))^2);
                start_turn = pt1;
                end_turn = pt2;
                mid_pt = [x_mid; y_mid];

                % %test
                % xt = 0:0.1:1;
                % y1 = m1*xt+c1;
                % y2 = m2*xt+c2;
                % y1p = m1p*xt+c1p;
                % y2p = m2p*xt+c2p;
                % 
                % plot(xt, y1, xt, y1p)
                % legend('y1', 'y1p')

                % hold on
                % plot(xt, y1, xt, y2)                
                % plot(xt, y1p, xt, y2p)
                % plot(x_mid, y_mid, 'o')
                % legend('y1', 'y2', 'y1p', 'y2p', 'middle')
                % hold off
            end
        end%calc turn

        function [m, c] = get_perp_line(obj, point, m_old)
            % get_perp_line     calculate the slope & offset of a
            % perpindicular line going through a point
            %
            % Inputs:
            %   point   : [x; y] coordinates of a point on the original 
            %             line that the perpindicular line needs to pass 
            %             through
            %   m_old   : slope of the original line
            % Outputs:
            %   m   : slope of the perpindicular line
            %   c   : offset of the perpindicular line
         
            if m_old==0
                m = 0;
            else
                m = -1/m_old;
            end
            c = point(2) - m*point(1);
        end %perp line 

        function point = calc_point(obj, start, stop, m, c, d)
            % calc_point    calculates a point on a line that is a distance
            %               from the end of the line
            % Inputs:
            %   start   : [x; y] coordinates of the start of the line
            %   stop    : [x; y] coordinates of the end of the line
            %   m       : slope of the line
            %   c       : line offset
            %   d       : distance from the end of the line
            % Outputs:
            %   point   : [x; y] coordinates of the calculated point on the 
            %             line


            % calculate the 2 points on the line d away from stop
            x1 = stop(1) - d/sqrt(1+m^2);
            y1 = m*x1 + c;
            d1 = sqrt((x1 - start(1))^2 + (y1 - start(2))^2);

            x2 = stop(1) + d/sqrt(1+m^2);
            y2 = m*x2 + c;
            d2 = sqrt((x2 - start(1))^2 + (y2 - start(2))^2);

            % the distance from start to point cannot be greater than the
            % distance from start to stop
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