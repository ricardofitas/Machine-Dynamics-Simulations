%% Description

% This is a script to solve the differential equation of a single mass
% system.

%% Output

% Formatted figure of the displacement of a single mass system and its
% animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 06/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 06/12/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures

%% 1) Definitions
%% 1.1) Parameter definition
% Masses and inertias
mass                = 100;                 % Mass of the body [kg]
inertia             = 200;                 % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f         = 50000;                % Stiffness coefficient of the spring [N/m]
damping_f           = 0;                    % Damping coefficient of damper [Ns/m]
stiffness_r         = 6000;                % Stiffness coefficient of the spring [N/m]
damping_r           = 10;                    % Damping coefficient of the damper [Ns/m]

% Lengths centre of gravity to front and rear end
length_f            = 2.5;                  % Distance of the right spring-damper to the centre of mass [m]
length_r            = 0.5;                  % Distance of the left spring-damper to the centre of mass [m]

% Time and initial conditions
time = 0:0.005:1;                           % Time [s]
x_0 = 0.1;                                  % Initial Condition displacement [m]
x_dot_0 = 0;                                % Initial Condition velocity [m/s]
phi_0 = 1/180*pi;                           % Initial condition angle [rad]
phi_dot_0 = 0;                              % Initial condition angle velocity [rad/s]

%% 2) Computing
%% 2.1) Numerical solution of the motion
w0 = [x_0,phi_0, x_dot_0, phi_dot_0];       % Create a vector with initial conditions
[tsim,wsim] = ode45(@state_space_equation,time,w0,'options',mass,inertia,stiffness_f,stiffness_r,damping_f,damping_r,length_f, length_r, 0, 0, 0);

% Renaming
time = tsim';           
x_t = wsim(:,1)';
phi_t = wsim(:,2)';
v_t = wsim(:,3)';
omega = wsim(:,4)';

%% 3) Plot
%% 3.1) Initialize figures
run('Exercise_4_2_initialize_figures.m')   % Runs the script to initialise the figures

%% 3.2) Draw ground
hold on
run('Exercise_4_2_draw_ground.m')          % Runs the script to draw the ground

%% 3.3) Draw mass
run('Exercise_4_2_draw_mass.m')

%% 3.4) Draw spring front
run('Exercise_4_2_raw_spring_front.m')  

%% 3.5) Draw spring rear
run('Exercise_4_2_raw_spring_rear.m')

%% 3.6) Draw damper front
run('Exercise_4_2_raw_damper_front.m')

%% 3.7) Draw damper rear
run('Exercise_4_2_raw_damper_rear.m')

%% 3.8) Draw cos
run('Exercise_4_2_draw_cos.m')
% Rotate Views
view(90,-90);

%% 3.9.) Plot Animation
% Initialise vectors

x_t_length =length(x_t);
t_plot = NaN(1,x_t_length);
x_t_plot = NaN(1,x_t_length);
v_t_plot = NaN(1,x_t_length);

u = 1;
for k = 1:x_t_length
    cla
    
    % Plot Graph
    
    t_plot(k) = time(u);
    x_t_plot(k) = x_t(u);
    v_t_plot(k) = v_t(u);
    
    set(graph_plot(1),'Parent',axes_graph(1),'XData',t_plot,'YData',x_t_plot);
    set(graph_plot(2),'Parent',axes_graph(2),'XData',t_plot,'YData',v_t_plot);
    
    % Plot ground
    plotcube(axes_ani,dimension_g,position_g,clr_g)
    
    % Plot mass
    position_m =[x_t(u) 0 0];
    angle = phi_t(u);
    plotcube(axes_ani,dimension_m,position_m,clr_m,angle)
    
    % Plot spring front
    spring_head_front = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_s_front;
    x_pos_spring_front = phi_s/phi_max*(spring_head_front - spring_foot_front) + spring_foot_front;
    plot3(axes_ani,x_pos_spring_front,y_pos_spring_front,z_pos_spring_front,'b','linewidth',lnwidth);
    
    % Plot spring rear
    spring_head_rear = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_s_rear;
    x_pos_spring_rear = phi_s/phi_max*(spring_head_rear - spring_foot_rear) + spring_foot_rear;
    plot3(axes_ani,x_pos_spring_rear,y_pos_spring_rear,z_pos_spring_rear,'b','linewidth',lnwidth);
    
    % Plot damper front
    damper_head_front = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_d_front;
    plotdamper(stroke_length_max,damper_foot_front,damper_head_front,y_offset_d_front,clr_d,lnwidth)
    
    % Plot damper rear
    damper_head_rear = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_d_rear;
    plotdamper(stroke_length_max,damper_foot_rear,damper_head_rear,y_offset_d_rear,clr_d,lnwidth)
     
    run('Exercise_4_2_draw_cos.m')
    
    
    
    title(title_ani,'fontsize',fntsz);
    xlabel(xlabel_ani,'fontsize',fntsz);
    
    drawnow
    
    u = u + 1;
end