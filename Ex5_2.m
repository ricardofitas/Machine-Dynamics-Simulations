%% Description

% This is a script to solve equation of motion - force excited - with
% different approaches

%% Output

% Frequency response plot of a two degrees-of-freedom system.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 06/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 14/11/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures

%% 1.) Definitions
%% 1.) -Parameter definition
% Masses and inertias
mass                      = 1000;                   % Mass of the body [kg]
inertia                   = 1000;                   % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f               = 60000;                  % Stiffness coefficient of spring [N/m]
damping_f                 = 100;                   % Damping coefficient of damper [Ns/m]
stiffness_r               = 60000;                  % Stiffness coefficient of spring [N/m]
damping_r                 = 100;                   % Damping coefficient of damper [Ns/m]

% Lengths center of gravity to front and rear end
length_f                  = 2.5;                    % Distance of the right spring-damper to the center of mass [m]
length_r                  = 2.5;                    % Distance of the left spring-damper to the center of mass [m]
force                     = 2000;                                  % Constant force value [N]
length_force              = 1.6;            % Distance point of force attack to center of gravity
omega                     = 0:0.1:50;                % Angular frequency of the excitation [1/s]

% Time and initial conditions
time = 0:0.005:20;                                   % Time [s]
x_0 = 0.1;                                         % Initial Condition displacement [m]
x_dot_0 = 0;                                        % Initial Condition velocity [m/s]
phi_0 = 0.0;                                        % Initial Condition angle [rad]
phi_dot_0 = 0;                                      % Initial Condition angle velocity [rad/s]

%% 2) Computing

% Set up system matrices
M = [mass 0 ; 0 inertia]; % Mass matrix

% Damping matrix
K = [damping_r+damping_f, length_f*damping_f-length_r*damping_r;...
    length_f*damping_f-length_r*damping_r, length_r^2*damping_r+length_f^2*damping_f];

% Stiffness matrix
C = [stiffness_r+stiffness_f, length_f*stiffness_f-length_r*stiffness_r;...
    length_f*stiffness_f-length_r*stiffness_r, length_r^2*stiffness_r+length_f^2*stiffness_f];

h_c = [force; length_force*force];
h_s = [0;0];

x = zeros(2,size(omega,2));

for k = 1:size(omega,2)
    h_star = 1/2 * (h_c - 1i*h_s);
    
    inv_freq_matrix_complex = C-omega(k)^2*M + 1i*omega(k)*K;
    F_star = inv(inv_freq_matrix_complex);
    
    x_star = F_star*h_star;
    
    x_c = real(2*x_star);
    x_s = -imag(2*x_star);
    
    x(:,k) = sqrt(x_c.^2 + x_s.^2);
    
end

x_hat = x(1,:);
phi_hat = x(2,:);

%% 3) Plot
time = omega;
x_t = x_hat;
v_t = phi_hat;
run('Exercise_5_2_initialize_figures.m')