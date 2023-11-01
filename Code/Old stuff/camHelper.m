classdef camHelper
    properties
        intrinsics;
    end

    methods
        function obj = camHelper()
            cam_intrinsics = load('Camera_calibration/new_params.mat');
            obj.intrinsics = cam_intrinsics.params.Intrinsics;
        end%init

        function [id, loc, pose, gotMarker, x, y] = getMarkers(obj, frame)
            tag_family = "tag36h11";
            tag_size = 0.1; %10cm
            %frame = undistortImage(frame, obj.intrinsics, OutputView='same');
            [id, loc, pose] = readAprilTag(frame, tag_family, obj.intrinsics, tag_size);

            if isempty(loc)
                gotMarker = 0;
                id = 404;
                loc = [404, 404; 404, 404; 404, 404; 404, 404];
                pose = zeros(4, 4, 1);
                %pose = rigidtform3d(A);
                x=0;
                y=0;
            else
                gotMarker = 1;
                
                %%%%%%%%%%%%%%%%%%%%%%%
                marker_coords = [2 0 0.15];
                %[x, y] = getCoords(pose, marker_coords);
                t = pose.Translation;

                R1 = [0 0 1; 1 0 0; 0 -1 0];  %x = z_c | y = x_c | z = -y_c
                Ta = blkdiag(R1,1);
                Tb = eye(4);

                po = [t(:); 1];
                p = Tb*Ta*po;
                meas = p(1:3).';
                coord = marker_coords - meas;
                x = coord(1)+0.2;
                y = coord(2);
                %%%%%%%%%%%%%%%%%%%%%%%%%%5
                pose = pose.A;
            end
        end %getMarkers

%         function [x, y] = getCoords(pose, marker_coords)
%             tform = rigidtform3d(pose);
%             t = tform.Translation;
% 
%             R1 = [0 0 1; 1 0 0; 0 -1 0];  %x = z_c | y = x_c | z = -y_c
%             Ta = blkdiag(R1,1);
%             Tb = eye(4);
% 
%             po = [t(:); 1];
%             p = Tb*Ta*po;
%             meas = p(1:3).';
%             coord = marker_coords - meas;
%             x = coord(1);
%             y = coord(2);
%         end

    end %methods

end %class