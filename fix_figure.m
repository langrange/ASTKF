function fix_figure 
%%
% FUNCTION: set up the figure to standared EPS format
% Input: None
% Return :None 

% eps 标准格式
% set(gcf,'Position',[100 100 260 220]); %标准
% set(gca,'Position',[.13 .17 .80 .74]);  %调整 XLABLE和YLABLE不会被切掉

% set up for the Visio 
% Notice: this does not match the standard EPS format here,actually
set(0,'defaultfigurecolor','w');
set(gcf,'Position',[100 100 300 200]);
set(gca,'Position',[.12 .17 .85 .74]); 
% set(gca,'Position',[0 0 1 1]);
figure_FontSize=9;
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'FontWeight','b','Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'FontWeight','b','Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

end