%% MA342 Project 1
%% Experiment 1 - Increasing the number of panels
clear variables;
close all;
clc;

v = 76;         % m/s
naca2418 = importdata('naca2418.dat.txt');
num_panels = transpose(5:2:35);
C_L1 = zeros(length(num_panels), 1);

for i = 1:length(C_L1)
    X = points_based_on_input(naca2418,num_panels(i));
    X = [X; X(1, :)];
    X = [X; [1.1, -0.05]];
    C_L1(i) = airfoil_wing(X, v, false);
end

figure;
plot(num_panels, C_L1);
grid on;
title("Experiment 1: Altering the number of panels")
xlabel("Number of Panels");
ylabel("Lift Coefficient (C_L)");

%% Experiment 2 - Changing the wake angle
wa_length = 0.1118;
theta_max = pi/4;
theta_iter = linspace(0, theta_max, 25);
C_L2 = zeros(length(theta_iter), 1);
num_panels_2 = 13;

for i = 1:length(C_L2)
    X = points_based_on_input(naca2418, num_panels_2);
    X = [X; X(1, :)];
    X = [X; [1 + wa_length*cos(theta_iter(i)), -wa_length*sin(theta_iter(i))]];
    C_L2(i) = airfoil_wing(X, v, false);
end

figure;
plot(theta_iter, C_L2);
grid on;
title("Experiment 2: Altering the wake angle")
xlabel("Wake Angle Theta (rad)");
ylabel("Lift Coefficient (C_L)");
