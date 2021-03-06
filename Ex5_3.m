%% Description

% This is a script to optimize the position of the excitation of a force
% excited two degree of freedom system.

%% Output

% Optimal length of excitation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 06/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 06/12/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures

%% 1.) Definitions
%% 1.) -Parameter definition
length_force_0 = 1.6;            % Initial distance point of force to center of gravity
length_force_lower_bound       = -4;  % Lower bound of force length
length_force_upper_bound       = 4; % Upper bound of force length

force                      = 2000 ;                % Force on the body [N]
omega                      = 2.4;                 % Angular frequency of the excitation [1/s]

length_force_vector = length_force_lower_bound:0.01:length_force_upper_bound; % Define a force vector from the lower to the upper bound with an inkrement of 0.01
cost = [];  % Initialize the cost vector
k = 0;  % Initialize the counting variable
for length_force  = length_force_vector % Loop over the length force
    k = k + 1;  % Counting variable goes one up
    cost(k) = Exercise_5_3_force_length_obj(length_force,omega);  % Excecute the objective function
end

%plot(length_force_vector,cost)  % Plot and inspect the cost function. Plot the cost values over the length_force_vector
axis('square')                  % Axis lines with equal length
   
%% 2.) Computing
%% 2.) Solving with local search
f = @(x) Exercise_5_3_force_length_obj(x,omega);        % Define function handle for the local search
length_force_opt_one_omega = fminsearch(f,length_force_0);
%% 2.) Solving with local search for different omega
kk = 0;  % Initialise counting variable
omega_vector = 0:30;
mass_vector = 50:60:4000;
for omega = omega_vector   % Define a omega vector from 1 to 30 with an inkrement of 0.1 and loop over that vector
    k = 0;
    kk = kk + 1;  % Counting variable goes one up
    for mass = mass_vector
        k = k + 1;
        f = @(x) Exercise_5_3_force_length_obj(x,omega,mass);      % Define function handle for the local search
        
        % You could use fmincon on your local MATLAB version. It is not
        % supported on the edx gui. You can also define boundary conditions
        % with the fmincon command.
        %length_force_opt_fmincon(omega) = fmincon(f,length_force_0,[],[],[],[],length_force_lower_bound,length_force_upper_bound); 
        length_force_opt_fminsearch(k,kk) = fminsearch(f,length_force_0);       % Use fminsearch to find the minimum  % Use fminsearch to find the minimum of the cost function

    end
end
[X,Y] = meshgrid(omega_vector,mass_vector);   % Use the command meshgrid to generate a matrix which gives you a combination of each damping value

figure(1),surf(X,Y,length_force_opt_fminsearch)

damping_0                 = 1000;                   % Define a initial damping of 1000 value for the local minimum solver
damping_lower_bound       = 250;                    % Define a lower bound of 250 for the damping value 
damping_upper_bound       = 10000;                  % Define a upper bound of 10000 for the damping value
damping_vector = linspace(damping_lower_bound,damping_upper_bound,30);     % Define a dampingvector with 30 values from the lower to the upper bound
mass = 1000;
cost = NaN(size(damping_vector,2));      % Initialize the cost variable
k = 0;     % Initialize the counting variable for the rows of the cost matrix
for damping_f = damping_vector      % Define a for loop which loops over every damping vector entry for the front suspension
    k = k+1;                       % First counting variable goes one up
    kk = 0;                         % Initialize the counting variable for the columns of the cost matrix
    for damping_r = damping_vector % Define a for loop which loops over every damping vector entry for the rear suspension
        kk = kk + 1;                % Second counting variable goes one up
        omega = 6;
        [~,cost(k,kk)] = Exercise_5_3_force_length_obj(length_force_opt_fminsearch(omega+1),omega,mass,damping_f,damping_r);  % Define the objective function which gives you the cost value for a given damping constant combination.
    end
end
[X,Y] = meshgrid(damping_vector,damping_vector);   % Use the command meshgrid to generate a matrix which gives you a combination of each damping value

xlabel("Damping_f")  % Label the x axis, take a moment to think about the label is it rear or front damping?
ylabel("Damping_r") % Label the y axis, take a moment to think about the label is it rear or front damping?
zlabel("Cost")    % Label the z axis with the cost value
axis('square')          % Axis lines with equal length

%% 2.) Computing
f = @(x) Exercise_4_4_parameter_fit_obj_local(x(1),x(2));    % Define function handle for the local search. Consider that you now have to use two damping values.
%% 2.) Solving with local search
[damping_opt,value] = fminsearch(f, [damping_0; damping_0]);   % Find the local minimum by using "fminsearch" notice that fmincon would also work but is not support in the edX gui yet.
figure(2),surf(X,Y,cost)
