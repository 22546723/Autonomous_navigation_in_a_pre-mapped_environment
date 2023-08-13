img = imread("7x7_test.png");
% test = [1 2 3 4];
% command = "test.py -i" + img;
% command = string(command);
res = pyrunfile("test.py", "disp", img=img);
res = double(py.array.array('d',py.numpy.nditer(res)));
res = reshape(res,[1138 1156 3]);
imshow(res)

