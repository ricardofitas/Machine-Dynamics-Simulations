
function [cost,abs_motion_displacement,abs_motion_rotation] = Exercise_4_4_parameter_fit_obj_local(damping_f,damping_r)
mass                      = 1000;                   % Mass of the body [kg]
inertia                   = 1000;                   % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f               = 60000;                  % Stiffness coefficient of spring [N/m]
%damping_f                 = damping_0;                   % Damping coefficient of damper [Ns/m]
stiffness_r               = 50000;                  % Stiffness coefficient of spring [N/m]
%damping_r                 = damping_0;                   % Damping coefficient of damper [Ns/m]

% Lengths center of gravity to front and rear end
length_f                  = 2.5;                    % Distance of the right spring-damper to the center of mass [m]
length_r                  = 3.5;                    % Distance of the left spring-damper to the center of mass [m]

% Time and initial conditions
time = 0:0.005:10;                                   % Time [s]
x_0 = 0.1;                                          % Initial Condition displacement [m]
x_dot_0 = 0;                                        % Initial Condition velocity [m/s]
phi_0 = 0.5;                                        % Initial Condition angle [rad]
phi_dot_0 = 0;                                      % Initial Condition angle velocity [rad/s]

    
%% 2.) Computing
%% 2.) Solving
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
        [eigenvector,lambda] = polyeig(C,K,M);
                             
        % set up constant matrices
        C_matr = [eigenvector(1,1) eigenvector(1,2) eigenvector(1,3) eigenvector(1,4);...
            eigenvector(2,1) eigenvector(2,2) eigenvector(2,3) eigenvector(2,4);...
            lambda(1)*eigenvector(1,1) lambda(2)*eigenvector(1,2) lambda(3)*eigenvector(1,3) lambda(4)*eigenvector(1,4);...
            lambda(1)*eigenvector(2,1) lambda(2)*eigenvector(2,2) lambda(3)*eigenvector(2,3) lambda(4)*eigenvector(2,4)];
        
        % create vector of initial conditions
        init_cond = [x_0; phi_0;x_dot_0; phi_dot_0];
        
        % solve constant values equation system
        C_vec = C_matr\init_cond;
        
        % Calculate homogeneous solution
        x_t = C_vec(1)*exp(lambda(1)*time).*eigenvector(1,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(1,2) + C_vec(3)*exp(lambda(3)*time).*eigenvector(1,3) +...
            C_vec(4)*exp(lambda(4)*time).*eigenvector(1,4);
        phi_t = C_vec(1)*exp(lambda(1)*time).*eigenvector(2,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(2,2) + C_vec(3)*exp(lambda(3)*time).*eigenvector(2,3) +...
            C_vec(4)*exp(lambda(4)*time).*eigenvector(2,4);
        
        % Rewrite homogeneous solution
        x_t = real(x_t);         % Car body displacement
        phi_t = real(phi_t);         % Car body rotation


% Define cost function suitable for local search. In general you could
% define every cost function you want and what ever suits your problem.
abs_motion_displacement = sum(abs(x_t));   % Calculate the total absolute displacement by sum up the absolute values of the displacement 
abs_motion_rotation = sum(abs(phi_t));     % Calculate the total absolute pitch by sum up the absolute values of the pitch motion

cost = abs_motion_displacement*0.4 + abs_motion_rotation*.6; % Give a weighing factor of 0.4 to the displacement and 0.6 to the pitch motion
end