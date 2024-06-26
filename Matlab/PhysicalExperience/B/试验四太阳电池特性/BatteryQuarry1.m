clc;clear;
%数据处理
load BatteryData.mat
[group,num]=size(I);
figure(1);
for k=1:group
    subplot(group/2,2,k);
    hold on
    % 打点
    I_tmp=I(k,:);
    U_tmp=U(k,:);
    R_tmp=R(k,:);
    plot(I_tmp,U_tmp,'b*');

    %插值拟合
    x=linspace(10,I(k),1000);
    %pp=csape(I_tmp,U_tmp);
    %y=ppval(pp,x);
    p=1;
    while (I_tmp(p)==I_tmp(p+1))
        p=p+1;
    end
    Interp=interp1(I_tmp(p:end),U_tmp(p:end),x,'pchip');
    plot(x,Interp,'r-');
    if (p>1)
        plot(I_tmp(1:p),U_tmp(1:p),'r-');
    end
    a=polyfit(I_tmp,U_tmp,6);
   Fitting=polyval(a,x);
    plot(x,Fitting,'g--');

    %绘图
    s=num2str(Is(k))+"mA"+"     "+num2str(U0(k))+"V";
    title(s);
    xlabel("I(mA)");
    ylabel("U(V)");
    axis([10,Is(k)+5,0,U0(k)+0.5]);
    legend("数据点","多项式拟合","线性插值","Location","southwest");
    hold off
end
