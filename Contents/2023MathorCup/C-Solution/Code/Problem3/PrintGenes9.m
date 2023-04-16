clc;clear;close all;
load Genes9.mat
load cateNode9.mat
load Series.mat
load PredictFlows9.mat
edge=E{3};
len=length(edge);
start=Time_start(edge);
term=Time_end(edge);
tbl=zeros(31*3,len);
predict=PredictFlows{3};
for day=1:31
    solution=Genes{day};
    superior=solution{1}(1,:);
    [tmp_order,result,~]=SAforOrder(superior,day);
    ind=find(superior==1);
    order=Effected(predict(:,day)',tmp_order,ind);
    tmp_tbl=[start';term';order];
    tbl=[tbl;tmp_tbl];
end
writematrix(tbl,"Order.xlsx");
clear day edge

function Res=Effected(raw,var,index)
    len=length(var);
    for i=1:len
        raw(index(i))=raw(index(i))+var(i);
    end
    Res=raw;
end