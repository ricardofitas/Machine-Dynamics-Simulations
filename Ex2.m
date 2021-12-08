%% Description

% This is a script to solve the differential equation of a single mass
% spring.

%% Output

% Formated figure of the displacement of a single mass system and its
% simulation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures

%% 1.) Definitions
%% 1.1.) Parameter definition
mass                             = 750;                 % Mass of the body [kg]
stiffness                        = 50000;               % Stiffness Coefficient of spring [N/m]
damping                          = 0;                   % Damping coefficient of the damper [Ns/m]
time                             = 0:0.01:1;            % Time [s]

x_0                              = 0.01;                % Initial Condition displacement
x_dot_0                          = 0;                   % Initial Condition velocity

%% 2.) Computing
%% 2.1.) Parameter calculation
dampingcoefficient = damping/(2*mass);
angulareigenfrequency = sqrt(stiffness/mass);

%% 2.2.) Calculation of the characteristic polynomial
lambda = roots([1, 2*dampingcoefficient, angulareigenfrequency^2]);

%% 2.3.) Calculation of the constants
k1 = (x_dot_0 - lambda(2)*x_0) / (lambda(1) - lambda(2));
k2 = (lambda(1)*x_0 - x_dot_0) / (lambda(1) - lambda(2));

%% 2.4.) Calculation of the solution
x_t_h = k1*exp(lambda(1)*time) + k2*exp(lambda(2)*time);
v_t_h = k1*lambda(1)*exp(lambda(1)*time) + k2*lambda(2)*exp(lambda(2)*time);

x_t = real(x_t_h);
v_t = real(v_t_h);

%% 3.) Plot
%% 3.1.) Initialise figures
run('Exercise_2_3_initialize_figures.m');

%% 3.2.) Draw ground
hold on
run('Exercise_2_4_draw_ground.m');

%% 3.3.) Draw mass
run('Exercise_2_4_draw_mass.m');

%% 3.4.) Draw spring
run('Exercise_2_5_draw_spring.m');

%% 3.5.) Draw damper
run('Exercise_2_6_draw_damper.m');

%% 3.6.) Draw coordinate system
run('Exercise_2_7_draw_cos.m');

%% 3.7.) Plot Animation
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
    
    % Plot
    position_m = [x_t(u) 0 0];
    plotcube(axes_ani,dimension_m,position_m,clr_m);
    
    % Plot spring
    spring_head = x_t(u) + dimension_m(1)/2;
    x_pos_spring = phi_s/phi_max*(spring_head - spring_foot) + spring_foot;
    plot3(axes_ani,x_pos_spring,y_pos_spring,z_pos_spring,'b','linewidth',lnwidth);
    
    % Plot Damper
    damper_head = x_t(u) + dimension_m(1)/2;
    plotdamper(stroke_length_max,damper_foot,damper_head,y_offset_d,clr_d,lnwidth);
    
    % Plot cos
    plotcos(x_ar,variable_cos,clr_cos,lnwidth,fntsz);
    
    % Rotate Views
    view(90,-90);
    
    title(title_ani,'fontsize',fntsz);
    xlabel(xlabel_ani,'fontsize',fntsz);
    
    drawnow
    
    u = u + 1;
end
