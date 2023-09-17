clc;clear;close all;
load data.mat
V_H=Vh_Im(:,6);
alpha=0.05;
Im=[0.05:0.05:0.5]';
tbl=table(Im, V_H ,'VariableNames',{'Im','Vh'});
ta=tinv(1-alpha/2,length(Im)-1-1);
mdl = fitlm(tbl,'Vh ~ Im');
tmp_data=table2array(mdl.Coefficients);
tmp_data=tmp_data(:,1);
p=plot(mdl);
func1=strcat('拟合:','y=',num2str(tmp_data(2,1)),'x+',num2str(tmp_data(1,1)));
func2=strcat('置信边界为',int2str((1-alpha)*100),'%');
set(p(1),'DisplayName','原始数据','Marker','x','LineStyle','none','Color',[0 0 1]);
set(p(2),'DisplayName',func1,'LineStyle','-');
set(p(3),'DisplayName',func2,'LineStyle','--');

ylabel('Vh/mV','Interpreter','none');
xlabel('Im/A','Interpreter','none');
title('霍尔电压-偏置电流曲线','Is=3.00mA','Interpreter','none');
[p,f] = coefTest(mdl);
t=[strcat('p-value = ',num2str(p)) newline strcat('F-test   = ',num2str(f))];
text(0.105,1.92,'\Leftarrow 误差点');
text(150,3.5,t);
clear ans t func1 func2
Rh2=tmp_data(2,1);
save('R.mat',"Rh2",'-append');
