%Read test marker
img = imread("7x7_test.png");
% call detect_marker.py to get the marker id
id = pyrunfile("detect_marker.py", "ids", img=img);
disp(id)


