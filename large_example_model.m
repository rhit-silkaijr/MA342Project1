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

A = AMatrix(P, line_lengths, n, theta, mp);

% Do transformations
A(:, 1) = A(:, 1) - A(:, end);
A(:, end - 1) = A(:, end - 1) - A(:, end);
A(:, end) = [];

disp(A*100);

% remove wake effect
n = n(1:7, :);

% freestream velocities on each panel
b = 76 * n * [1; 0];

% doublet strengths
mu = A\b;

% wake strength
gamma = -(mu(end) - mu(1));

% assuming regular air density
rho = 1.225;
v_mag = 76;

% Lift Force
F_L = -gamma*v_mag*rho

% Airplane model:
% (m*g)/(F_L) = L_wing
m = 70000;      % kg
g = 9.81;       % m/s^2
L_wing = (m*g)/F_L

