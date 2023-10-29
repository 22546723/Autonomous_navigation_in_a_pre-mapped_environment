R = out.r.Data;
W = out.w;
slope = zeros(length(W), 2, 1, "double");
max_slope = [0, 0];

for n = 1:length(W.Data)-1
    slope(n, 1) = W.Time(n);
    slope(n, 2) = (W.Data(n+1) - W.Data(n))/(W.Time(n+1) - W.Time(n));

    if slope(n, 2) > max_slope(2)
        max_slope(2) = slope(n, 2);
        max_slope(1) = slope(n, 1);
    end
end


plot(W)
disp(max_slope)
