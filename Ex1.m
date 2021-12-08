%% Description

% This is a script to solve the differential equation of a single mass
% spring.

%% Output

% Formated figure of the displacement of a single mass system and its
% simulation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 18/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 18/10/2021 | Ricardo Fitas | creation

%% Program

clear
close all
clc

%% 1) Definition
%% 1.1) Parameter definition

mass = 750; % mass of the body [kg]
stiffness = 50000; % [N/m]
time = 0:0.01:2; % [s]

x_0 = 0.01; % [m]
x_dot_0 = 0.2; % [m/s]

%% 1.2) Symbolic function definition
syms x(t)
Dx = diff(x,1);
D2x = diff(x,2);

%% 2) Computing
%% 2.1) Solve the equation
x = dsolve(mass*D2x + stiffness*x == 0, x(0) == x_0, Dx(0) == x_dot_0, 't');


%% 2.2) Evaluate the equation
x_fun = matlabFunction(x);
x_dot_fun = matlabFunction(diff(x));

x_t = x_fun(time);
v_t = x_dot_fun(time);

%% 2.3) Calculate amplitude
x_roof = max(abs(x_t));

%% 2.4) Calculate time period

[maxima, max_location] = findpeaks(x_t,time);
time_period = diff(max_location);

%% 2.5) Calculate eigenfrequency and angular eigenfrequency
frequency = 1/time_period(1);
angular_eigenfrequency = 2*pi*frequency;

%% 2.6) Calculate phase angle
temp_variable = diff(sign(v_t));
indx_up = find(temp_variable>0);
indx_down = find(temp_variable<0);
indx_up_time = time(indx_up);
indx_down_time = time(indx_down);
first_zero_crossing = min([indx_up_time, indx_down_time]);
phase_angle_rad = angular_eigenfrequency*first_zero_crossing;
phase_angle_degree = 180/pi*phase_angle_rad;
%% 3) Ploting
%% 3.1) Ploting parameters
clr = [236/255 237/255 237/255];
units  = 'normalized';
linewidth = 2;
fontsize = 22;
pos_fig = [0.01, 0.1, 0.98, 0.8];
title_graph = 'Displacement and velocity vs. time';
xlabel_graph = 'Time [s]';
ylabel_graph{1} = 'Displacement x [m]';
ylabel_graph{2} = 'Velocity v [m/s]';

%% 3.2) Plot graph

fig = figure('color', clr, 'units', units, 'position', pos_fig);
[axes_graph, line1, line2] = plotyy(time, x_t, time, v_t);
set(line1, 'color','k','linewidth', linewidth);
set(line2, 'color','r','linewidth', linewidth);
set(axes_graph(1),'Ycolor','k','linewidth', linewidth, 'fontsize',fontsize);
set(axes_graph(2),'Ycolor','r','linewidth', linewidth, 'fontsize',fontsize);

xlabel(axes_graph(1),xlabel_graph, 'fontsize',fontsize);
ylabel(axes_graph(1),ylabel_graph{1}, 'fontsize',fontsize);
ylabel(axes_graph(2),ylabel_graph{2}, 'fontsize',fontsize);

title(title_graph);

x_t_max_limit = max(abs(x_t)) + 0.05*max(abs(x_t));
ylim(axes_graph(1),[-x_t_max_limit, x_t_max_limit]);

v_t_max_limit = max(abs(v_t)) + 0.05*max(abs(v_t));
ylim(axes_graph(2),[-v_t_max_limit, v_t_max_limit]);