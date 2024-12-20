clc;clear;close all;
load GenesIN9.mat
load cateNode9.mat
load Series.mat
load PredictFlows9.mat
edge=E{3};
len=length(edge);
start=Time_start(edge);
term=Time_end(edge);
tbl=zeros(31*3,len+1);
predict=PredictFlows{3};
toOrder_all=PredictFlows{1};
Generation=200;
for day=1:31
    toOrder=toOrder_all(day);
    solution=Genes{day};
    superior=solution{Generation}(1,1:len);
    if (nnz(superior)==0)
        tmp_tbl=[[start;0]';[term;0]';[zeros(1,len),0]];
        tbl=[tbl;tmp_tbl];
        continue
    end
    val=solution{Generation}(1,len+1)/nnz(superior);
    [tmp_order,result,~]=SAforOrderIN9(superior,day,toOrder);
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
title("DC9左节点流量分配智能算法迭代结果");
ylabel("目标函数");
xlabel("迭代次数");
hold off
writematrix(tbl,"OrderIN9.xlsx");
clear day edge

function Res=Effected(raw,var,index)
    len=length(var);
    for i=1:len
        raw(index(i))=raw(index(i))+var(i);
    end
    Res=raw;
end