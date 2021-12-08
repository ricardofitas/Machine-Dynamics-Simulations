%% Description

% This is a script to draw the damper.

%% Output

% Damper is drawn in the animation.

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

clr_d = 'k';
y_offset_d = -0.2;

damper_foot = position_g(1) - dimension_g(1)/2;
damper_head = x_t(1) + dimension_m(1)/2;

stroke_length_max = damper_foot + abs(min(x_t+dimension_m(1)/2));

%% 2.) Plot
%% 2.) Draw Damper
plotdamper(stroke_length_max,damper_foot,damper_head,y_offset_d,clr_d,lnwidth);
