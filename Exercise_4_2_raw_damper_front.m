%% Description

% This is a script to draw the damper front.

%% Output

% Damper front is drawn in the animation.

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

clr_d = 'k';
y_offset_d_front = 0.9;

damper_foot_front = position_g(1) - dimension_g(1)/2;
damper_head_front = x_t(1) + dimension_m(1)/2;

stroke_length_max = abs(min(x_t + dimension_m(1)/2)) + damper_foot_front;

%% 2.) Plot
%% 2.) Draw Damper
plotdamper(stroke_length_max,damper_foot_front,damper_head_front,y_offset_d_front,clr_d,lnwidth);
