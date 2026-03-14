function [l] = line_lengths(P)
    l_temp = zeros(length(P) - 1, 1);
    line_length_f = @(p1, p2) sqrt((p2(1) - p1(1))^2 + (p2(2) - p1(2))^2);
    
    for i = 1:length(l_temp)
        l_temp(i) = line_length_f(P(i, :), P(i + 1, :));
    end

    l = l_temp;
end