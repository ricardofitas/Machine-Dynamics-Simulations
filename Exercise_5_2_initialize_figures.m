%% Description

% This is a script to initialize the figures for an animation and a graph.

%% Output

% Formated figure which can be used for an animation.

%% Version

% author: Ricardo Fitas (rfitas99@gmail.com, RWTH Aachen University)
% creation date: 30/10/2021
% Matlab version: R2020b

%% Revision

% V1.0 | 30/10/2021 | Ricardo Fitas | creation

%% Program
%
%% 1.) Definitions
clr = [236/255 237/255 237/255];
unts = 'normalized';
lnwidth = 2;
fntsz = 18;

%% 1.1.) Positions, titles and labels
pos_fig = [0.01 0.25 .75 .65];
title_graph = 'Displacement and angle vs time';
title_ani = 'Damped homogeneous two d.o.f. system';
xlabel_ani = 'Displacement x [m]';
xlabel_graph = 'Time t [s]';
ylabel_graph{1} = 'Displacement x [m]';
ylabel_graph{2} = 'Angle \phi [º]';

%% 2.) Plot
%% 2.1.) Initialise Figures
fig = figure('color',clr,'units',unts,'position',pos_fig);
subplot(1,2,2)
graph_plot = plot(1,1,1,1);
set(graph_plot(1),'color','k','linewidth',lnwidth);
set(graph_plot(2),'color','r','linewidth',lnwidth);
axes_graph(1) = gca;
set(axes_graph(1),'FontSize',fntsz);
axes_graph(2) = axes('Position',axes_graph(1).Position,'YAxisLocation','right','YColor','r','Color','none','XTickLabel',[],'fontsize',fntsz);
xlabel(axes_graph(1),xlabel_graph,'fontsize',fntsz);
ylabel(axes_graph(1),ylabel_graph(1),'fontsize',fntsz);
ylabel(axes_graph(2),ylabel_graph(2),'fontsize',fntsz);
title(title_graph,'fontsize',fntsz);

set(axes_graph(1),'Ydir','reverse');
set(axes_graph(2),'Ydir','reverse');

x_t_max_limit = max(abs(x_t)) + 0.05*max(abs(x_t));
ylim(axes_graph(1),[-x_t_max_limit,x_t_max_limit]);

v_t_max_limit = max(abs(phi_t_plot)) + 0.05*max(abs(phi_t_plot));
ylim(axes_graph(2),[-v_t_max_limit,v_t_max_limit]);

xlim(axes_graph(1),[time(1) time(end)]);
xlim(axes_graph(2),[time(1) time(end)]);

subplot(1,2,1)
axes_ani = gca;
set(axes_ani,'FontSize',fntsz);
set(axes_ani,'Color',clr);
set(axes_ani,'Xdir','reverse');
xlim([-3*x_t_max_limit,4*x_t_max_limit]);
ylim([-4,4]);

title(title_ani,'Fontsize',fntsz);
xlabel(xlabel_ani,'Fontsize',fntsz);