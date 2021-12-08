%% Description

% This is a script to solve equation of motion - force excited - with
% different approaches

%% Output

% Frequency response plot of a two degrees-of-freedom system.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 06/12/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 14/11/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures

%% 1.) Definitions
%% 1.) -Parameter definition
% Masses and inertias
mass                      = 1000;                   % Mass of the body [kg]
inertia                   = 1000;                   % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f               = 60000;                  % Stiffness coefficient of spring [N/m]
damping_f                 = 100;                   % Damping coefficient of damper [Ns/m]
stiffness_r               = 60000;                  % Stiffness coefficient of spring [N/m]
damping_r                 = 100;                   % Damping coefficient of damper [Ns/m]

% Lengths center of gravity to front and rear end
length_f                  = 2.5;                    % Distance of the right spring-damper to the center of mass [m]
length_r                  = 2.5;                    % Distance of the left spring-damper to the center of mass [m]
force                     = 2000;                                  % Constant force value [N]
length_force              = 1.6;            % Distance point of force attack to center of gravity
omega                     = 10;                % Angular frequency of the excitation [1/s]

% Time and initial conditions
time = 0:0.005:20;                                   % Time [s]
x_0 = 0.1;                                         % Initial Condition displacement [m]
x_dot_0 = 0;                                        % Initial Condition velocity [m/s]
phi_0 = 0.0;                                        % Initial Condition angle [rad]
phi_dot_0 = 0;                                      % Initial Condition angle velocity [rad/s]
    
%% 2.) Computing
%% 2.) Solving
switch force_sw
    case 0
        f = [0,0];
    case 1
        f = [force*cos(omega*t), length_force*cos(omega*t)];
