% Returns i and j influence coefficients for a specified panel
function [phi] = influence_coefficients(x, z, d)
    xdP = x+d;
    xdN = x-d;
    nPz = xdP^2+z^2;
    nNz = xdN^2+z^2;
    c1 = z/nPz-z/nNz;
    c2 = xdN/nNz-xdP/nPz;
    phi = [c1; c2]/(2*pi);
end