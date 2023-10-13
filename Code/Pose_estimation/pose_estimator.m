classdef pose_estimator
    % pose_estimator    estimates the car pose using control instructions
    %                   and markers
    % pose_estimator Properties:
    %   map - map object
    %   cam_intrinsics - camera intrinsics
    %   tag_size - size of the tags in meter            
    %   tag_family - AprilTag family
    %   current_pose - current estimated pose - [x; y; angle]
    %
    % See also map, cameraParameters/Intrinsics, camera_calibration
    %
    % pose_estimator Methods:
    %   pose_estimator - class initialisation
    %   find_markers - identify all markers in a frame
    %   pose_from_marker - estimate the pose using marker data
    %   pose_from_control - estimate pose using control instructions
    %   get_current_pose - estimate the current pose using the marker and
    %                      control pose estimations

    properties
        map;
        cam_intrinsics;
        tag_size;
        tag_family;  
        current_pose;
    end

    methods
        function obj = pose_estimator(map, start_pose)
            % pose_estimator    initialise pose_estimator class
            % Inputs:
            %   map : map object
            %   start_pose  : starting pose on the map - [x; y; angle]
            % See also map
            %
            % Outputs:
            %   obj : pose_estimator object

            obj.map = map;
            focalLength = [4.260104110385426e+02,4.572738582555217e+02];
            principalPoint = [4.912992236555515e+02,3.012009299604217e+02];
            imageSize = [600,1200];
            radialDistortion = [0.009100768838994,-0.014302243268843];
            K = [4.260104110385426e+02,0,4.912992236555515e+02;0, ... 
                4.572738582555217e+02,3.012009299604217e+02;0,0,1];

            obj.cam_intrinsics = cameraIntrinsics(focalLength, ...
                principalPoint, imageSize, 'RadialDistortion', ...
                radialDistortion); %, "K", K);

            obj.tag_family = "tag36h11";
            obj.tag_size = 70*10^(-3); % 70mm
            obj.current_pose = start_pose;
        end

        function [id, loc, pose, gotMarker] = find_markers(obj, frame)
            % find_markers  finds all markers in a frame
            % Inputs:
            %   frame   : 3D image array from the camera 
            % Outputs:
            %   id  : array of marker IDs
            %   loc : array of marker corner coordinates (image
            %         coordinates) for each marker
            %   pose    : marker poses as an array of rigidtform3d objects
            % See also rigidtform3d, readAprilTag
            frame = undistortImage(frame, intrinsics, OutputView="same");
            [id, loc, pose] = readAprilTag(frame, obj.tag_family, intrinsics, obj.tag_size);

            if isempty(loc)
                gotMarker = 0;
            else
                gotMarker = 1;
            end
        end

        function marker_pos = pose_from_marker(id, loc, pose)
            % pose_from_marker  estimate the pose using marker data
            % Inputs:
            %   id - array of marker IDs
            %   loc - image coordinates of tag corners
            %   pose - marker poses as an array of rigidtform3d objects
            % Outputs:
            %   marker_pos - [x_coord; y_coord; angle] of the car based on 
            %                the marker poses

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

        function control_pos = pose_from_control(obj, diff_x, diff_y, diff_angle)
            % pose_from_control     estimate pose using control instructions
            % Inputs:
            %   diff_x      : change in x direction
            %   diff_y      : change in y direction
            %   diff_angle  : change in angle
            % Outputs:
            %   control_pos : [x coord; y coord; angle] of the car
            %                   estimated from the control instructions

            x = obj.current_pose(1) + diff_x;
            y = obj.current_pose(2) + diff_y;
            angle = obj.current_pose(3) + diff_angle;

            control_pos = [x; y; angle];
        end %pose from control

        function obj = update_pose(obj, marker_pos, gotMarker, control_pos)
            % update_pose   update the current pose using marker and
            %                   control estimations
            %
            % marker pose takes priority
            %
            % Inputs:
            %   marker_pos  : pose from marker estimation
            %   control_pos : pose from control estimation
            % Outputs:
            %   obj    : updated object with the new current_pose
            
            if gotMarker==1
                obj.current_pose = marker_pos;
            else
                obj.current_pose = control_pos;
            end %if else
        end
        
        function current_pose = get_current_pose(obj)
            % get_current_pose   return the current pose property
            %
            % marker pose takes priority
            %
            % Outputs:
            %   current_pose    : current pose
            
            current_pose = obj.current_pose;
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