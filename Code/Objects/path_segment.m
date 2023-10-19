classdef path_segment
    % path_segment  Describes a section of the planned path
    %
    % path_segment Properties:
    %   start - starting coordinates
    %   stop - end coordinates
    %   R - turn radius
    %   mid_point - mid point of the circle that describes the turn
    %
    % path_segment Methods:
    %   path_segment - class initialisation

    properties
        start;          % start coordinates - [x; y]
        stop;           % stop coordinates - [x; y]
        R;              % turn radius
        mid_point;      % mid point of the circle that describes the turn 
                        % - [x; y]. NOTE: this is only used to plot the turn when displaying the reference path
    end %properties

    methods
        function obj = path_segment(start, stop, R, mid)
            % path_segment  Initialise path_segment class
            % Inputs: 
            %   start   : start coordinates - [x; y]
            %   stop    : stop coordinates - [x; y]
            %   R       : turn radius
            %   mid     : mid point of the circle that describes the turn -
            %             [x; y]
            % Outputs:
            %   obj     : path_segment object
            
            obj.start = start;
            obj.stop = stop;
            obj.R = R;
            obj.mid_point = mid;
        end %function
    end %methods
end %classdef