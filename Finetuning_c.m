
% function: fine tune the forgetting factor 'c' in adaptive filter
% @ ObserveKalmanTest : Kalman Simulink Model
% @ c: forgetting factor in adaptive filter 
% @ cv_input: Vecotr of c as the input parameter in Kalman Simulink Model


clear all ,clc   % empty workspace

global condition % set condition = 1 for tune 'c'
condition = 1;

open('Model/ObserveKalmanTune.mdl')  % open the kalman model 
set(0,'defaultfigurecolor','w');  % set the background 
                                  %  of figure to white 
 
Line = {} ; % allocate a Cell room for fine_c curve

accuracy = 1e-4 ; % Convergence precision /收敛精度
c_v_begin = 0.6 ; % the Start point of fintuing_c domain
c_v_end = 0.7;  % the End point of fintuing_c domain
c_v_step = (c_v_end - c_v_begin)/10 ; % step

while(1)       
    
    Max_youterror = []; % Vector for Maximum output error 
    c_vector =[]; % Vector for c
    
    % this loop is every c_v_begin-->c_v_end
    for c_v = c_v_begin:c_v_step:c_v_end     
        
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
        Max_youterror = [Max_youterror MaxValue];    
        
    end
    
    line_sub = {} ; % Every fine tuning curve
    line_sub.x = c_vector ; 
    line_sub.y = Max_youterror ;
    Line = [Line line_sub] ; % add every fine tuning data to fine tuning Cell
    
    p = find(Max_youterror == min(Max_youterror)); % Return the index at the minnum
                                                   % point in Max_youterror
    if(1==p)
      c_v_begin = c_vector(p)
    else
      c_v_begin = c_vector(p-1) ; % as the Start point of next fine tuning loop
    end
    
    c_v_end = c_vector(p+1); % as the End point of next fine tuning loop
    c_v_step = (c_v_end - c_v_begin)/10 ; % the step of nexe fine tuning loop 
    
   if abs(Max_youterror(p)-Max_youterror(p+1))<=accuracy||1==p...
            ||abs(Max_youterror(p)-Max_youterror(p-1))<=accuracy
       
            % if the accuracy reach the Convergence precision,then stop
        
        % @ pointmin ： the min point 
        pointmin = {}
        pointmin.x = c_vector(p) ;
        pointmin.y = Max_youterror(p) ;
       
       break 
   end
   
           
end

% %legend and label (if need)
%legend('gca','MinPoint')
% title('遗忘因子粗调曲线','FontSize',12);
% z=ylabel(['$$\left|\widetilde{\widehat{y}}\right|_{max}(\mu$$rad)'],'FontSize',18);
% set(z,'Interpreter','latex');
% xlabel('遗忘因子c','FontSize',13);

%%
figure(1)
fix_figure % Set up as standard EPS format
hold on

y = [];
x = [];
for i=1:length(Line)
    x = [x Line{i}.x];
    y = [y Line{i}.y];
end

[x,index_x] = sort(x) ; % reording the fine tuning curve
y = y(index_x) ;

plot(x,y,'^r-','LineWidth',2);
plot(pointmin.x,pointmin.y,'*','color','r','MarkerEdgeColor',...
    [0 0 0],'LineWidth',2);
    % draw the minnum point
text(pointmin.x,pointmin.y,['(',num2str(pointmin.x),',',num2str(pointmin.y),')']...
    ,'color','b');

hold off

