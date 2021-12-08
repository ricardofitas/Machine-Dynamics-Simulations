%% Description

% This is a script to animate a two degree of freedom system under base
% excitation.

%% Output

% Formatted figure of the displacement and angle of a two degree of freedom
% system and its animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 07/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 07/12/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures
%% 1) Definitions
%% 1.1) Parameter definition
% Masses and inertias
mass                = 10000;                 % Mass of the body [kg]
inertia             = 500;                 % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f         = 50000;                % Stiffness coefficient of the spring [N/m]
damping_f           = 50;                    % Damping coefficient of damper [Ns/m]
stiffness_r         = 60000;                % Stiffness coefficient of the spring [N/m]
damping_r           = 500;                    % Damping coefficient of the damper [Ns/m]

% Lengths centre of gravity to front and rear end
length_f            = 2.5;                  % Distance of the right spring-damper to the centre of mass [m]
length_r            = 2.5;                  % Distance of the left spring-damper to the centre of mass [m]

% Time and initial conditions
time = linspace(0,10,1000);                           % Time [s]
x_0 = 0.0;                                  % Initial Condition displacement [m]
x_dot_0 = 0;                                % Initial Condition velocity [m/s]
phi_0 = 0/180*pi;                           % Initial condition angle [rad]
phi_dot_0 = 0;                              % Initial condition angle velocity [rad/s]

length_exc = length_f + length_r;
velocity = 10/3.6;
s_max = 0.05;

omega = (velocity*2*pi)/length_exc;
delta = ((length_f+length_r)*2*pi)/length_exc;

phi_0 = asin((s_max*cos(-delta)-s_max)/(length_f+length_r)) + phi_0;
x_0 = length_r*((s_max*cos(-delta)-s_max)/(length_f+length_r)) + s_max + x_0;



%% 2) Computing
%% 2.1) Numerical solution of the motion
w0 = [x_0,phi_0, x_dot_0, phi_dot_0];       % Create a vector with initial conditions
[tsim,wsim] = ode45(@state_space_equation,time,w0,'options',mass,inertia,stiffness_f,stiffness_r,damping_f,damping_r,length_f, length_r, 0, 0, 0);

% Renaming
time = tsim';           
x_t = wsim(:,1)';
phi_t = wsim(:,2)';
phi_t_plot = phi_t/pi*180;
v_t = wsim(:,3)';
omega_t = wsim(:,4)';

%% 3) Plot
%% 3.1) Initialize figures
run('Exercise_5_2_initialize_figures.m')   % Runs the script to initialise the figures

%% 3.3) Draw mass
run('Exercise_5_2_draw_mass.m')

%% 3.4) Draw street
hold on
dimension_g = [0.25*x_t_max_limit 6 2];
position_g = [x_t_max_limit + s_max + dimension_m(1) 0 0];
hold on

%% 3.4) Draw spring front
run('Exercise_5_2_raw_spring_front.m')  

%% 3.5) Draw spring rear
run('Exercise_5_2_raw_spring_rear.m')

%% 3.6) Draw damper front
run('Exercise_5_2_raw_damper_front.m')

%% 3.7) Draw damper rear
run('Exercise_5_2_raw_damper_rear.m')

%% 3.8) Draw cos
run('Exercise_5_2_draw_cos.m')
% Rotate Views
view(90,-90);

%% 3.9.) Plot Animation
% Initialise vectors

x_t_length =length(x_t);
t_plot = NaN(1,x_t_length);
x_t_plot = NaN(1,x_t_length);
v_t_plot = NaN(1,x_t_length);
phi_t_plot = NaN(1,x_t_length);
u = 1;
for k = 1:x_t_length
    cla
    
    factor_minimum = (length_f + length_r)/length_exc;
    factor = (length_f + 0.3 + length_r + 0.3)/length_exc;
    
    y_street_minimum = linspace(-length_r,length_f,1000);
    y_street = linspace(-length_r - 0.3, length_f + 0.3,1000);
    
    x_oscillation_vector_minimum = linspace(0,2*pi*factor_minimum,1000);
    x_oscillation_vector  =linspace(0,2*pi*factor,1000);
    
    x_street_minimum = s_max*cos(x_oscillation_vector_minimum + omega*time(u)) + position_g(1);
    x_street = s_max*cos(x_oscillation_vector + omega*time(u) -0.3) + position_g(1);
    %figure(10),plot(x_street,y_street)
    %figure(1)
    % Plot Graph
    
    t_plot(k) = time(u);
    x_t_plot(k) = x_t(u);
    phi_t_plot(k) = phi_t(u)/pi*180;
    v_t_plot(k) = v_t(u);
    
    set(graph_plot(1),'Parent',axes_graph(1),'XData',t_plot,'YData',x_t_plot);
    set(graph_plot(2),'Parent',axes_graph(2),'XData',t_plot,'YData',phi_t_plot);
    
    % Plot street
    plot(x_street, y_street,'Linewidth',5,'Color','k');

    % Plot mass
    position_m =[x_t(u) 0 0];
    angle = phi_t(u);
    plotcube(axes_ani,dimension_m,position_m,clr_m,angle)
    
    % Plot spring front
    spring_head_front = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_s_front;
    spring_foot_front = x_street_minimum(end) *0.95;
    x_pos_spring_front = phi_s/phi_max*(spring_head_front - spring_foot_front) + spring_foot_front;
    plot3(axes_ani,x_pos_spring_front,y_pos_spring_front,z_pos_spring_front,'b','linewidth',lnwidth);
    
    % Plot spring rear
    spring_head_rear = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_s_rear;
    spring_foot_rear = x_street_minimum(1) *0.95;
    x_pos_spring_rear = phi_s/phi_max*(spring_head_rear - spring_foot_rear) + spring_foot_rear;
    plot3(axes_ani,x_pos_spring_rear,y_pos_spring_rear,z_pos_spring_rear,'b','linewidth',lnwidth);
    
    % Plot damper front
    damper_head_front = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_d_front;
    damper_foot_front = x_street_minimum(end)*0.95;
    plotdamper(stroke_length_max,damper_foot_front,damper_head_front,y_offset_d_front,clr_d,lnwidth)
    
    % Plot damper rear
    damper_head_rear = x_t(u) + dimension_m(1)/2 - sin(phi_t(u))*y_offset_d_rear;
    damper_foot_rear = x_street_minimum(1)*0.95;
    plotdamper(stroke_length_max,damper_foot_rear,damper_head_rear,y_offset_d_rear,clr_d,lnwidth)
     
    % Plot connection spring damper front
    y_connect_front = (length_f-0.25):0.01:(length_f+0.25);
    x_connect_front = repmat(damper_foot_front,length(y_connect_front));
    plot(x_connect_front,y_connect_front,'k','linewidth',lnwidth)
    
    % Plot connection spring damper rear
    y_connect_rear = (-length_r-0.25):0.01:(-length_r+0.25);
    x_connect_rear = repmat(damper_foot_rear,length(y_connect_rear));
    plot(x_connect_rear,y_connect_rear,'k','linewidth',lnwidth);
    scatter(x_connect_rear(1),-length_r,50,'k','filled')
    scatter(x_connect_rear(end),length_f,50,'k','filled')
    
    
    run('Exercise_5_2_draw_cos.m')
    
    title(title_ani,'fontsize',fntsz);
    xlabel(xlabel_ani,'fontsize',fntsz);
    
    drawnow
    
    u = u + 1;
end