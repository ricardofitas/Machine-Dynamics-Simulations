%% Description

% This is a script to draw the coordinate system.

%% Output

% Coordinate system is drawn in the animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 07/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 07/12/2021 | Ricardo Fitas | creation

%% Program
%
%% 1.) Definitions
%% 1.1.) General
x_ar = 1*x_t_max_limit;
clr_cos = 'k';
variable_cos = 'x';
variable_cos2 = '\phi';
angle_cos2 = 0:0.01:0.85*pi;
clr_cos2 = 'r';

%% 2.) Plot
%% 2.1.) Plot coordinate system
plotcos(x_ar,angle_cos2,variable_cos,variable_cos2,clr_cos,clr_cos2,lnwidth,fntsz,3.5)