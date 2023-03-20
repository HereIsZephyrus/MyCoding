clc;clear;
%数据处理
load BatteryData.mat
[group,num]=size(R);
figure(2);
for k=1:group
    subplot(group/2,2,k);
    hold on
    % 打点
    R_tmp=R(k,:);
    P_tmp=P(k,:);
    R_tmp=R(k,:);
    plot(R_tmp,P_tmp,'b*');

    %插值拟合
    x=linspace(1,max(R_tmp),1000);
    %pp=csape(R_tmp,P_tmp);
    %y=ppval(pp,x);
    Interp=interp1(R_tmp(:),P_tmp(:),x,'spline');
    plot(x,Interp,'r-');
    a=polyfit(R_tmp,P_tmp,5);
    Fitting=polyval(a,x);
    %f = @(x,xdata) x*xdata.^2+x(2)*sin(xdata);
    %ploy=lsqcurvefit(f,x,R_tmp,P_tmp);
    plot(x,Fitting,'g--');
    %绘图
    title(s);
    xlabel("R(Ω)");
    ylabel("P(mW)");
    legend("数据点","多项式拟合","样条插值","Location","south");
    hold off
end
a=a*1000;
digits(4);
a=vpa(a);
disp(poly2sym(a));
