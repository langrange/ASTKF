% 建立了被控对象FSM的连续传递函数，
% 然后将其离散化，进一步得到状态空间表示
%% 
clear all,clc
omigan = 9420 ;  % FSM的谐振频率
yita = 0.7 ;  % FSM的阻尼比

% FSM连续传递函数
num = [omigan^2];
den = [1 2*omigan*yita omigan^2];
display('连续传递函数是：')
csys = tf(num,den)

% FSM离散传递函数
ts = 0.0004 
display('离散传递函数是：')
dsys = c2d(csys,ts,'zoh')

% FSM状态空间表示
numz = dsys.num{1};
denz= dsys.den{1};
display('状态空间系数是：')
A = [0 1;-denz(3) -denz(2)]
B = [0;1]
C = [numz(3) numz(2)]
D = 0