end
switch solver
    case 'dsolve'
        % define symbolic variables
        syms x(t) phi(t)                            % Define dependent variables
        Dx = diff(x,1);                             % Define first derivation of x
        D2x = diff(x,2);                            % Define second derivation of x
        Dphi = diff(phi,1);                         % Define first derivation of phi
        D2phi = diff(phi,2);                        % Define second derivation of phi
        
        % Solve equation
        [phi, x] = dsolve([mass*D2x + (damping_r + damping_f)*Dx + (damping_f*length_f-damping_r*length_r)*Dphi +...
            (stiffness_r*stiffness_f)*x + (stiffness_f*length_f-stiffness_r*length_r)*phi == f(1),...
            inertia*D2phi + (damping_f*length_f-damping_r*length_r)*Dx + (damping_f*length_f^2+damping_r*length_r^2)*Dphi +...
            (-stiffness_r*length_r + stiffness_f*length_f)*x + (stiffness_f*length_f^2+stiffness_r*length_r^2)*phi == f(2)],...
            [x(0) == x_0, Dx(0) == x_dot_0, phi(0) == phi_0, Dphi(0) == phi_dot_0],'t');
          
        
        x_fun = matlabFunction(x);                  % Create function handle for x
        x_dot_fun = matlabFunction(diff(x));        % Create function handle for x_dot
        x_t = feval(x_fun,time);                    % Evaluate function at points "time"
        v_t = feval(x_dot_fun,time);                % Evaluate function at points "time"
        
        phi_fun = matlabFunction(phi);                % Create function handle for phi
        phi_dot_fun = matlabFunction(diff(phi));      % Create function handle for phi_dot
        phi_t = feval(phi_fun,time);                  % Evaluate function at points "time"
        phi_t_deg = phi_t*180/pi;                     % Values of phi in degree
        phi_dot_t = feval(phi_dot_fun,time);          % Evaluate function at points "time"
        
    case 'ode'
        w0 = [x_0, phi_0, x_dot_0, phi_dot_0];
        
        [tsim, wsim] = ode45(@state_space_equation,time, w0,'options',mass, inertia, stiffness_f,stiffness_r,damping_f, damping_r,length_f, length_r, length_force, force, omega); 
        
        %Rename solutions
        time = tsim';
        x_t = wsim(:,1)';
        phi_t = wsim(:,2)';
        v_t = wsim(:,3)';
        phi_dot_t = wsim(:,4)';
        
    case 'analytical'
        
        % Set up system matrices
        M = [mass 0 ; 0 inertia]; % Mass matrix

        % Damping matrix
        K = [damping_r+damping_f, length_f*damping_f-length_r*damping_r;...
            length_f*damping_f-length_r*damping_r, length_r^2*damping_r+length_f^2*damping_f];

        % Stiffness matrix
        C = [stiffness_r+stiffness_f, length_f*stiffness_f-length_r*stiffness_r;...
            length_f*stiffness_f-length_r*stiffness_r, length_r^2*stiffness_r+length_f^2*stiffness_f];

        %% Calculate analytical homogenous solution
        % solve eigenvalue problem for system
        [eigenvector,lambda, cond] = polyeig(C,K,M);

        % set up constant matrices
        C_matr = [eigenvector(1,1) eigenvector(1,2) eigenvector(1,3) eigenvector(1,4);...
            eigenvector(2,1) eigenvector(2,2) eigenvector(2,3) eigenvector(2,4);...
            lambda(1)*eigenvector(1,1) lambda(2)*eigenvector(1,2) lambda(3)*eigenvector(1,3) lambda(4)*eigenvector(1,4);...
            lambda(1)*eigenvector(2,1) lambda(2)*eigenvector(2,2) lambda(3)*eigenvector(2,3) lambda(4)*eigenvector(2,4)];

        % Real excitation vector (splitted in sine and cosine vector)
        h_c = [force; length_force*force];  % Define the cosine part of the excitation
        h_s = [0;0];  % Define the sine part of the excitation

        % calculate complex excitation vector
        h_star = 1/2*(h_c - 1i*h_s);

        % calculate complex frequency response matrix
        inv_freq_matrix_complex = C - omega^2*M + 1i*omega*K;    % inverse matrix
        F_star = inv(inv_freq_matrix_complex);                          % matrix inversion

        % Calculation of complex solution
        x_star = F_star*h_star;

        % create vector of initial conditions
        init_cond = [x_0-x_star(1) - conj(x_star(1)); phi_0 - x_star(2) - conj(x_star(2)); x_dot_0 - 1i*omega*x_star(1) + 1i*omega*conj(x_star(1)); phi_dot_0 - 1i*omega*x_star(2) + 1i*omega*conj(x_star(2))];


        % solve constant values equation system
        C_vec = C_matr\init_cond;

        % Calculate homogeneous solution
        x_t_h = C_vec(1)*exp(lambda(1)*time).*eigenvector(1,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(1,2) +C_vec(3)*exp(lambda(3)*time).*eigenvector(1,3) + C_vec(4)*exp(lambda(4)*time).*eigenvector(1,4);
        phi_t_h = C_vec(1)*exp(lambda(1)*time).*eigenvector(2,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(2,2) +C_vec(3)*exp(lambda(3)*time).*eigenvector(2,3) + C_vec(4)*exp(lambda(4)*time).*eigenvector(2,4);

        % Calculate particular solution
        x_t_p = x_star(1)*exp(1i*omega*time) + conj(x_star(1))*exp(-1i*omega*time);
        phi_t_p = x_star(2)*exp(1i*omega*time) + conj(x_star(2))*exp(-1i*omega*time);

        % Calculate overall solution
        x_t = real(x_t_h + x_t_p);             % Car body displacement
        phi_t = real(phi_t_h + phi_t_p);         % Car body rotation

        figure('WindowStyle','docked');          % Define the figure
        plot(time,real(x_t_h),time,x_t_p,time,x_t)
        legend('homogeneous','particular','overall');   % Plot a legen which says 'homogeneous','particular','overall' and put the legend outside the figure to the northeast
        axis('square')                           % Axis lines with equal length

        figure('WindowStyle','docked');          % Define the figure
        plot(time,real(phi_t_h),time,phi_t_p,time,phi_t)
        legend('homogeneous','particular','overall'); % Plot a legen which says 'homogeneous','particular','overall' and put the legend outside the figure to the northeast
        axis('square')                           % Axis lines with equal length

        % State the solution which you need if you want to analyse the motion only
        % for a long period of time
        x_t_long = real(x_t_p);             
        phi_t_long = real(phi_t_p);         
end
