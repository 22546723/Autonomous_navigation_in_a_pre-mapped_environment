classdef pose_estimator
    properties
        map;
        cam_intrinsics;
        tag_size;
        tag_family;    
    end

    methods
        function obj = pose_estimator(map, intrinsics, tag_size, tag_family)
            obj.map = map;
            obj.cam_intrinsics = intrinsics;
            obj.tag_family = tag_family;
            obj.tag_size = tag_size;
        end

        function [id, loc, pose] = find_markers(obj, frame)
            frame = undistortImage(frame, intrinsics, OutputView="same");
            [id, loc, pose] = readAprilTag(frame, obj.tag_family, intrinsics, obj.tag_size);
        end

        function marker_pos = pose_from_marker(id, loc, pose)
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
                    angle = 0;

                    %Not working yet - can't seem to get the correct coords
                    %%%%%%%%%%%%
                    for j=1:4
                        points = [loc(j, :, n).'; 0.02; 1]; %markers are 0.01m from the ground
                        temp = pose.A * points;
                        %corners(:, j, n) = temp(1:3); %coords of the tag corners relative to the camera
                        x = x + temp(1);
                        y = y + temp(2);
                        z = z + temp(3);
                    end %for j
                    %get avg coords of the markers and convert from mm to m
                    x = x/4;
                    y = y/4;
                    z = z/4;
                    %%%%%%%%%%%%

                    %Add marker coord offset
                    x_base = 0;
                    y_base = 0;
                    angle_base = 0;
                    for m=obj.map.markers
                        if m.id==id(n)
                            x_base = m.x_coord;
                            y_base = m.y_coord;
                            angle_base = m.angle;
                        end %if
                    end %for m

                    %add to total world coordinates
                    x_coord = x_coord + (x_base + x);
                    y_coord = y_coord + (y_base + y);
                    angle = angle_coord + (angle_base + angle);

                end %for n
           
                %get avg world coordinates
                x_coord = x_coord/num_tags;
                y_coord = y_coord/num_tags;
                angle = angle/num_tags;                
            end %if empty

            %put together final position
            marker_pos = [x_coord; y_coord; angle];

        end %pose from marker

%TODO: write pose_from_control function        
        function control_pos = pose_from_control(control_instructions, prev_pos)
            control_pos = prev_pos + control_instructions;
        end %pose from control

        function current_pos = get_current_pos(obj, marker_pos, control_pos)
            if ~isempty(marker_pos)
                current_pos = marker_pos;
            else
                current_pos = control_pos;
            end %if else
        end %get current pos

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