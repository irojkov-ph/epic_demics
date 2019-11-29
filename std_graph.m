% Standardize the current figure and axes
% Graph constants used for all graphs

POSITION = [200 200 1000 550];
FONTSIZE   = 20;
MARKERSIZE = 14;
LINEWIDTH  = 1.5;
ERRORBARLINEWIDTH = 1.5;

ax = gca;

set(gcf, 'Position',  POSITION)

set(ax,'FontSize',FONTSIZE)

set(ax, 'TickLabelInterpreter', 'latex')

set(ax.Title,'Interpreter','latex')
set(ax.Legend, 'Interpreter', 'latex')
set(ax.XLabel,'Interpreter','latex')
set(ax.YLabel,'Interpreter','latex')
set(ax.Colorbar,'TickLabelInterpreter','latex')

set(ax,'Box','on')

if isprop(ax.Children,'LineWidth'), set(ax.Children,'LineWidth',LINEWIDTH); end
if isprop(ax.Children,'ErrorBarLineWidth'), set(ax.Children,'ErrorBarLineWidth',ERRORBARLINEWIDTH); end
