% funciton: PID and ASTKF＋PID 对比试验中的PID

clear all,clc
close all

global OnlyPid;  % choose whether using Kalman+Pid or just use pid method
OnlyPid = 1 ;
%load('InputSignal/error_input.mat') % load inputSignal<error of CoarseTracking>
load('InputSignal/error_coarse.mat')
open('Model/Pid.mdl')  % open the  model

sim('Pid') ; % begin to execute the simulink model

%% 设置figure背景为白色
set(0,'defaultfigurecolor','w'); 

%% 输出与输入
figure('NumberTitle','off','Name','输出与输入');
fix_figure % Set up as standard EPS format
plot(yComp.Time,yComp.Data)
h = legend('\Delta\theta_{C}','\theta_{F}');
set(h,'box','off')
ylabel('\theta/rad','FontSize',12)
xlabel('time/(s)','FontSize',13)
grid off
box off
hold off

%% 精跟踪误差
figure('NumberTitle','off','Name','精跟踪误差');
fix_figure % Set up as standard EPS format
plot(error.Time(1:end),error.Data(1:end))
%legend('\Delta\theta_{C}','\theta_{F}')
%ylabel('\Delta\theta_{F}/rad','FontSize',12)
%xlabel('time/(s)','FontSize',13)
grid on
box off
hold off
%ylim([-3,6])

%% 精跟踪误差
figure('NumberTitle','off','Name','进入精跟踪误差');
fix_figure % Set up as standard EPS format
plot(error.Time(1990:end),error.Data(1990:end))
%legend('\Delta\theta_{C}','\theta_{F}')
ylabel('\Delta\theta_{F}/rad','FontSize',12)
xlabel('time/(s)','FontSize',13)
grid on
box off
hold off
axis([0.7956 10 -15 15])

sorted = sort(abs(error.Data(1990:end)),'descend') ;
display(['最大误差:' num2str(sorted(2))]);
display(['99.9%误差范围:' num2str(max(sorted(23:end)))]);
display(['方差:' num2str(var(error.Data(1990:end)))]);
