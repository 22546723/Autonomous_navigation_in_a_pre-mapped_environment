classdef camHelper
    properties
        intrinsics;
    end

    methods
        function obj = camHelper()
            cam_intrinsics = load('Camera_calibration/new_params.mat');
            obj.intrinsics = cam_intrinsics.params.Intrinsics;
        end

        function [id, loc, pose, gotMarker] = getMarkers(obj, frame)
            tag_family = "tag36h11";
            tag_size = 0.1; %10cm
            frame = undistortImage(frame, obj.intrinsics, OutputView='same');
            [id, loc, pose] = readAprilTag(frame, tag_family, obj.intrinsics, tag_size);

            if isempty(loc)
                gotMarker = 0;
                id = 404;
                loc = [404, 404; 404, 404; 404, 404; 404, 404];
                pose = zeros(4, 4, 1);
                %pose = rigidtform3d(A);
            else
                gotMarker = 1;
                pose = pose.A;
            end
        end

    end

end