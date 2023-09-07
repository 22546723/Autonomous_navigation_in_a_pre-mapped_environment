classdef tag_info
    methods
        function [id, loc] = get(obj, img)
            [id, loc] = readAprilTag(img);
        end
    end
end

% img = imread("tag36h11_png/tag36_11_00001.png");
% [id, loc] = readAprilTag(img)
