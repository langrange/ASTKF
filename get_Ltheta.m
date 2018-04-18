function [x_Ltheta,psd_Ltheta,len] = get_Ltheta(moduleName)

    % Function:get the PSD data form psd scope to workspace 
    % Input £ºsimulink model
    % Output £ºPsd data and teh length of time
    % @moduleName : simulink model ,here it is the L_theta model
    
    open_system(moduleName) % open simulink module
    sim(moduleName) % begin to simulink this module

    set(0,'ShowHiddenHandles','on');  
    set(gcf,'menubar','figure');  % conversion from psd scoope to figure

    handl1 = get(gca);
    handData2 = handl1.Children ;
    l2 = get(handData2(8)) ;
    Unilateral_start = length(l2.XData)/2 ;

    x_Ltheta = l2.XData(Unilateral_start:end);
    psd_Ltheta = l2.YData(Unilateral_start:end);
    
    len = length(simout.Time);
end

%EOF
