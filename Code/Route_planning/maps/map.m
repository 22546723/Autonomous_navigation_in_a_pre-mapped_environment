classdef map
    properties
        weighted_graph;
        nodes;
    end %properties
    methods
        function obj = map(coord_data, graph_data)
            %setup the weighted graph
            s = graph_data(1, :);
            t = graph_data(2, :);
            weights = graph_data(3, :);
            obj.weighted_graph = graph(s, t, weights);

            num_nodes = length(coord_data);
            obj.nodes = cell(num_nodes, 1);

            %generate node objects
            for n=1:num_nodes
                id = coord_data(1, n);
                x = coord_data(2, n);
                y = coord_data(3, n);
                obj.nodes{n} = node(id, x, y);
            end %for      
            
        end %map
    end %methods
end %classdef