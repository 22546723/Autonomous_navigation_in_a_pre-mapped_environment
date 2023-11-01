% Initial values
s_node = 1;
t_node = 1;
num_sims = 5;

% Format: {s_node, t_node, x, y, worked}
results = cell(num_sims, 5); 

for n=1:num_sims
    while(t_node==s_node)
        t_node = int32(1 + (11-1)*rand(1, 1));
    end

    %sim("plant_setup.slx");

    x_meas = 2;
    y_meas = 0;
    reached_target = 1;

    results(n, :) = {s_node, t_node, x_meas, y_meas, reached_target};

    s_node = t_node;
end




