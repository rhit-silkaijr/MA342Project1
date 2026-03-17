clear variables;
close all;
clc;

% Returns the length of a needed airfoil wing for a given
% two-dimensional wing profile
% P: the points of the 2-D profile
% bc: logical boolean, whether or not a boundary condition
% is given for the problem
% plt: logical boolean, whether to show plots
% P = [
%     3.00, -0.50;
%     0.00,  1.00;
%     -1.0, 0.00;
% ];
P = [
     3.00, -1.00;
     2.00,  0.00;
     0.00,  1.00;
    -3.00,  0.40;
    -3.20,  0.00;
    -3.00, -0.40;
     0.00, -0.50;
     3.00, -1.0010;
     3.85, -1.44;
];

% bc = false;
bc = true;
plt = true;

if (bc == true)
    adj = 2;
else
    adj = 1;
end

% Plot our current 2D foil
if plt
    figure;
    hold on;
    grid on;
    plot(P(:, 1), P(:, 2), 'bo');
end

% With our given points, determine normal
% vectors that correspond to the panels between
% each point. Note, these are only the ENDING points of the vectors
% not the actual "full" vectors
n_end = normal_vectors(P);
num_panels = length(n_end);
% TODO: implement normal vector plot

% Determine the angles between our current panels
% and the horizontal. The default rotation angle is going
% counter-clockwise.
% ie theta1 = rotate panel 1 correct angle so that
% it is parallel with the x-axis
theta = orientation_angles(n_end);

% our panels are now properly rotated, but now we need to move each
% panel so that its midpoint is moved to the origin. That way, we
% can calculate the effect of each *OTHER* panel on this "centered"
% panel. Also, this isn't the most particularly effecient way to
% do this 3D matrix setup, but it will work for now.
% R_rotation is what is actually left-hand multiplied against our existing
% panel vectors to rotate it, hence why it's a function of theta
R_rotation = zeros(2, 2, num_panels);

for i = 1:length(theta)
    R_rotation(:, :, i) = [
        cos(theta(i)),     -sin(theta(i));
        sin(theta(i)),     cos(theta(i));
    ];
end

% Now we need to actually move these to the origin. The way to do
% is to first calculate the midpoints of each of our panels.
% each row corresponds to each panel, as (x, y)
mp_panels = midpoints(P);

% We can now combine the midpoints of each panel, with their
% corresponding R_rotation matrix to create a combined
% R transformation matrix function for a given panel.
% Theta is a SINGLE value
R = @(theta) [
    cos(theta), -sin(theta);
    sin(theta), cos(theta);
];

% We now have to make a transformation matrix that essentially
% determines where every midpoint of every other panel when a
% selected midpoint set as the "transformed" one. Each row
% corresponds to the same "structure", and the zth dimension
% (ie each page) corresponds to the points, so the points in
% the first page are x-coordinates and the second page are
% z-coordinates. The coordinates down the diagonal will always
% be x, z = 0, 0
mp_panels_transformed = zeros(num_panels, num_panels, 2);

for i = 1:num_panels
    for j = 1:num_panels
        transform_vector = R(theta(i))*[
            mp_panels(j, 1) - mp_panels(i, 1);
            mp_panels(j, 2) - mp_panels(i, 2);
        ];

        mp_panels_transformed(i, j, 1) = transform_vector(1);
        mp_panels_transformed(i, j, 2) = transform_vector(2);
    end
end

% Now to grab the lengths of every panel. This will be important
% to compute the influence coefficients
l = line_lengths(P);
% d is simply half the length of every panel length
d = l/2;

% Now we need to compute the influence coefficients that influence
% each panel *from* each panel, at these transformed angles. Once
% again, the diagonals will not be considered
phi_panels_transformed = zeros(num_panels, num_panels, 2);

for i = 1:num_panels
    for j = 1:num_panels
        phi_temp = influence_coefficients( ...
            mp_panels_transformed(i, j, 1), ...
            mp_panels_transformed(i, j, 2), ...
            d(i));

        phi_panels_transformed(i, j, 1) = phi_temp(1);
        phi_panels_transformed(i, j, 2) = phi_temp(2);
    end
end

% before we can use these influence coefficients, we need to undo
% the transformation
phi_panels = zeros(num_panels, num_panels, 2);

for i = 1:num_panels
    for j = 1:num_panels
        phi_temp = R(theta(i))\[phi_panels_transformed(i, j, 1);phi_panels_transformed(i, j, 2);];

        phi_panels(i, j, 1) = phi_temp(1);
        phi_panels(i, j, 2) = phi_temp(2);
    end
end

% need to do a special transformation for the diagonal elements
phi_panels_diagonal = zeros(num_panels, 2);
for i = 1:num_panels
    phi_panels_diagonal(i, :) = transpose(R(theta(i))\[0; -1/(pi*d(i))]);
end

% Returns the phi coefficient
% Effect of panel j on panel i
% phi = @(i, j) [phi_panels(j, i, 1); phi_panels(j, i, 2)];

fprintf("ss")

function [p] = phi(i, j, phi_panels, phi_panels_diagonal)
    if i == j
        p = [phi_panels_diagonal(i, 1); phi_panels_diagonal(i, 2)];
    else
        p = [phi_panels(j, i, 1); phi_panels(j, i, 2)];
    end
end

% Now to compute our A matrix
A = zeros(length(P) - adj, length(P) - 1);

for i = 1:(length(P) - adj)
    for j = 1:(length(P) - 1)
        A(i, j) = n_end(i, :)*phi(i, j, phi_panels, phi_panels_diagonal);
    end
end

% Now we need to apply the "Kutta" condition, which takes into
% account the wake has on the other panels
if bc
    A(:, 1) = A(:, 1) - A(:, end);
    A(:, end - 1) = A(:, end - 1) - A(:, end);
    A(:, end) = [];
    n_end = n_end(1:(num_panels - 1), :);
end

% freestream velocities on each panel
b = 76 * n_end * [1; 0];

% doublet strengths
mu = A\b;

% wake strength
gamma = -(mu(end) - mu(1));

% assuming regular air density
rho = 1.225;
v_mag = 76;

% Lift Force
F_L = -gamma*v_mag*rho;

% Airplane model:
% (m*g)/(F_L) = L_wing
m = 70000;      % kg
g = 9.81;       % m/s^2
L_wing = (m*g)/F_L