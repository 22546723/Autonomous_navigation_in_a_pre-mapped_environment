% Initial values
s_node = 1;
t_node = 1;
num_sims = 10;

% Format: {s_node, t_node, x, y, worked}
results = cell(num_sims, 12); 

w_space = get_param('full_system', 'ModelWorkspace');
%assignin(w_space, 't_node', 7)


for n=1:num_sims
    while(t_node==s_node)
        t_node = int32(1 + (11-1)*rand(1, 1));
    end


    assignin(w_space, 's_node', s_node)
    assignin(w_space, 't_node', t_node)
    
    sim("full_system.slx");

    x_meas = ans.simout.x;
    y_meas = ans.simout.y;
    ref_angle = ans.simout.ref_angle;
    meas_angle = ans.simout.meas_angle;
    error_angle = ans.simout.error_angle;
    ref_speed = ans.simout.ref_speed;
    meas_speed = ans.simout.v_car;
    ref_w = ans.simout.ref_w;
    meas_w = ans.simout.w_car;
    target_reached = ans.simout.target_reached;

    results(n, :) = {s_node, t_node, x_meas, y_meas, ref_angle, ...
        meas_angle, error_angle, ref_speed, meas_speed, ref_w, meas_w, target_reached};

    s_node = t_node;
end




