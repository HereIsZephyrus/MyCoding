clc;clear;close all;
%计算DC9附近的流量
%delete(gcp('nocreate'));
%p=parpool(12);
load Series.mat
load cateNode9.mat
startTime=min(find(Date==datetime(2022,11,1)));
During=days(datetime(2022,12,31)-datetime(2022,11,1))+1;
%Flows=zeros(4,During);
Flows=zeros(4,365*2);
hold on
for i=1:4
    %Flows(i,:)=sum(Time_var(E{i},end-During+1:end),1);
    Flows(i,:)=sum(Time_var(E{i},:),1);
    %plot([datetime(2022,11,1:30),datetime(2022,12,1:31)],Flows(i,:),'LineWidth',1);
    plot(1:365*2,Flows(i,:),'LineWidth',1);
end
clear i
grid on
legend("DC5左节点","DC5右节点","左节点的右节点","右节点的左节点");
%xlim([datetime("2022-11-1") datetime("2022-12-31")]);
ylabel("货量");
set(gca,'yscale','log');
title("DC5最近二月的货物流量");
save("FlowsAmong9.mat","Flows");
hold off

%% clear
%delete(p);
clear ans