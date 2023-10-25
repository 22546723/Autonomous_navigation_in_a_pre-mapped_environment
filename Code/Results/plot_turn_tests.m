file = load("Results/movement_test_turn_left.mat");
data = file.data;

R_L = data.R_L;
R_R = data.R_R;
v_L = data.v_L;
v_R = data.v_R;

tiledlayout(2, 2);

nexttile
hold on
plot(R_L)
plot(v_L)
hold off
grid on
xlabel('Time (s)')
ylabel('Speed (m/s)')
legend('Reference speed', 'Actual speed')
title('Left wheel')

nexttile
hold on
plot(R_R)
plot(v_R)
hold off
grid on
xlabel('Time (s)')
ylabel('Speed (m/s)')
legend('Reference speed', 'Actual speed')
title('Right wheel')

nexttile
hold on
plot(R_L)
plot(R_R)
hold off
grid on
xlabel('Time (s)')
ylabel('Speed (m/s)')
legend('Left reference speed', 'Right reference speed')
title('Reference speeds')

nexttile
hold on
plot(v_L)
plot(v_R)
hold off
grid on
xlabel('Time (s)')
ylabel('Speed (m/s)')
legend('Left wheel speed', 'Right wheel speed')
title('Actual wheel speeds')