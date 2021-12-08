%% Description

% This is script to draw the mass.

%% Output

% Mass is drawn in the animation.

%% Version
% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 07/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 07/12/2021 | Ricardo Fitas | creation

%% 1) Definitions
%% 1.1) General
dimension_m = [0.5*x_t_max_limit length_exc+1 0.2];          % length, width and height of the mass
position_m = [x_t(1) 0 0];                          % Initial position of the mass
clr_m = 'r';                                        % Color of the mass
angle = 0;

%% 3) Plot
%% 3.1) Draw mass
plotcube(axes_ani,dimension_m, position_m, clr_m,angle)   % Initialize the mass
