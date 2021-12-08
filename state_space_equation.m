function dw = state_space_equation(time, w, mass, inertia, stiffness_f, stiffness_r, damping_f,damping_r, length_f, length_r, length_force, force, omega) 
%% Description

% This is a function to solve equation of motion (with force) using state
% space representation

%% Input
% time:                         time vector
% w:                            initial state vector
% mass:                         mass of the car
% stiffness_f:                  stiffness front spring
% stiffness_r:                  stiffness rear spring
% damping_f:                    stiffness front damper
% damping_r:                    stiffness rear damper
% inertia:                      inertia
% length_f:                     distance front spring damper to centre of
%                                   gravity
% length_r:                     distance rear spring damper to centre of
%                                   gravity
% length_force:                 distance between force point of attack and
%                                   centre of gravity
% force:                        force amplitude
% omega:                        angular frequency of the force excitation
%

%% Output

% dw:                           State space representation

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 06/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 14/11/2021 | Ricardo Fitas | creation


%% Compute

% Set up system matrix
A = [0 0 1  0; 0 0 0 1; ((-stiffness_r - stiffness_f)/mass) ((stiffness_r*length_r - stiffness_f*length_f)/mass) ((-damping_r - damping_f)/inertia) ((damping_r*length_r - damping_f*length_f)/inertia);
    ((-stiffness_f*length_f + stiffness_r*length_r)/inertia) ((-stiffness_f*length_f^2 - stiffness_r*length_r^2)/inertia) ((-damping_f*length_f + damping_r*length_r)/inertia) ((-damping_f*length_f^2 - damping_r*length_r^2)/inertia)];

B = [0;0; (force/mass)*cos(omega*time); (force*length_force/inertia)*cos(omega*time)];

% Return state space representation
dw = A*w + B;
end