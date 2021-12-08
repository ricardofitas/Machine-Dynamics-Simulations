function plotdamper(stroke_length_max,damper_foot,damper_head,y_offset_d,clr_d,lnwidth)

%% Description
%
% Function plots a defined damper into the selected axis
%
%
%% Input
% axis ... axis where you want the plot to appear
% dimension ... length (x), width (y), height (x) of the cube
% position ... position of the centre of the cube
% clr_d ... color of the damper
%% Output
% Plot of a damper in a desired axis

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program
%% 1.) Definitions
% No definitions needed

%% 2.) Computing 
%% 2.1.) Calculate vertices and faces
x_d(1) = damper_foot;
x_d(2) = damper_foot - stroke_length_max*0.02;
x_d(3) = damper_foot - stroke_length_max*0.02;
x_d(4) = damper_foot - stroke_length_max*0.02;
x_d(5) = damper_foot - stroke_length_max*0.9;
x_d(6) = damper_foot - stroke_length_max*0.9;
x_d(7) = damper_head + stroke_length_max*0.1;
x_d(8) = damper_head + stroke_length_max*0.1;
x_d(9) = damper_head + stroke_length_max*0.1;
x_d(10) = damper_head;

y_d(1) = y_offset_d;
y_d(2) = 0.1 + y_offset_d;
y_d(3) = -0.1 + y_offset_d;
y_d(4) = y_offset_d;
y_d(5) = -0.1 + y_offset_d;
y_d(6) = 0.1 + y_offset_d;
y_d(7) = -0.09 + y_offset_d;
y_d(8) = 0.09 + y_offset_d;
y_d(9) = y_offset_d;
y_d(10) = y_offset_d;

z_d(1) = 0.1;
z_d(2) = 0.1;
z_d(3) = 0.1;
z_d(4) = 0.1;
z_d(5) = 0.1;
z_d(6) = 0.1;
z_d(7) = 0.1;
z_d(8) = 0.1;
z_d(9) = 0.1;
z_d(10) = 0.1;

vertices_d =[x_d' y_d' z_d'];

x_d(1) = damper_foot;
x_d(2) = damper_foot - stroke_length_max*0.02;
x_d(3) = damper_foot - stroke_length_max*0.02;
x_d(4) = damper_foot - stroke_length_max*0.02;
x_d(5) = damper_foot - stroke_length_max*0.9;
x_d(6) = damper_foot - stroke_length_max*0.9;
x_d(7) = damper_head + stroke_length_max*0.1;
x_d(8) = damper_head + stroke_length_max*0.1;
x_d(9) = damper_head + stroke_length_max*0.1;
x_d(10) = damper_head;

y_d(1) = y_offset_d;
y_d(2) = 0.1 + y_offset_d;
y_d(3) = -0.1 + y_offset_d;
y_d(4) = y_offset_d;
y_d(5) = -0.1 + y_offset_d;
y_d(6) = 0.1 + y_offset_d;
y_d(7) = -0.09 + y_offset_d;
y_d(8) = 0.09 + y_offset_d;
y_d(9) = y_offset_d;
y_d(10) = y_offset_d;

z_d(1) = -0.1;
z_d(2) = -0.1;
z_d(3) = -0.1;
z_d(4) = -0.1;
z_d(5) = -0.1;
z_d(6) = -0.1;
z_d(7) = -0.1;
z_d(8) = -0.1;
z_d(9) = -0.1;
z_d(10) = -0.1;

vertices_d =[vertices_d; x_d' y_d' z_d'];

faces = [ 1 4 14 11;2 3 13 12; 3 5 15 13; 2 6 16 12; 7 8 18 17; 9 10 20 19];

%% 3.) Plot
patch('Vertices',vertices_d,'Faces',faces,'FaceColor',clr_d,'EdgeColor',clr_d,'linewidth',lnwidth);

end