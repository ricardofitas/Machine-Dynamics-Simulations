function plotcos(x_ar,angle_cos2,variable_cos,variable_cos2,clr_cos,clr_cos2,lnwidth,fntsz,y_offset_cos)

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
if nargin < 9
    y_offset_cos = 1.5;
end
x_cos(1) = 0;
x_cos(2) = 0;
x_cos(3) = 0;
x_cos(4) = 0.6*x_ar;
x_cos(5) = 0.6*x_ar;
x_cos(6) = 1*x_ar;

y_cos(1) = -4*x_ar + y_offset_cos;
y_cos(2) = 4*x_ar + y_offset_cos;
y_cos(3) = y_offset_cos;
y_cos(4) = -4*x_ar + y_offset_cos;
y_cos(5) = 4*x_ar + y_offset_cos;
y_cos(6) = y_offset_cos;

z_cos(1) = 0.1;
z_cos(2) = 0.1;
z_cos(3) = 0.1;
z_cos(4) = 0.1;
z_cos(5) = 0.1;
z_cos(6) = 0.1;

vertices_cos = [x_cos' y_cos' z_cos'];
x_cos(1) = 0;
x_cos(2) = 0;
x_cos(3) = 0;
x_cos(4) = 0.6*x_ar;
x_cos(5) = 0.6*x_ar;
x_cos(6) = 1*x_ar;

y_cos(1) = -4*x_ar + y_offset_cos;
y_cos(2) = 4*x_ar + y_offset_cos;
y_cos(3) = y_offset_cos;
y_cos(4) = -4*x_ar + y_offset_cos;
y_cos(5) = 4*x_ar + y_offset_cos;
y_cos(6) = y_offset_cos;

z_cos(1) = -0.1;
z_cos(2) = -0.1;
z_cos(3) = -0.1;
z_cos(4) = -0.1;
z_cos(5) = -0.1;
z_cos(6) = -0.1;

vertices_cos = [vertices_cos; x_cos' y_cos' z_cos'];

faces_cos = [1 2 8 7; 3 6 12 9; 4 6 12 10; 5 6 12 11];

x_cos2_start = 0;
radius_x = x_cos(6)*0.6;
radius_y = (y_cos(2) - y_cos(1))/2;

x_cos2 = x_cos2_start + sin(angle_cos2) * radius_x;
y_cos2 = cos(angle_cos2)*radius_y + y_offset_cos;

x_cos2_end = 0;
y_cos2_end = y_cos(1);


%% Plot
patch('Vertices',vertices_cos,'Faces',faces_cos,'FaceColor',clr_cos,'EdgeColor',clr_cos,'linewidth',lnwidth);

text(x_cos(4),y_cos(2),variable_cos,'Color',clr_cos,'FontSize',fntsz);

plot(x_cos2,y_cos2,clr_cos2,'linewidth',lnwidth);
arrow([x_cos2(end) y_cos2(end)],[x_cos2_end y_cos2_end],'EdgeColor',clr_cos2,'FaceColor',clr_cos2);
text(x_cos2(1),y_cos2(1),variable_cos2,'Color',clr_cos2,'FontSize',fntsz);


end