classdef map
    properties
        weighted_graph;   
        nodes;
    end 

    methods
        function obj = map(node_data, graph_data)
            %%%
            % Initialize node objects
            %%%
            num_nodes = length(node_data);
            obj.nodes = cell(num_nodes, 1);

            for n=1:num_nodes
                id = node_data(1, n);
                x = node_data(2, n);
                y = node_data(3, n);
                obj.nodes{n} = node(id, x, y);
            end  

            %%%
            % Create the weighted graph
            %%%
            s = graph_data(1, :);
            t = graph_data(2, :);
            num_w = length(s);
            weights = zeros(1, num_w, 1, "double");

            % Calculate the weights
            for n = 1:num_w
                xs = obj.nodes{s(n)}.x_coord;
                ys = obj.nodes{s(n)}.y_coord;

                xt = obj.nodes{t(n)}.x_coord;
                yt = obj.nodes{t(n)}.y_coord;

                weights(n) = sqrt((xt-xs)^2 + (yt-ys)^2);
            end 

            obj.weighted_graph = graph(s, t, weights);
        end 
    end 
end 