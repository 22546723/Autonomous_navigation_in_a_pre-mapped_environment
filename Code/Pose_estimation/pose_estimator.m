classdef pose_estimator
    properties
        cam_intrinsics;
        tag_size;
        tag_family;
    end

    methods
        function obj = pose_estimator(intrinsics, tag_size, tag_family)
            obj.cam_intrinsics = intrinsics;
            obj.tag_family = tag_family;
            obj.tag_size = tag_size;
        end

        function [id, loc, pose] = find_markers(obj, frame)
            frame = undistortImage(frame, intrinsics, OutputView="same");
            [id, loc, pose] = readAprilTag(frame, obj.tag_family, intrinsics, obj.tag_size);
        end

        function [x_coord, y_coord, angle] = pose_from_marker(id, loc, pose)
            %temp
            x_coord = 0;
            y_coord = 0;
            angle = 0;

            if ~isempty(loc)
                num_tags = size(loc, 3);

                for n=1:num_tags
                    x = 0;
                    y = 0;
                    z = 0;

                    %Not working yet - can't seem to get the correct coords
                    %%%%%%%%%%%%
                    for j=1:4
                        points = [loc(j, :, n).'; 0.02; 1]; %markers are 0.01m from the ground
                        temp = pose.A * points;
                        %corners(:, j, n) = temp(1:3); %coords of the tag corners relative to the camera
                        x = x + temp(1);
                        y = y + temp(2);
                        z = z + temp(3);
                    end
                    %get avg coords of the markers and convert from mm to m
                    x = x/4;
                    y = y/4;
                    z = z/4;
                    %%%%%%%%%%%%

                    %Add marker coord offset
                    x_base = 
                end
           
                
            end
        end

%         function output = estimate(obj, frame)
%             cam_data = load("calibration/camera_params.mat");
%             intrinsics = cam_data.params.Intrinsics;
%             tag_size = 0.07; %tag size in m
%             frame = undistortImage(frame, intrinsics, OutputView="same");
%             [id, loc, pose] = readAprilTag(frame, "tag36h11", intrinsics, tag_size);
% 
%             if ~isempty(loc)
%                 num_tags = size(loc, 3);
%                 %corners = zeros(3, 4, num_tags, 'double');
%                 output = zeros(4, num_tags, 1, 'double'); %contains the id, x, y, z info for each tag
%                 loc = loc/1000;
% 
%                 for n=1:num_tags
%                     x = 0;
%                     y = 0;
%                     z = 0;
%                     for j=1:4
%                         
%                         points = [loc(j, :, n).'; 0.02; 1]; %markers are 0.01m from the ground
%                         temp = pose.A * points;
%                         %corners(:, j, n) = temp(1:3); %coords of the tag corners relative to the camera
%                         x = x + temp(1);
%                         y = y + temp(2);
%                         z = z + temp(3);                    
%                     end
%                     %get avg coords of the markers and convert from mm to m
%                     x = x/4;
%                     y = y/4;
%                     z = z/4;
%                     output(:, n) = [id(n); x; y; z];
%                     
%                 end
%             else
%                 output = [404; 404; 404; 404];
%             end
%         end
    end
end