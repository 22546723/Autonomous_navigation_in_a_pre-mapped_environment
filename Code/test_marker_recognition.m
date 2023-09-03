% NB: all images used for testing MUST be named '...<ID>.png' otherwise the
% script won't be able to read the image IDs from the file names

%create datastores of the folders containing the images to be used for
%testing
imds_actual = imageDatastore("markers/actual/");
imds_digital = imageDatastore("markers/digital/");

runTest(imds_actual, "Actual images");
runTest(imds_digital, "Digital images");

function runTest(imds, disp_header)
% SETUP
len = length(imds.Files);
imgs = cell(1, len);
ids = cell(1, len);

%Read images in datastore. Get ids from the filenames
i = 1;
while hasdata(imds)
    [img, id] = read(imds);
    id = id.Filename;

    % check num id digits in filename & set id val
    id_len = length(id);
    id_0 = id(id_len - 5);

    if isempty(str2num(id_0))
        id = str2num(id(id_len - 4));        
    else
        id = str2num(id(id_len-5:id_len-4));
    end

    imgs{1, i} = img;
    ids{1, i} = id;

    i = i+1;
end

% TEST
rec_ids = zeros([1 len]);
found = zeros([1 len]);
corners = cell(1, len);

markerRec = marker_recognition;

hit_count = 0;

%get the recognised ids and count hits
for i=1:len
    [rec_ids(i), found(i), corners{i}] = markerRec.find(imgs{1, i});
    if (rec_ids(i)==ids{1, i})
        hit_count = hit_count + 1;
    end
end

hit_rate = hit_count/len;

ids_disp = cell2mat(ids.');

%display
disp(disp_header)

res = table(ids_disp, rec_ids.', found.');
res.Properties.VariableNames = ["Actual ID", "Recognised ID", "Identified"];
disp(res)

disp("Accuracy: " + hit_rate*100 + "%")
disp("_________________________________")

disp(size(imgs{1, 1}))
%disp(corners{1})
end

% COMMENTS
% so far it only misses the partially shaded/obscured markers
