% Does some really cool shit
% returns the normal vectors with respect to each panel in matrix P
% P MUST be a n x 2 matrix, where each row represents the x and y coordinates
% of every panel, starting with the wake (bottom-right) panel, going
% COUNTER CLOCKWISE
function [n] = normal_vectors(P)
    n_temp = zeros(length(P) - 1, 2);
    
    line_length = @(p1, p2) [p2(1) - p1(1); 0; p2(2) - p1(2)];

    for i = 1:length(n_temp)
        line = line_length(P(i, :), P(i + 1, :));
        stuff = (cross([0; -1; 0], line))/norm(cross([0; -1; 0], line));
        n_temp(i, :) = [stuff(1); stuff(3)];
    end

    n = n_temp
end