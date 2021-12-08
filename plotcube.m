function plotcube(axis,dimension,position,clr_c,angle)

%% Description
%
% Function plots a defined cube into the selected axis
%
%
%% Input
% axis ... axis where you want the plot to appear
% dimension ... length (x), width (y), height (x) of the cube
% position ... position of the centre of the cube
% clr_c ... color of the cube
%% Output
% Plot of a cube in a desired axis

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program

%% 1.) Definitions
if nargin < 5
    angle = 0;
end


%% 2.) Computing
x_c(1) = -dimension(1)/2;
x_c(2) = dimension(1)/2;
x_c(3) = dimension(1)/2;
x_c(4) = -dimension(1)/2;
x_c(5) = -dimension(1)/2;
x_c(6) = dimension(1)/2;
x_c(7) = dimension(1)/2;
x_c(8) = -dimension(1)/2;


y_c(1) = dimension(2)/2;
y_c(2) = dimension(2)/2;
y_c(3) = -dimension(2)/2;
y_c(4) = -dimension(2)/2;
y_c(5) = dimension(2)/2;
y_c(6) = dimension(2)/2;
y_c(7) = -dimension(2)/2;
y_c(8) = -dimension(2)/2;

z_c(1) = -dimension(3)/2;
z_c(2) = -dimension(3)/2;
z_c(3) = -dimension(3)/2;
z_c(4) = -dimension(3)/2;
z_c(5) = dimension(3)/2;
z_c(6) = dimension(3)/2;
z_c(7) = dimension(3)/2;
z_c(8) = dimension(3)/2;

vertices_c = [x_c' y_c' z_c'];
faces_c = [4 3 2 1; 2 3 7 6; 3 4 8 7;1 2 6 5;2 3 7 6;1 4 8 5];

%% 2.) Translate vertices
vertices_translated = [vertices_c(:,1) + position(1) vertices_c(:,2) + position(2) vertices_c(:,3) + position(3)];

%% 2.1) Rotate vertices
rotation_matrix = [cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1];
vertices_translated_rotated = rotation_matrix*vertices_translated';

%% 3.) Plot
patch(axis,'Vertices',vertices_translated_rotated','Faces',faces_c,'FaceColor',clr_c,'EdgeColor',clr_c);