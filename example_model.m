%% MA342 Project 1 Example Model
clear variables;
close all;
clc;

% Step 2
AB = [-3; 0; 3/2];
BC = [-1; 0; -1];

% Step 3
n1 = (cross([0; -1; 0], AB))/norm(cross([0; -1; 0], AB))