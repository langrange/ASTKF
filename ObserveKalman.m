%Discrete Kalman filter
%x=Ax+B(u+w(k));
%y=Cx+D+v(k)
function [out]=ObserveKalman(u1,u2,u3,u4)
%% 
%Function　：自适应强跟踪Kalman滤波算法
%输入 ：状态空间系统输入信号@u1,<u>
%     ：状态空间系统输出信号@u2,<yout>
%     ：时钟信号@u3,<clock model>
%     ：遗忘因子@u4，<c>
%输出 ：滤波后的输出@out(1),<yout>
%     ：状态扰动估计值@out(2),<s_e>
%     ：状态扰动估计均值@out(3),<q>
%     ：状态扰动估计方差@out(4),<Q>
%     ：状态估计方差1@out(5),<P(1,1)>
%     ：状态估计方差2@out(6),<P(2,2)>
%     ：卡尔曼滤波增益1@out(7),<Kf(1)>
%     ：卡尔曼滤波增益2@out(8),<Kf(2)>
%     ：状态估计1@out(9),<x(1)>
%     ：状态估计2@out(10),<x(2)>
%     ：强跟踪渐消因子@out(11),<lamda>
% Parameters：
% @A,B,C,D ：系统状态空间系数　% @Q ：状态扰动估计方差．．．
% @R ：测量噪声估计方差　% @P ：状态估计方差　% @x ：系统状态．．．
% @q ：状态扰动估计均值 %@r ： 测量噪声估计值 % @c_d ：自适应滤波遗忘因子...
% @lamda ：强跟踪渐消因子 %@ro ：强跟踪渐消因子 @lk ：强跟踪弱化因子

%%
persistent A B C D Q R P x q c_d r V count lamda  lamda_0
global condition

yv=u2; % 未进行滤波输出 （if needed）

%%
if u3==0
    
count = 1 ;
ts = 0.0004 ;  % 采样周期
z = tf('z') ;

oFsm = (1.034*z+0.1)/(z^2+0.1288*z+0.005117); % 离散传递函数
Gobject = tf(oFsm,ts);
ss_ob = ss(Gobject) ;

% A=ss_ob.a;B=ss_ob.b;C=ss_ob.c;D=ss_ob.d;
A=[0 1;-0.005117 -0.1288]; % 状态空间系数
B=[0;1];
C=[0.1 1.034];
D=0;

x=zeros(2,1); % 状态初始化

c_d = 0.6516; % Sage-Huga遗忘因子

q = 0; % 过程扰动均值初始化
Q= 2; % 过程扰动方差初始化
r = 0; % 测量噪声均值初始化
R = 6.115; % 测量噪声方差初始化

P=[0.1,0;0,0.1]; % 状态估计方差初始化

end

%condition = 0 ; % 是否调试遗忘因子

if (condition)
     c_d = u4 ;  %  tuning factor c is TRUE 
end

%% update Correction factor
rfactor_d = (1-c_d)/(1-power(c_d,count));

count = count +1 ;

% state prediction by step
x_1 = x ;
x_xing = A*x + B*u1 + B*q ;

%output error 
e = yv - C*x_xing - r ; % this x is the x*

%var of state prediciton
P_1 = P ;

%% 强跟踪部分
ro = 0.9; % 强跟踪遗忘因子
lk = 20;

if u3==0
    V = e*e';
else
    V = (ro*V+e*e')/(1+ro);
end

lamda_0=((V-C*B*Q*B'*C'-lk*R))/(C*A*P*A'*C');

%lamda_0=((V-lk*R))/(C*A*P*A'*C');

if(lamda_0>=1)
    lamda=lamda_0;
else
    lamda = 1;
end

% End 强跟踪部分结束 

%var of state prediciton
P = lamda*A*P_1*A'+ B*Q*B' ;
% end

%update Calman gain
K = P*C'/(C*P*C'+R);

%update State estimation
x=x_xing+K*e;

%var of state estimation
P_xing = P ;
P=(eye(2)-K*C)*P; % this P can be used as next P(k-1)
 
%output y estimation 
ye=C*x+D;           %Filtered value

%statue disturb 
s_e = (B'*B)\B'*( x - A*x_1 - B*u1) ;

% % %过程扰动均值更新
% q = (1-rfactor_d)*q + rfactor_d *((B'*B)\B'*( x - A*x_1 - B*u1)) ;
% % %过程扰动方差更新 
% Q = Q + rfactor_d*((B'*B)\B'*K*(e*e'-C*P_xing*C'-R)*K'*B/(B'*B));
% %Q = (1-rfactor_d)*Q + rfactor_d *((B'*B)\B'*(K*e*e'*K' + P - A*P_1*A')*B/(B'*B));

% 过程扰动均值更新
D_temp = B'*C'/(C*P_xing*C'+R);
q = q + rfactor_d*Q*D_temp*e;
Q = Q + rfactor_d*Q*D_temp*(e*e'-C*P_xing*C'-R)*D_temp'*Q ;


% out vector
out(1)=ye;  % yout
out(2)=s_e;  % real disturb
out(3)=q;  % mean of disturb
out(4)=Q;  % var of disturb
out(5)=P(1,1); % 状态方差 1 
out(6)=P(2,2); % 状态方差 2 
out(7)=K(1); % 卡尔曼滤波系数1 
out(8)=K(2); % 卡尔曼滤波系数2
out(9)=x(1);  %状态估计1
out(10)=x(2); % 状态估计2
out(11)=lamda ; %强跟踪渐消因子



