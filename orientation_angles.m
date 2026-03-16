function [theta] = orientation_angles(n)
    theta_temp = zeros(length(n), 1);

    for i = 1:length(theta_temp)
        theta_temp(i) = acos(dot(n(i, :), [0; -1]));

        if n(i, 1) < 0
            theta_temp(i) = theta_temp(i) * -1;
        end
    end

    theta = theta_temp;
end