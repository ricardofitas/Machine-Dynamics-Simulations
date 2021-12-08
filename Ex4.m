%% Description

% This is a script to analyse the eigenfrequencies of a two degree of
% freedom system

%% Output

% Frequency response plot of a two degree of freedom system.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 14/11/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 14/11/2021 | Ricardo Fitas | creation

%% Program
clear       % Delete Workspace
clc         % Clear Command Window
close all   % Close all figures

%% 1) Definitions
%% 1.1) Parameter definition

% Masses and inertias
mass            = 1000;              % Mass of the body [kg]
inertia         = 1000;              % Inertia of the body [kg*m^2]

% Stiffness and damping values
stiffness_f     = 60000;             % Stiffness coefficient of spring [N/m]
damping_f       = 0;                 % Damping coefficient of damper [Ns/m]
stiffness_r     = 60000;             % Stiffness coefficient of spring [N/m]
damping_r       = 0;                 % Damping coefficient of damper [Ns/m]

% Lengths center of gravity to front and rear end
length_f        = 2.5;               % Distance of the right spring-damper to the center of mass [m]
length_r        = 2.5;               % Distance of the left spring-damper to the center of mass [m]

% Time and initial conditions
Fs = 100;                            % Sampling rate
time = 0:1/Fs:10;                    % Time
x_0 = 0.1;                           % Initial Condition displacement [m]
x_dot_0 = 0;                         % Initial Condition velocity [m/s]
phi_0 = 0;                           % Initial Condition angle [rad]
phi_dot_0 = 0;                       % Initial Condition angle velocity [rad/s]


%% 2) Computing
%% 2.1) Solving
% Set up system matrices

M = [mass 0 ; 0 inertia]; % Mass matrix

% Damping matrix
K = [damping_r+damping_f, length_f*damping_f-length_r*damping_r;...
    length_f*damping_f-length_r*damping_r, length_r^2*damping_r+length_f^2*damping_f];

% Stiffness matrix
C = [stiffness_r+stiffness_f, length_f*stiffness_f-length_r*stiffness_r;...
    length_f*stiffness_f-length_r*stiffness_r, length_r^2*stiffness_r+length_f^2*stiffness_f];

%% Calculate analytical homogeneous solution

% solve eigenvalue problem for system
[eigenvector, lambda, cond] = polyeig(C,K,M);

% set up constant matrices
C_matr = [eigenvector(1:2,1:4); lambda'.*eigenvector(1,:);  lambda'.*eigenvector(2,:)];

% create vector of initial conditions
init_cond = [x_0; phi_0; x_dot_0; phi_dot_0];

% solve constant values equation system
C_vec = C_matr\init_cond;

% Calculate homogeneous solution
x_t = C_vec(1)*exp(lambda(1)*time).*eigenvector(1,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(1,2) + C_vec(3)*exp(lambda(3)*time).*eigenvector(1,3) + C_vec(4)*exp(lambda(4)*time).*eigenvector(1,4);
phi_t = C_vec(1)*exp(lambda(1)*time).*eigenvector(2,1) + C_vec(2)*exp(lambda(2)*time).*eigenvector(2,2) + C_vec(3)*exp(lambda(3)*time).*eigenvector(2,3) + C_vec(4)*exp(lambda(4)*time).*eigenvector(2,4);

% rewrite homogeneous solution
x_t = real(x_t);                % Car body displacement
phi_t = real(phi_t);            % Car body rotation


%% 2.2) Analysis of the time plots using FFT
u = log2(length(x_t));
N = 2^ceil(u);
N = length(x_t);

freq = 0:Fs/N:Fs/2;

tic
Y_new = fft(x_t,N);
FFT_clocker = toc;

tic
Y = fft(x_t);
DFT_clocker = toc;

Y_half = Y(1:floor(N/2)+1);
Y_half = Y_half/N;

amp = abs(Y_half);
amp(2:end) = 2*amp(2:end);

%% 3) Plot

x_lab = '[Hz]';
y_lab = '[m]';

figure
plot(freq,amp);
xlabel(x_lab);
ylabel(y_lab);

eigenfrequencies = abs(lambda)/2/pi;
display(eigenfrequencies)