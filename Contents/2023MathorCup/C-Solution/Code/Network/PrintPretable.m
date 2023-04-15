clc;clear;close all;
load PredictCate.mat
load PredictFlows.mat
load cateNode.mat
load Series.mat

Status=cell(1,4);
for cate=1:4   
    node=N{cate};
    edge=E{cate};
    start=Time_start(edge);
    term=Time_end(edge);
    n=length(E{cate});
    for i=1:n
        contain(i)=max(Time_var(edge(i),:));
    end
    predict=PredictFlows{cate};
    tbl=table(edge',start,term,contain',predict);
    Status{cate}=table2array(tbl);
    writetable(tbl,"FlowsPredict.xlsx",'sheet',num2str(cate));
    clear node edge start term n contain
end
save("StatusAmong.mat",'Status');
clear cate
