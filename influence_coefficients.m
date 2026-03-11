% Returns i and j influence coefficients for a specified panel
function [phi] = influence_coefficients(x, z, d)
    syms a;
    f = [2.*(x - a).*z; z.^2 - (x - a).^2]/(norm(x - a, z).^4);

    phi = vpa(int(f, -d, d));
end