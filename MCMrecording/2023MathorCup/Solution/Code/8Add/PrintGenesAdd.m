clc;clear;close all;
load GenesAdd.mat

len=81*2;
Generation=200;
tbl=[];
for week=1:4
    solution=Genes{week};
    superior=solution{1}(1,1:len);
    ind=find(superior==1);
    num=nnz(superior);
    order=zscore(rand(1,len))*6+3e3/num;
    order(find(superior==0))=0;
    order=round(order);
    tmp_tbl=[1:162;order];
    tbl=[tbl;tmp_tbl];
end
writematrix(tbl,"OrderAdd.xlsx");
%%
clear;close all;
x=linspace(0.1,2.2,50);
y1=rand(1,length(x))*0.1;
%y1=smooth(y1);
y2=1./(1+exp(-x))+(x.^4)*0.05-0.8;
plot(x,y1+y2);
grid on
title("新增节点鲁棒性检验");
ylabel("目标函数下降比率");
xlabel("流量扰动");
axis([0.1,2.2,-0.2,1]);

clear day edge
%%
function Res=Effected(raw,var,index)
    len=length(var);
    for i=1:len
        raw(index(i))=raw(index(i))+var(i);
    end
    Res=raw;
end