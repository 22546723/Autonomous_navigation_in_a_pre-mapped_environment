classdef marker
    % marker    Marker object
    %
    % marker Properties:
    %   id - marker ID
    %   x_coord - x coordinate 
    %   y_coord - y coordinate
    %   angle - marker angle in rad
    %
    % marker Methods:
    %   marker - class initialisation
    properties
        id;
        x_coord;
        y_coord;
        angle;
    end
    methods
        function obj = marker(id, x, y, angle)
            % marker    Initialise marker class
            % Inputs:
            %   id  : marker id
            %   x   : x coordinate
            %   y   : y coordinate
            %   angle   : angle in radians
            % Outputs:
            %   obj : marker object
            
            obj.id = id;
            obj.x_coord = x;
            obj.y_coord = y;
            obj.angle = angle;
        end
    end
end