classdef node 
    properties
        id;
        x_coord;
        y_coord;
    end
    methods
        function obj = node(id, x, y)
            obj.id = id;
            obj.x_coord = x;
            obj.y_coord = y;
        end
    end
end