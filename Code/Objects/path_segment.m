classdef path_segment
    properties
        start;
        stop;
        R;
    end %properties

    methods
        function obj = path_segment(start, stop, R)
            obj.start = start;
            obj.stop = stop;
            obj.R = R;
        end %function
    end %methods
end %classdef