%load marker images
marker_0 = imread("markers/id0.png");
marker_3 = imread("markers/id3.png");
marker_7 = imread("markers/id7.png");
marker_23 = imread("markers/id23.png");
marker_34 = imread("markers/id34.png");

marker_0_r = imread("markers/m0.png");
marker_3_r = imread("markers/m3.png");
marker_7_r = imread("markers/m7.png");
marker_23_r = imread("markers/m23.png");
marker_34_r = imread("markers/m34.png");

%add them into an array
markers = {marker_0 marker_3 marker_7 marker_23 marker_34 marker_0_r ...
    marker_3_r marker_7_r marker_23_r marker_34_r};

%array of the correct marker ids
marker_ids = [0 3 7 23 34 0 3 7 23 34];

len = 10;

rec_ids = zeros([1 len]);
found = zeros([1 len]);

markerRec = marker_recognition;

hit_count = 0;

%get the recognised ids and count hits
for i=1:len
    [rec_ids(i), found(i)] = markerRec.find(markers{i});
    if (rec_ids(i)==marker_ids(i))
        hit_count = hit_count + 1;
    end
end

hit_rate = hit_count/len;

%display
res = table(marker_ids.', rec_ids.', found.');
res.Properties.VariableNames = ["Actual ID", "Recognised ID", "Identified"];
disp(res)

disp("Accuracy: " + hit_rate*100 + "%")