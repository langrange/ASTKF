% Function: fllowing the PSD in SILEX,get the Magnitude-Frequency plot
           % for filter design£¬then get the filter parameters for its 
           % design .
% @ Fpass : band-width start point (filter parameter)
% @ Ftop : band-width stop point (filter parameter)

clear all ,clc % empty the workspace

figure(1)
fix_figure   % Set up as standard EPS format
hold on

% SILEX psd 
x = 0:0.1:1200 ;
y = 20*log10((1./(1+x.^2)).^(1/2));
plot(x,y,'r','LineWidth',2) 
set(gca,'xscale','log')

% legend (if needed)
% str_Theta = {'$\rm\theta^2=0.02', '$\rm\theta^2=0.2','$\rm\theta^2=2'};
% h = legend(str_Theta,'EdgeColor',[1,1,1],'Interpreter','Latex');
% set(h,'Fontsize',size_legend);
xlabel('Frequency/HZ','FontSize',12);
ylabel('Magnitude/dB','FontSize',12);
% title('·ùÆµÌØÐÔÇúÏß','FontSize',15);
box off

y_3 = abs(y+3) ;  % get the -3dB point as the band-width start point 
Fpass = find(y_3 == min(y_3));  % find the  band-width start point
plot(x(Fpass),y(Fpass),'*','color','r','MarkerEdgeColor',[0 0 0],'LineWidth',2);
text(x(Fpass),y(Fpass),['(',num2str(x(Fpass)),',',num2str(y(Fpass)),')'],'color','b');

y_60 = abs(y+60) ; % get the -60dB point as the band-width stop point 
Fstop = find(y_60 == min(y_60)); % find the  band-width stop point
plot(x(Fstop),y(Fstop),'*','color','r','MarkerEdgeColor',[0 0 0],'LineWidth',2);
text(x(Fstop),y(Fstop),['(',num2str(x(Fstop)),',',num2str(y(Fstop)),')'],'color','b');
xlim([0.1 10000])
set(gca,'xtick',logspace(-1,4,6)) 

hold off

% END