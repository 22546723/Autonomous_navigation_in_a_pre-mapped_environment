vars = load('sim_vars_out.mat', 'ans');
vars = vars.ans;

x_pose = vars.pose.x_pos;
y_pose = vars.pose.y_pos;
angle = vars.pose.angle;

diff_x = vars.diffs.diff_x;
diff_y = vars.diffs.diff_y;

diff_angle = vars.angles.diff_angle;
new_angle = vars.angles.new_angle;
angular_v = vars.angles.angular_velocity;

R_R = vars.ref_speeds.R_R;
R_L = vars.ref_speeds.R_L;

seg_count = vars.segment_info.count;
dist = vars.segment_info.dist;

%plot
tiledlayout(2, 3);

%pose
nexttile
hold on
yyaxis left
plot(x_pose.Data, y_pose.Data)
plot(2, 2, 'o')
yyaxis right
plot(x_pose.Data, angle.Data)
hold off
xlabel("x")

yyaxis left
ylabel("y")

yyaxis right
ylabel("angle (rad)")

grid on

%segment info
nexttile
hold on
plot(seg_count)
plot(dist)
hold off
legend("segment counter", "distance to point")
grid on

%diffs
nexttile
hold on
yyaxis left
plot(diff_x)
plot(diff_y)
yyaxis right
plot(diff_angle)
hold off
xlabel("time")

yyaxis left
ylabel("diff x&y")

yyaxis right
ylabel("diff angle (rad)")

legend("diff x", "diff y", "diff angle")
grid on

%angles
nexttile
hold on
yyaxis left
plot(new_angle)
yyaxis right
plot(angular_v)
hold off
xlabel("time")

yyaxis left
ylabel("new angle")

yyaxis right
ylabel("angular velocity")
grid on

%speeds
nexttile
hold on
plot(x_pose.Data, R_L.Data)
plot(x_pose.Data, R_R.Data)
hold off
xlabel("x")
ylabel("speed")
legend("R_L", "R_R")
grid on

%angles 2
nexttile
hold on
yyaxis left
plot(x_pose.Data, diff_angle.Data(1:51))
plot(x_pose.Data, angle.Data)
plot(x_pose.Data, new_angle.Data(1:51))

yyaxis right
plot(x_pose.Data, angular_v.Data)
hold off
xlabel("x")
yyaxis left
ylabel("angle")

yyaxis right
ylabel("angular velocity")
legend("diff angle", "angle", "new angle", "angular velocity")
grid on


