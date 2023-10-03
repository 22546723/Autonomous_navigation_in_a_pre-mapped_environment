classdef path_segment
    properties
        start;
        stop;
        R;
        mid_point;
    end %properties

    methods
        function obj = path_segment(start, stop, R, mid)
            obj.start = start;
            obj.stop = stop;
            obj.R = R;
            obj.mid_point = mid;
        end %function
    end %methods
end %classdef