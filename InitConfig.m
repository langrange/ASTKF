%% Run start
%% condition is a global variable for choosing to tune the 'c' or not
clear all,clc
global condition
condition =0 ;

%% OnlyPid is a global variable for choosing the PID or ASTKF+PID
global OnlyPid
OnlyPid = 0;
