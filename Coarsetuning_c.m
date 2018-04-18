% function: fine tune the forgetting factor 'c' in adaptive filter
% @ ObserveKalmanTest : Kalman Simulink Model
% @ c:  forgetting factor in adaptive filter 
% @ cv_input: Vecotr of c as the input parameter in Kalman Simulink Model
% NOTICE：set grobal condition==1

clear all ,clc   % empty workspace

global condition
condition = 1;

open('Model/ObserveKalmanTune.mdl')  % open the kalman model 
set(0,'defaultfigurecolor','w');  % set the background 
                                  %  of figure to white 
Max_youterror = []; % Vector for Maximum output error 
c_vector =[]; % Vector for c

% c in [0.1,0.99]
for i = 0.1:0.05:0.99

    c_v = i ;
    c_vector = [c_vector c_v] ;
    time = 0:0.0004:5 ;
    data = ones(size(time))*c_v ;
    
    % prepare cv_input to a standard format for simulink input
    cv_input.time = time' ;
    cv_input.signals.values = data' ;
    cv_input.signals.dimensions = 1 ;
    
    sim('ObserveKalmanTune') ;
    orderValue = sort(abs(error.Data(1:end)),'descend');
    MaxValue = sum(orderValue(1:1))/1;
    %plot(c_v,MaxValue,'r*')
    Max_youterror = [Max_youterror MaxValue];    
end

figure(1)
fix_figure % Set up as standard EPS format
hold on
plot(c_vector,Max_youterror,'b-')

%% legend and label (if needed)
% title('遗忘因子粗调曲线','FontSize',12);
% z=ylabel(['$$\left|\widetilde{\widehat{y}}\right|_{max}(\mu$$rad)'],'FontSize',18   );
% set(z,'Interpreter','latex');
% xlabel('遗忘因子c','FontSize',13);

hold off