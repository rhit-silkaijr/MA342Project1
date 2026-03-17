%% MA342 Project 1 Small Model Test
clear variables;
close all;
clc

P = [
    3.00, -0.50;
    0.00,  1.00;
    -1.0, 0.00;
];

% Step 3
n = normal_vectors(P);

% Step 4
theta = orientation_angles(n);

% Steps 5-8 R transformations
mp = midpoints(P);

R = @(theta) [
    cos(theta),     -sin(theta);
    sin(theta),     cos(theta);
];

R_val = R(theta);

line_lengths = line_lengths(P)

figure;
plot (P(:, 1), P(:, 2), 'bo');
hold on;
grid on;
axis equal;
for i = 1:length(n)
    plot([mp(i, 1), mp(i, 1) + n(i, 1)], [mp(i, 2), mp(i, 2) + n(i, 2)], 'r');
end

A = AMatrix(P, line_lengths, n, theta, false);