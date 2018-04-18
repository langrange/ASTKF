% Function : Experiment for the adaptiv and strong tracking Kalman filter
% @figure(1) : 状态扰动估计值，估计均值与真实值对比及误差
% @figure(2) : 状态扰动估均值与真实值比较及误差
% @figure(3) : 状态扰动估计方差 Q
% @figure(4) : 状态估计方差 P11
% @figure(5) : 状态估计方差 P22
% @figure(6) : 卡尔曼增益 Kf1
% @figure(7) : 卡尔曼增益 Kf2
% @figure(8) : 强跟踪渐消因子 λ
% @figure(9) : 状态估计误差 x1
% @figure(10) : 状态估计误差 x2
% @figure(10) : 输出估计 y
% @figure(10) : 测量噪声 N

% NOTICE ：set condition = 0
%%
clear all,clc  % empty workspace

global condition % set condition to 0 for fine result  
condition = 0 ;

cv_input = [0,0.1];
open('Model/ObserveKalmanRun.mdl')  % open the kalman model 
sim('ObserveKalmanRun') ; % begin to execute the simulink model
%% 设置figure背景为白色
set(0,'defaultfigurecolor','w'); 

%% 状态扰动估计值与真实值比较及误差
figure('NumberTitle','off','Name','状态扰动估计值与真实值比较及误差');
fix_figure     % 函数调用了fix_figure 对图片进行了标准eps格式处理  
plot(bijiao.Time,bijiao.Data(:,1),'-',bijiao.Time,bijiao.Data(:,2),'-.',...
    bijiao.Time,bijiao.Data(:,2)-bijiao.Data(:,1),'--','Linewidth',2)
box off

hlen = legend('状态扰动实际值','状态扰动估计值','估计值误差',...
    'Location','NorthWest','FontSize',7,'FontWeight','light');
set(hlen,'box','on','Location','NorthWest')
set(hlen,'box','off')

%% 状态扰动估均值与真实值比较及误差
figure('NumberTitle','off','Name','状态扰动估均值与真实值比较及误差');
fix_figure
plot(bijiao.Time,bijiao.Data(:,1),'-',bijiao.Time,bijiao.Data(:,3),'-.',...
    bijiao.Time,bijiao.Data(:,3)-bijiao.Data(:,1),'--','Linewidth',2)
box off

hlen = legend('状态扰动实际值','状态扰动估计均值','估计均值误差',...
    'Location','NorthWest','FontSize',7,'FontWeight','light');
set(hlen,'box','on','Location','NorthWest')
set(hlen,'box','off')

% %label (if needed)
% ylabel('状态扰动(\murad)','FontSize',9);
% xlabel('time/(s)','FontSize',9);

%% 状态扰动估计方差 Q
figure('NumberTitle','off','Name','状态扰动估计方差 Q');
fix_figure
plot(Q.Time,Q.Data,'k','Linewidth',2)
box off

% %title and label (if needed)
% title('状态扰动估计方差','FontSize',13);
% z=ylabel(['$$\widehat{Q}/(\mu rad^2$$' ')'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% 状态估计方差 P11
figure('NumberTitle','off','Name','状态估计方差 P11');
fix_figure
plot(P11.Time,P11.Data,'k')
set(gca,'xtick',[0:1:5])
axis([0 5 0 2])
box off

% % label (if needed)
% z=ylabel(['$$\widehat{P}(1,1)/(\mu rad^2$$' ')'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% 状态估计方差 P22
figure('NumberTitle','off','Name','状态估计方差 P22');
fix_figure
plot(P22.Time,P22.Data,'k')
set(gca,'xtick',[0:1:5])
axis([0 5 0 2])
box off

% % label (if needed)
% z=ylabel(['$$\widehat{P}(2,2)/(\mu rad^2$$' ')'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% 卡尔曼增益 Kf1
figure('NumberTitle','off','Name','卡尔曼增益 Kf1');
fix_figure
plot(k1.Time,k1.Data,'k')
box off

% % label (if needed)
% z=ylabel(['$$\widehat{K}_{f}(1)$$']);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
% set(gca,'xtick',[0:1:5])
% axis([0 5 0 2])


%% 卡尔曼增益 Kf2
figure('NumberTitle','off','Name','卡尔曼增益 Kf2');
fix_figure
plot(k2.Time,k2.Data,'k')
box off

% %label (if needed)
% z=ylabel(['$$\widehat{K}_{f}(2)$$']);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
% set(gca,'xtick',[0:1:5])
% axis([0 5 0 2])

%% 强跟踪渐消因子 lamda λ
figure('NumberTitle','off','Name','强跟踪渐消因子 λ');
fix_figure
plot(lamda.Time,lamda.Data,'k')
box off

% % label (if needed)
% z=ylabel(['$$\lambda$$'],'FontSize',10);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',9);

%% 状态估计 x1
figure('NumberTitle','off','Name','状态估计 x1');
fix_figure
plot(x11_cha.Time,x11_cha.Data,'k')
% z=ylabel(['$$\widetilde{\widehat{x}}(1)$$'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
set(gca,'xtick',[0:1:5])
axis([0 5 -2 2])
box off

%% 状态估计 x2
figure('NumberTitle','off','Name','状态估计 x2');
fix_figure
plot(x22_cha.Time,x22_cha.Data,'k')
% z=ylabel(['$$\widetilde{\widehat{x}}(2)$$'],'FontSize',13);
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);
set(gca,'xtick',[0:1:5])
axis([0 5 -2 2])
box off

%% 估计输出与实际输出对比
figure('NumberTitle','off','Name','估计输出与实际输出对比');
fix_figure
plot(yreal.Time,yreal.Data,'b-.',yout.Time,yout.Data,'r--','LineWidth',2)
hlen=legend('输出实际值','输出估计值')
axis([0 5 -502 502])
set(hlen,'box','on','Location','NorthEast')
set(hlen,'box','off')
grid off
box off

%% 输出估计误差
figure('NumberTitle','off','Name','输出估计误差');
fix_figure
plot(error.Time,error.Data,'k')
axis([0 5 -2.5 2.5])
grid on
box off

% %label (if needed)
% z=ylabel(['$$\widehat{y}/(\mu$$rad)'],'FontSize',13 );
% set(z,'Interpreter','latex');
% xlabel('time/(s)','FontSize',13);

%% 测量噪声 N
figure('NumberTitle','off','Name','测量噪声 N');
fix_figure
plot(noise.Time,noise.Data,'k')
box off

% % legend and label (if needed)
% legend('测量噪声 Ｎ')
% ylabel('N_{\theta}/rad')
% xlabel('time/(s)')

% save figure to file (if needed) 
% for h=1:12
%    saveas(h,['FigureFiles/figure',num2str(h),'.fig'])
% end