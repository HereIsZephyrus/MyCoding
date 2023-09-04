clc;clear;close all;
load Start_End.mat
load originGragh.mat
%% 初始化
[n,m]=size(Gragh);
tmp_gragh=zeros(n,m);
for i=1:n
    tmp_gragh(i,1)=str2num(erase(Gragh(i,1),"DC"));
    tmp_gragh(i,2)=str2num(erase(Gragh(i,2),"DC"));
end
Gragh=tmp_gragh;
clear i tmp_gragh

%% 计算和
Total=zeros(length(ind_start)+1,365*2);
for i=1:n
    for j=1:length(ind_start)
        if (ind_start(j)==Gragh(i,1))
            dates=days(Date(i)-Date(1))+1;
            Total(j,dates)=Total(j,dates)+Volume(i);
        end
    end
end
Total(length(ind_start)+1,:)=sum(Total(1:length(ind_start),:));
%for i=1:365*2
%    Total(,i)=sum(Total(1:ind_start,i));
%end
clear i j
%%
plot(1:365*2,Total(length(ind_start)+1,:));
writematrix(Total,"Total.xlsx");
clear i ans