clc;clear;
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
Nodes=unique(Gragh);
num=length(Nodes);
filename = 'Gragh.xlsx';

%% 计算容量
Matrix_Contain=zeros(num);
for i=1:n
    Matrix_Contain(Gragh(i,1),Gragh(i,2))=max(Matrix_Contain(Gragh(i,1),Gragh(i,2)),Volume(i));
end
clear i
writematrix(Matrix_Contain,filename,'Sheet',1,'Range','B2:CD82');
writematrix(1:num,filename,'Sheet',1,'Range','B1:CD82');
writematrix([1:num]',filename,'Sheet',1,'Range','A2:A82');

%% 清理
clear n m ans filename