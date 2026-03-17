clear variables;
close all;
clc;

% Returns the length of a needed airfoil wing for a given
% two-dimensional wing profile
% P: the points of the 2-D profile
% bc: logical boolean, whether or not a boundary condition
% is given for the problem
% plt: logical boolean, whether to show plots
P = [
    3.00, -0.50;
    0.00,  1.00;
    -1.0, 0.00;
];

bc = false;
plt = true;

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
R_rotation = zeros(2, 2, length(theta));

for i = 1:length(theta)
    R_rotation(:, :, i) = [
        cos(theta(i)),     -sin(theta(i));
        sin(theta(i)),     cos(theta(i));
    ];
end

% Now we need to actually move these to the origin. The way to do
% is to first calculate the midpoints of each of our panels.
% each row corresponds to each panel, as (x, y)
mp = midpoints(P);

% We can now combine the midpoints of each panel, with their
% corresponding R_rotation matrix to create a combined
% R transformation matrix function for a given panel.
R = @(theta) [
    
]




