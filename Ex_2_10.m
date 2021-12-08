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
open_system('Ex_2_10_solver')
out = sim('Ex_2_10_solver');

x_t = out.simout.data(:,1);
plot(x_t)