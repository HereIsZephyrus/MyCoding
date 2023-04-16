clc;clear;close all;
load GenesIN5.mat
load cateNode5.mat
load Series.mat
load PredictFlows5.mat
edge=E{3};
len=length(edge);
start=Time_start(edge);
term=Time_end(edge);
Generation=200;
tbl=[];
predict=PredictFlows{3};
parfor day=1:31
    solution=Genes{day};
    superior=solution{Generation}(1,1:len);
    val=solution{Generation}(1,len+1)/nnz(superior);
    [tmp_order,result,~]=SAforOrderIN5(superior,day);
    ind=find(superior==1);
    order=Effected(predict(:,day)',tmp_order,ind);
    order=round(order);
    tmp_tbl=[[start;0]';[term;0]';[order,val]];
    tbl=[tbl;tmp_tbl];
end
hold on
for day=1:31
    solution=Genes{day};
    Goal=zeros(1,Generation);
    for i=2:Generation
        sequence=solution{i}(1,1:len);
        Goal(i)=solution{i}(1,len+1)/nnz(sequence);
    end
    plot(1:Generation,Goal);
end
title("DC5左节点流量分配智能算法迭代结果");
ylabel("目标函数");
xlabel("迭代次数");
hold off
writematrix(tbl,"OrderIN5.xlsx");
clear day edge

function Res=Effected(raw,var,index)
    len=length(var);
    for i=1:len
        raw(index(i))=raw(index(i))+var(i);
    end
    Res=raw;
end