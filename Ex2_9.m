%% Description

% This is a script to solve the differential equation of a single mass
% spring.

%% Output

% Formated figure of the displacement of a single mass system and its
% animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program

clear 
clc
close all

%% 1.) Definition
%% 1.1.) Parameter definition
mass = 750; % mass of the body [kg]
stiffness = 50000; % [N/m]
damping = 0; % [Ns/m]
time = 0:0.01:1; % [s]

x_0 = 0.01; % [m]
x_dot_0 = 0; % [m/s]

%% 2.) Computing
w0 = [x_0, x_dot_0];

%% 2.1.) Numerical solution of the motion
[tsim, wsim] = ode45(@state_space_equation,time,w0,'options',mass,stiffness,damping);

time = tsim';
x_t = wsim(:,1)';
v_t = wsim(:,2)';


function dw = state_space_equation(~,w,mass,stiffness,damping)

A = [0,1; -stiffness/mass, -damping/mass];

dw = A*w;

end