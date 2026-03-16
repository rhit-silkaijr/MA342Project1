%% MA342 Project 1 "Large" Example Model
clear variables;
close all;
clc;

P = [
     3.00, -1.00;
     2.00,  0.00;
     0.00,  1.00;
    -3.00,  0.40;
    -3.20,  0.00;
    -3.00, -0.40;
     0.00, -0.50;
     3.00, -1.00;
     3.85, -1.44;
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

AMatrix(P, line_lengths, n, theta, mp)

