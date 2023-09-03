classdef marker_recognition
    methods
        function [id, found, corners]=find(obj, img)
            % call detect_marker.py to get the marker id
            [id, corners] = pyrunfile("detect_marker.py", ["ids" "corners"], img=img);
            
            corners = cell(corners);
            
            if isempty(corners)
                corners = [404 404 404 404; 404 404 404 404];
            else                
                corners = double(corners{:});
            end

            % replace the py.none ids with 0 and record where they occured
            found = isa(id, "py.numpy.ndarray");
            if ~found
                id = 404;
            end

            %id = num2cell(id);
        end
    end
end

%Current marker settings: 
%size: 70mm
%dict: cv.aruco.DICT_7X7_100
%generated using: https://chev.me/arucogen/
