% Compute the big A matrix
function [R_transf] = do_cooler_shit(P, l, n, theta)
    R_temp = zeros(length(P));

    R = @(theta) [
        cos(theta),     -sin(theta);
        sin(theta),     cos(theta);
    ];

    R_val = R(theta);

    for i = 1:length(R_temp)
        for j = 1:length(R_temp)
            if i == j
                R_temp(i, j) = 1;
            else
                R_temp(i, j) = R_val(i, :)
            end
        end
    end
end