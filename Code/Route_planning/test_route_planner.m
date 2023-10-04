% Runs route_planner.m and displays the results

map =  load('Maps/path_segment_test.mat');
map = map.map_data;

planner = route_planner(map);
[path, distance, edgepath]  = plot_route(planner, 1, 5);
ref_signal = convert_to_ref(planner, path);

nodes = map.nodes;
len = length(nodes);

tiledlayout(2, 2);

%%%%%%%%%%%%%%%
%plot weighted graph
nexttile
G = map.weighted_graph;
p = plot(G, 'EdgeLabel', G.Edges.Weight);
highlight(p, 'Edges', edgepath)
title("Weighted graph")

%%%%%%%%%%%%%%%%%%
%plot reference signal
nexttile
ref_len = length(ref_signal)+1;
xr = zeros(ref_len, 1, 1, "double");
yr = zeros(ref_len, 1, 1, "double");

hold on
for n=1:ref_len-1
    xr(n) = ref_signal{n}.start(1);
    yr(n) = ref_signal{n}.start(2);

    xr(n+1) = ref_signal{n}.stop(1);
    yr(n+1) = ref_signal{n}.stop(2);

    %plot curves
    R = ref_signal{n}.R;
    pnt = ref_signal{n}.mid_point;
    xm = pnt(1)-R:0.2:pnt(1)+R;

    dx = xm-pnt(1);
    theta = acos(dx/R);
    ym = R*sin(theta);
    yp = pnt(2) + abs(ym);
    yn = pnt(2) - abs(ym);

    plot(xm, yp, xm, yn)
end

plot(xr, yr)
hold off
title("Route")
xlabel("X");
ylabel("Y");
%%%%%%%%%%%%%%%%%%
%plot node coordinates
id = zeros(len, 1, 1, "double");
x = zeros(len, 1, 1, "double");
y = zeros(len, 1, 1, "double");

for n=1:len
    id(n) = nodes{n}.id;
    x(n) = nodes{n}.x_coord;
    y(n) = nodes{n}.y_coord;
end

nexttile
plt = plot(x, y, 'o');
row = dataTipTextRow("ID",id);
plt.DataTipTemplate.DataTipRows = row;

for n=1:len
    dt = datatip(plt,x(n),y(n));
end
grid on
title("Node coordinates")
xlabel("X");
ylabel("Y");
%%%%%%%%%%%%%%%%%%%%%%