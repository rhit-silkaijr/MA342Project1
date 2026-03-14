% Return the midpoints for every set of points
% Should be length(mp) = length(P) - 1
function [mp] = do_cool_shit(P)
    mp_temp = zeros(length(P) - 1, 2);

    for i = 1:length(mp_temp)
        mp_temp(i, 1) = P(i + 1, 1) - P(i, 1);
        mp_temp(i, 2) = P(i + 1, 2) - P(i, 2);
    end

    mp = mp_temp;
end