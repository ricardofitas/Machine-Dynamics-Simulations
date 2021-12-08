%% Description

% This is a script to draw the mass.

%% Output

% Mass is drawn in the animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program
%
%% 1.) Definitions
%% 1.) General
dimension_m = [0.25*x_t_max_limit*5 1.5 1.5];
position_m = [abs(min(x_t))*2-0.01 0 0];
clr_m = 'r';

%% 3.) Plot
%% 3.) Draw ground
plotcube(axes_ani,dimension_m,position_m,clr_m);