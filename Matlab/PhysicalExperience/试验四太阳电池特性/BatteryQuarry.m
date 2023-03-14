clc;clear;
load BatteryData.mat
[group,num]=size(I);
figure(1);
for k=1:group
    subplot(group/2,2,k);
    hold on
    I_tmp=I(k,:);
    U_tmp=U(k,:);
    R_tmp=R(k,:);
    plot(I_tmp,U_tmp,'b*');
    x=linspace(10,I(k),100);
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
%    a=polyfit(I_tmp,U_tmp,6);
%   Fitting=polyval(a,x);
%    plot(x,Fitting,'g--');
    s=num2str(Is(k))+"mA"+"     "+num2str(U0(k))+"V";
    title(s);
    axis([10,Is(k)+5,0,U0(k)+0.5]);
    hold off
end