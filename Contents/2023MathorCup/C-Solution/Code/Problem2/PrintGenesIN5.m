clc;clear;close all;
load GenesIN5.mat
load cateNode5.mat
load Series.mat
load PredictFlows5.mat
edge=E{3};
len=length(edge);
start=Time_start(edge);
term=Time_end(edge);
tbl=[];
predict=PredictFlows{3};
for day=1:31
    solution=Genes{day};
    superior=solution{1}(1,1:len);
    val=solution{1}(1,len+1);
    [tmp_order,result,~]=SAforOrderIN5(superior,day);
    ind=find(superior==1);
    order=Effected(predict(:,day)',tmp_order,ind);
    order=round(order);
    tmp_tbl=[start';term';order;val];
    tbl=[tbl;tmp_tbl];
end
writematrix(tbl,"OrderIN5.xlsx");
clear day edge

function Res=Effected(raw,var,index)
    len=length(var);
    for i=1:len
        raw(index(i))=raw(index(i))+var(i);
    end
    Res=raw;
end