clc;clear;close all;
load data.mat
V_H=Vh_Is(:,6);
alpha=0.05;
Is=[0.5:0.5:3]';
tbl=table(Is, V_H ,'VariableNames',{'Is','Vh'});
ta=tinv(1-alpha/2,length(Is)-1-1);
mdl = fitlm(tbl,'Vh ~ Is');
tmp_data=table2array(mdl.Coefficients);
tmp_data=tmp_data(:,1);
pl=plot(mdl);
func1=strcat('拟合:','y=',num2str(tmp_data(2,1)),'x+',num2str(tmp_data(1,1)));
func2=strcat('置信边界为',int2str((1-alpha)*100),'%');
set(pl(1),'DisplayName','原始数据','Marker','x','LineStyle','none','Color',[0 0 1]);
set(pl(2),'DisplayName',func1,'LineStyle','-');
set(pl(3),'DisplayName',func2,'LineStyle','--');

ylabel('Vh/mV','Interpreter','none');
xlabel('Is/mA','Interpreter','none');
title('霍尔电压-通过电流曲线','Im=500mA','Interpreter','none');
[p,f] = coefTest(mdl);
t=[strcat('p-value = ',num2str(p)) newline strcat('F-test   = ',num2str(f))];
text(1.48,2.60,'\Uparrow 误差点');
text(1,4,t);
clear ans t func1 func2 pl
Rh1=tmp_data(2,1);
save('R.mat',"Rh1",'-append');