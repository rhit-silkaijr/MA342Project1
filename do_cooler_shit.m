% Compute the big A matrix
function [A] = do_cooler_shit(P, l, n, theta, mp)
    A_temp = zeros(length(P) - 1, length(P));

    R = @(theta) [
        cos(theta),     -sin(theta);
        sin(theta),     cos(theta);
    ];

    R_val = R(theta);

    d = l/2;

    for i = 1:length(P) + 1
        for j = 1:length(P)
            if i == j
                A_temp(i, j) = dot(n(j, :), [0, -1/(pi*d(j))]);
            else
                dphi = influence_coefficients(P(i, 1), P(i, 2), d(j));
                disp(n(j));
                disp(R_val(j)\dphi);
                A_temp(i, j) = dot(n(j), R_val(j)\dphi);
            end
        end
    end
end