% Function: compare the PSD between L_theta and SILEX
% @Disturb_LTheta disturb L_theta model 

clear all,clc % empty the workspace
close all

[f_Ltheta,psd_Ltheta,len] =get_Ltheta('Model/Disturb_LTheta'); % get the psd of L_theta

set(0,'defaultfigurecolor','w'); % set background to 'white' color
figure(1)
fix_figure %  Set up as standard EPS format
hold on

fs = 2500 ; % sample frequency
N=len ;
xx = ((1:N/2-1)*fs/N);
ff = (160./(1+xx.^2));    % psd of SILEX
plot(((1:N/2-1)*fs/N),20*log10(ff),'r','LineWidth',2)
plot(f_Ltheta,psd_Ltheta,'--') ;

set(gca,'Xscale','log')
axis([0.1 1.2*10^3 -150 50])
set(gca,'xtick',logspace(0,3,4))

% %label and title (if needed)
% xlabel('Frequence/HZ','FontSize',8);
% ylabel('Magnitude/dB','FontSize',8);
% title('PSD¶Ô±ÈÇúÏß','FontSize',12);

% legend 
T = ['L' '\theta']
le_h = legend(T,'SILEX')
set(le_h, 'Box', 'off')

hold off


