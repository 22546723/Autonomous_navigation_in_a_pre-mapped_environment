classdef map
    % map   Map object containing the details of an environment
    % map Properties:
    %   weighted_graph - A weighted graph of the nodes in the environment
    %   nodes - List of node objects in the environment
    %   markers - List of marker objects in the environment
    %
    % map Methods:
    %   map - class intitialisation 
    properties
        % weighted_graph - Weighted graph of the nodes in the environment
        % See also graph
        weighted_graph;   

        % nodes - cell array of nodes in environment
        % See also node
        nodes;

        % markers - cell array of markers in environment
        % See also marker
        markers;
    end %properties
    methods
        function obj = map(node_data, graph_data, marker_data)
            % map   Initialise the map class
            % Inputs:
            %   node_data   : array containing the ID and coordinates of 
            %                 all nodes in the environment, sorted by ID - 
            %                 [node id; x coordinate; y coordinate]
            %   graph_data  : array containing the start and target node
            %                 IDs for each branch on the weighted graph -
            %                 [start node ID; target node ID]
            %   marker_data : array containing the marker ID, coordinates
            %                 and angle of each marker in the environment 
            %                 - [marker ID; x coordinate; y coordinate; 
            %                 angle];
            % Outputs:
            %   obj : map object

            %generate node objects
            num_nodes = length(node_data);
            obj.nodes = cell(num_nodes, 1);

            for n=1:num_nodes
                id = node_data(1, n);
                x = node_data(2, n);
                y = node_data(3, n);
                obj.nodes{n} = node(id, x, y);
            end %for  

            %setup the weighted graph
            s = graph_data(1, :);
            t = graph_data(2, :);
            num_w = length(s);
            weights = zeros(1, num_w, 1, "double");

            for n = 1:num_w
                xs = obj.nodes{s(n)}.x_coord;
                ys = obj.nodes{s(n)}.y_coord;

                xt = obj.nodes{t(n)}.x_coord;
                yt = obj.nodes{t(n)}.y_coord;

                weights(n) = sqrt((xt-xs)^2 + (yt-ys)^2);
            end %for

            obj.weighted_graph = graph(s, t, weights);

            %generate marker objects
            num_markers = size(marker_data);
            num_markers = num_markers(2);
            obj.markers = cell(num_markers, 1);

            for n=1:num_markers
                id = marker_data(1, n);
                x = marker_data(2, n);
                y = marker_data(3, n);
                angle = marker_data(4, n);
                obj.markers{n} = marker(id, x, y, angle);
            end %for  
            
        end %map
    end %methods
end %classdef