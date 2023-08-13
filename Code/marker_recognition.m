classdef marker_recognition
    methods
        function [id, found]=find(obj, img)
            % call detect_marker.py to get the marker id
            id = pyrunfile("detect_marker.py", "ids", img=img);
            
            % replace the py.none ids with 0 and record where they occured
            found = isa(id, "py.numpy.ndarray");
            if not(found)
                id = 0;
            end
        end
    end
end

%Current marker settings: 
%size: 70mm
%dict: cv.aruco.DICT_7X7_100
%generated using: https://chev.me/arucogen/
