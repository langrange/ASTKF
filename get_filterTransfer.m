% function: convert SOS format to [num;den]and K
clear all,clc % empty the workspace

load('Filter/filterOutPams.mat') % load filter output parameters
[numz,denz]=sos2tf(SOS);   % convert SOS format to transfer
K=cumprod(G); 
k=K(end); % 放大系数

% 离散传递函数 
dsys = tf(numz*k,denz,0.0004); % 滤波器传递函数,采样周期0.004s
display('Filter discrete transfer funtion is :')
display(dsys)

% 离散转化为连续传递函数 (if needed)
%scsys = d2c( dsys,'tustin' ); % 采用双线性变换转换为连续函数
%[num,den] = tfdata( scsys,'v' );% 获得s传函的分子和分母
% %bode(tf(num,den)) % 滤波器的bode图