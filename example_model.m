%% MA342 Project 1 Example Model
clear variables;
close all;
clc;

% Step 2
AB = [-3; 0; 3/2];
BC = [-1; 0; -1];

% Step 3
n1 = (cross([0; -1; 0], AB))/norm(cross([0; -1; 0], AB));
n1 = n1([1, 3], 1)
n2 = (cross([0; -1; 0], BC))/norm(cross([0; -1; 0], BC));
n2 = n2([1, 3], 1)

% Step 4
theta1 = acos(dot(n1, [0; -1]))
theta2 = -acos(dot(n2, [0; -1]))

% Step 6
R = @(theta) [
    cos(theta),     -sin(theta);
    sin(theta),     cos(theta);
];

% Step 7
R1 = R(theta1)
R2 = R(theta2)

% Step 8
R1_transf = R1*[(-0.5) - 1.5; (0.5 - 0.25)]
R2_transf = R2*[(1.5) + 0.5; (0.25) - 0.50]

% Step 9
% Use line length eq.
line_length = @(p1, p2) sqrt((p2(1) - p1(1))^2 + (p2(2) - p1(2))^2);
d1 = line_length([0; 1], [3, -1/2])/2
d2 = line_length([-1; 0], [0, 1])/2

% Step 10
influence_coefficients(R2_transf(1), R2_transf(2), d2);

% TODO: fix the shit above so it actually works. In the meantime...
%coef = [0.0499; -0.0190];