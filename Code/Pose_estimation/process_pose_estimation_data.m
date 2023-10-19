estimated = load("estimated_pose.mat").estimated_pose;
actual = load("actual_pose.mat").actual_pose;
len = length(estimated);

err = zeros(3, len, 1, 'double');

for n=1:len
    for j=2:4
        if (estimated(j+1, n)==404) && ~(actual(j, n)==404)
            err(j-1, n) = actual(j, n);
            estimated(j+1, n) = 0;
        else
            err(j-1, n) = actual(j, n) - estimated(j+1, n);
        end
    end
end

x = actual(1, :);
yyaxis left
plot(x, estimated(3, :),x, actual(2, :))
title('Estimated vs actual coordinates (x-axis)')
xlabel('Time')
ylabel('Coordinates')


yyaxis right
plot(x, err(1, :))
ylabel('Error')
legend('Estimated', 'Actual', 'Error')

display(estimated(:, 250))
display(actual(:, 250))