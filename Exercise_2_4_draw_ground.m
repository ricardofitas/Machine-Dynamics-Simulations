%% Description

% This is a script to draw the ground.

%% Output

% Ground is drawn in the animation.

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
dimension_g = [0.25*x_t_max_limit 2 2];
position_g = [abs(min(x_t))*2+.005 0 0];
clr_g = 'k';

%% 3.) Plot
%% 3.) Draw ground
plotcube(axes_ani,dimension_g,position_g,clr_g);
