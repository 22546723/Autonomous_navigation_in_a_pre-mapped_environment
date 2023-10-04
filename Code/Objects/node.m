classdef node
    % node    Node object
    % node Properties:
    %   id - node ID
    %   x_coord - x coordinate 
    %   y_coord - y coordinate
    %
    % node Methods:
    %   node - class initialisation    
    properties
        id;
        x_coord;
        y_coord;
    end
    methods
        function obj = node(id, x, y)
            % node    Initialise node class
            % Inputs:
            %   id  : node id
            %   x   : x coordinate
            %   y   : y coordinate
            % Outputs:
            %   obj : node object
            obj.id = id;
            obj.x_coord = x;
            obj.y_coord = y;
        end
    end
end