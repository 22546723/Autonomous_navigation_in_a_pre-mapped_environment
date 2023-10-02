classdef marker
    properties
        id;
        x_coord;
        y_coord;
        angle;
    end
    methods
        function obj = marker(id, x, y, angle)
            obj.id = id;
            obj.x_coord = x;
            obj.y_coord = y;
            obj.angle = angle;
        end
    end
end