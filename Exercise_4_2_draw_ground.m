%% Description

% This is script to draw the ground.

%% Output

% Ground is drawn in the animation.

%% Version
% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 07/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 07/12/2021 | Ricardo Fitas | creation

%% 1) Definitions
%% 1.1) General
dimension_g = [0.25*x_t_max_limit 3 2];             % length, width and height of the ground
position_g = [abs(min(x_t))*2.5 0 0];               % Position of the ground depending on the minimum distance
clr_g = 'k';                                        % Color of the ground

%% 3) Plot
%% 3.1) Draw ground
plotcube(axes_ani,dimension_g, position_g, clr_g)   % Initialize the ground

