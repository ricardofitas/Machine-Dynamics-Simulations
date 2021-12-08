%% Description

% This is a script to analyse the eigenfrequencies of a two degree of
% freedom system

%% Output

% Frequency response plot of a two degree of freedom system.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 14/11/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 14/11/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures


%% 1.) Definitions
%% 1.) -Parameter definition

% Stiffness and damping values
damping_0                 = 1000;                   % Define a initial damping of 1000 value for the local minimum solver
damping_lower_bound       = 250;                    % Define a lower bound of 250 for the damping value 
damping_upper_bound       = 10000;                  % Define a upper bound of 10000 for the damping value
damping_vector = linspace(damping_lower_bound,damping_upper_bound,30);     % Define a dampingvector with 30 values from the lower to the upper bound

cost = NaN(size(damping_vector,2));      % Initialize the cost variable
k = 0;     % Initialize the counting variable for the rows of the cost matrix
for damping_f = damping_vector      % Define a for loop which loops over every damping vector entry for the front suspension
    k = k+1;                       % First counting variable goes one up
    kk = 0;                         % Initialize the counting variable for the columns of the cost matrix
    for damping_r = damping_vector % Define a for loop which loops over every damping vector entry for the rear suspension
        kk = kk + 1;                % Second counting variable goes one up
        [cost(k,kk),x,y] = Exercise_4_4_parameter_fit_obj_local(damping_f,damping_r);  % Define the objective function which gives you the cost value for a given damping constant combination.
    end
end
[X,Y] = meshgrid(damping_vector,damping_vector);   % Use the command meshgrid to generate a matrix which gives you a combination of each damping value

surf(X,Y,cost)
xlabel("Damping_f")  % Label the x axis, take a moment to think about the label is it rear or front damping?
ylabel("Damping_r") % Label the y axis, take a moment to think about the label is it rear or front damping?
zlabel("Cost")    % Label the z axis with the cost value
axis('square')          % Axis lines with equal length
    
%% 2.) Computing
f = @(x) Exercise_4_4_parameter_fit_obj_local(x(1),x(2));    % Define function handle for the local search. Consider that you now have to use two damping values.
%% 2.) Solving with local search
[damping_opt,value] = fminsearch(f, [damping_0 damping_0]);   % Find the local minimum by using "fminsearch" notice that fmincon would also work but is not support in the edX gui yet.
damping_opt
value
