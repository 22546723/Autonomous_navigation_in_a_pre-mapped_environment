% Runs route_planner.m and displays the results
s_node = 1;
t_node = 6;

%now gets set in route planner class
% map =  load('Maps/straight_line_test.mat');
% map = map.map_data;

planner = route_planner();
[path, distance]  = plot_route(planner, s_node, t_node);
%ref_signal = convert_to_ref(planner, path);
ref = get_ref_array(planner, s_node, t_node);

map = planner.map;

nodes = map.nodes;
len = length(nodes);

t = tiledlayout(2, 2);

%%%%%%%%%%%%%%%
%plot weighted graph
nexttile
G = map.weighted_graph;
p = plot(G, 'EdgeLabel', G.Edges.Weight);
highlight(p, path, 'EdgeColor', 'red')
title("Weighted graph")

%%%%%%%%%%%%%%%%%%
%plot reference signal
nexttile(2, [2 1])
ref_len = length(ref);
xr = zeros(ref_len+1, 1, 1, "double");
yr = zeros(ref_len+1, 1, 1, "double");

hold on
for n=1:ref_len
%     xr(n) = ref_signal{n}.start(1);
%     yr(n) = ref_signal{n}.start(2);
% 
%     xr(n+1) = ref_signal{n}.stop(1);
%     yr(n+1) = ref_signal{n}.stop(2);

    xr(n) = ref(1, n);
    yr(n) = ref(2, n);

    xr(n+1) = ref(3, n);
    yr(n+1) = ref(4, n);

    %plot curves
%     R = ref_signal{n}.R;
%     
%     if ~(R==0)
%         pnt = ref_signal{n}.mid_point;
%         interval = abs(xr(n+1)-xr(n))/5;
%         x_max = max(xr(n), xr(n+1));
%         x_min = min(xr(n), xr(n+1));
%         xm = x_min:interval:x_max;
% 
%         dx = xm-pnt(1);
%         theta = acos(dx/R);
%         ym = R*sin(theta);
%         yp = pnt(2) + abs(ym);
%         yn = pnt(2) - abs(ym);
% 
%         pos_match1 = (yp(1)==yr(n)) && (yp(length(yp))==yr(n+1));
%         pos_match2 = (yp(1)==yr(n+1)) && (yp(length(yp))==yr(n));
%         pos_match = pos_match1 || pos_match2;
% 
%         diff_p_max = max([yp(1) yp(length(yp))]) - max([yr(n) yr(n+1)]);
%         diff_p_min = min([yp(1) yp(length(yp))]) - min([yr(n) yr(n+1)]);
%         diff_p = abs(diff_p_min) + abs(diff_p_max);
% 
%         diff_n_max = max([yn(1) yn(length(yn))]) - max([yr(n) yr(n+1)]);
%         diff_n_min = min([yn(1) yn(length(yn))]) - min([yr(n) yr(n+1)]);
%         diff_n = abs(diff_n_min) + abs(diff_n_max);
% 
%         % plot(xm, yp)
%         % plot(xm, yn)
% 
%         if diff_p < diff_n
%             plot(xm, yp)
%             %yc = yp;
%         else
%             plot(xm, yn)
%             %yc = yn;
%         end
%     end

end

plot(xr, yr)

hold off
title("Route")
xlabel("X [m]");
ylabel("Y [m]");
%legend("Curved reference route", "Original reference route")
grid on
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
xlabel("X [m]");
ylabel("Y [m]");
%%%%%%%%%%%%%%%%%%%%%%

temp = "Plotted route from node "+s_node+" to node "+t_node;
title(t, temp)