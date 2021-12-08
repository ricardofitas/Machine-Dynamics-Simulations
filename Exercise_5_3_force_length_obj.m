function [cost,cost2] = Exercise_5_3_force_length_obj(length_force_0,omega,mass,damping_f,damping_r)
% Masses and inertias
if nargin < 3
    mass                      = 1000;                   % Mass of the body [kg]
end
inertia                   = 1000;                   % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f               = 60000;                  % Stiffness coefficient of spring [N/m]
stiffness_r               = 60000;                  % Stiffness coefficient of spring [N/m]

if nargin < 4
    damping_r                 = 1000;                   % Damping coefficient of damper [Ns/m]
    damping_f                 = 1000;                   % Damping coefficient of damper [Ns/m]
end
% Lengths center of gravity to front and rear end
length_f                  = 2.5;                    % Distance of the right spring-damper to the center of mass [m]
length_r                  = 1.5;                    % Distance of the left spring-damper to the center of mass [m]
length_force = length_force_0;

% Time and initial conditions
time = 0:0.05:10;                                   % Time [s]
x_0 = 0.0;                                          % Initial Condition displacement [m]
x_dot_0 = 0;                                        % Initial Condition velocity [m/s]
phi_0 = 0.0;                                        % Initial Condition angle [rad]
phi_dot_0 = 0; 
force                      = 2000;                % Force on the body [N]

%% 2.) Computing
%% 2.) -Numerical solution of the motion
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
        [eigenvector,lambda, ~] = polyeig(C,K,M);
        
        % set up constant matrices
        C_matr = [eigenvector(1,1) eigenvector(1,2) eigenvector(1,3) eigenvector(1,4);...
            eigenvector(2,1) eigenvector(2,2) eigenvector(2,3) eigenvector(2,4);...
            lambda(1)*eigenvector(1,1) lambda(2)*eigenvector(1,2) lambda(3)*eigenvector(1,3) lambda(4)*eigenvector(1,4);...
            lambda(1)*eigenvector(2,1) lambda(2)*eigenvector(2,2) lambda(3)*eigenvector(2,3) lambda(4)*eigenvector(2,4)];
        
        % Real excitation vector (splitted in sine and cosine vector)
        h_c = [force; length_force*force];
        h_s = [0;0];
        
        % calculate complex excitation vector
        h_star = 1/2*(h_c - 1i*h_s);
        
        % calculate complex frequency response matrix
        inv_freq_matrix_complex = C - omega^2*M + 1i*omega*K;    % inverse matrix
        F_star =inv(inv_freq_matrix_complex);                          % matrix inversion
        
        % Calculation of complex solution
        x_star = F_star * h_star;
        
        % create vector of initial conditions
        init_cond = [x_0-x_star(1)-conj(x_star(1)); phi_0-x_star(2)-conj(x_star(2));x_dot_0-1i*omega*x_star(1)+1i*omega*conj(x_star(1)); phi_dot_0-1i*omega*x_star(2)+1i*omega*conj(x_star(2))];
        
        % solve constant values equation system
        C_vec = C_matr\init_cond;
        
        % Calculate homogeneous solution
        x_t = C_vec(1)*exp(lambda(1)*time).*eigenvector(1,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(1,2) + C_vec(3)*exp(lambda(3)*time).*eigenvector(1,3) +...
            C_vec(4)*exp(lambda(4)*time).*eigenvector(1,4) + x_star(1)*exp(1i*omega*time)+conj(x_star(1))*exp(-1i*omega*time);
        phi_t = C_vec(1)*exp(lambda(1)*time).*eigenvector(2,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(2,2) + C_vec(3)*exp(lambda(3)*time).*eigenvector(2,3) +...
            C_vec(4)*exp(lambda(4)*time).*eigenvector(2,4)+ x_star(2)*exp(1i*omega*time)+conj(x_star(2))*exp(-1i*omega*time);
        
        % Rewrite homogeneous solution
        x_t = real(x_t);         % Car body displacement
        phi_t = real(phi_t);         % Car body rotation

% Define objective
cost = sum(abs(x_t)) + sum(abs(phi_t)); % Define the cost function. Here we will use the sum of the absolute value of the displacement plus the absolute value of phi without any weighing factors.

abs_motion_displacement = sum(abs(x_t));   % Calculate the total absolute displacement by sum up the absolute values of the displacement 
abs_motion_rotation = sum(abs(phi_t));     % Calculate the total absolute pitch by sum up the absolute values of the pitch motion

cost2 = abs_motion_displacement*0.4 + abs_motion_rotation*.6; % Give a weighing factor of 0.4 to the displacement and 0.6 to the pitch motion

end 