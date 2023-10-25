% speed = get(data, 1).Values.Data;
% torque = get(data, 2).Values.Data;
s = tf('s');
G_s = 1/s;
sisotool('rlocus', G_s)