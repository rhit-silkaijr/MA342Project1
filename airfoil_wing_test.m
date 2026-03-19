%% MA342 Project 1
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

% assuming regular air density, kg/m^3
    rho = 1.225;
m = 70000;      % kg
v = 76;         % m/s

[C_L1] = airfoil_wing(P, v, true);

naca2418 = importdata('naca2418.dat.txt');
X = points_based_on_input(naca2418,15);
X = [X; X(1, :)];
% X = [X; X(1:5, :)];
% X(1:5, :) = [];
% X = [X; X(1, :)];
X = [X; [1.1, -0.05]];
% plot(X(:,1),X(:,2));
% axis equal
% plot(X(:,1),X(:,2));
% grid on;
% axis equal;

[C_L2] = airfoil_wing(X, v, true);

fprintf("C_L is: %10.3f \n", C_L2);
