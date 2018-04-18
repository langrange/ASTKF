%% BEGIN：

% 这个文件每个.m文件的功能以及操作
% InitConfig.m ：声明了两个全局条件，用于切换调节遗忘因子和最优遗忘因子仿真
                 %以及切换 PID 和 ASTKF＋PID                               
% Coarsetuning_c.m ：粗调遗忘因子
% Finetuning_c.m：精调遗忘因子
% fix_figure.m：配置figure满足60*80的大小
% get_filterparas.m：得到低通滤波器要满足的通带起始点和通带停止点
% get_filterTransfer.m：得到滤波器的离散传递函数
% get_Ltheta.m：得到L_theta状态扰动模拟曲线
% c2dTranfer.m：FSM离散函数的建立
% error_coarse.m：加载粗跟踪误差信号
% PsdCmp.m：对比了L_theta and SILEX的功率谱密度
% ObserveKalmanpid.m：ASTKF＋PID 算法
% ObserveKalman.m：卡拉曼滤波算法
% Simkalman.m：进行了卡尔曼滤波器的仿真
% PidTest.m：ASTKF＋PID中的PID实验
% ASTKF_PidTest.m：ASTKF＋PID中的ASTKF＋PID实验

%% END