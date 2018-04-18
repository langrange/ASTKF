% function: plot the coarse tracking signal and 
% find the point coming fine tracking 

% clear all,clc % empty the workspace

load('InputSignal/error_coarse.mat') ;% load inputSignal<error of CoarseTracking>

figure('NumberTitle','off','Name','´Ö¸ú×ÙÎó²î');
fix_figure % Set up as standard EPS format
hold on
plot(error_coarse.Time,error_coarse.Data(:),'k')
p = find( error_coarse.Data(:)-500 == min(abs(error_coarse.Data(:)-500)));
plot(error_coarse.Time(p),error_coarse.Data(p),'*','color','r','MarkerEdgeColor',...
    [0 0 0],'LineWidth',2);
    % draw the minnum point
text(error_coarse.Time(p),error_coarse.Data(p),['(',num2str(error_coarse.Time(p)),',',num2str(error_coarse.Data(p)),')']...
    ,'color','b');
% ha = quiver(error_coarse.Time(p)+1,error_coarse.Data(p),1,50,'LineWidth',2)
% set(ha,'maxheadsize',40);
% legend('\Delta\theta_{C}','\theta_{F}')
% ylabel('\theta/rad','FontSize',12)
% xlabel('time/(s)','FontSize',13)
grid off
box off
%hold off