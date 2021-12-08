%% Description

% This is script to draw the spring front.

%% Output

% Sprint front is drawn in the animation.

%% Version
% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 07/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 07/12/2021 | Ricardo Fitas | creation

%% 1) Definitions
%% 1.1) General
spring_number_windings = 8;                                 % Number of spring windings
spring_radius = 0.1;                                        % Radius of spring radius
phi_max = 2*pi*spring_number_windings;                      % Calculate the maximum angle of spring rotations
phi_s = 0:pi/50:phi_max;                                    % Define a vector in order to calculate y and z position of the spring
y_offset_s_front = length_f + 0.25;                                     % Spring y-offset
y_pos_spring_front = spring_radius * sin(phi_s) + y_offset_s_front; % Calculate y position of spring vertices
z_pos_spring_front = spring_radius * cos(phi_s);            % calculate z position of spring vertices
spring_foot_front = position_g(1) - dimension_g(1)/2;       % position of the spring foot
spring_head_front = x_t(1) + dimension_m(1)/2;              % Initial position of spring head

%% 3) Plot
%% 3.1) Draw spring
x_pos_spring_front = phi_s/phi_max * (spring_head_front - spring_foot_front) + spring_foot_front;
plot3(axes_ani,x_pos_spring_front,y_pos_spring_front,z_pos_spring_front,'b','linewidth',lnwidth)

