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

%% 计算连通性
Matrix_Connect=zeros(num);
for i=1:num
    Matrix_Connect(i,i)=inf;
end
num_connect=0;
for i=1:n
    Matrix_Connect(Gragh(i,1),Gragh(i,2))=Matrix_Connect(Gragh(i,1),Gragh(i,2))+1;
    if (Matrix_Connect(Gragh(i,1),Gragh(i,2))==1)
        num_connect=num_connect+1;
    end
end
clear i
writematrix(Matrix_Connect,filename,'Sheet',1,'Range','B2:CD82');
writematrix(1:num,filename,'Sheet',1,'Range','B1:CD82');
writematrix([1:num]',filename,'Sheet',1,'Range','A2:A82');

%% 清理
clear n m ans filename