%% Description

% This is a script to draw the coordinate system.

%% Output

% Coordinate system is drawn in the animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program
%
%% 1.) Definitions
%% 1.1.) General
x_ar = 0.5*x_t_max_limit;
clr_cos = 'k';
variable_cos = 'x';


%% 2.) Plot
%% 2.1.) Plot coordinate system
plotcos(x_ar,variable_cos,clr_cos, lnwidth,fntsz)