classdef map
    properties
        weighted_graph;
        nodes;
        markers;
    end %properties
    methods
        function obj = map(coord_data, graph_data, marker_data)
            %generate node objects
            num_nodes = length(coord_data);
            obj.nodes = cell(num_nodes, 1);

            for n=1:num_nodes
                id = coord_data(1, n);
                x = coord_data(2, n);
                y = coord_data(3, n);
                obj.nodes{n} = node(id, x, y);
            end %for  

            %setup the weighted graph
            s = graph_data(1, :);
            t = graph_data(2, :);
            %weights = graph_data(3, :);
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