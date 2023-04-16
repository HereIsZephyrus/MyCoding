clc;clear;close all;
load PredictCate9.mat
load PredictFlows9.mat
load cateNode9.mat
load Series.mat

Status=cell(1,4);
str={'左节点一月预测','右节点一月预测','左节点的右节点一月预测','右节点的左节点一月预测'};
figure(3);
for cate=1:4   
    node=N{cate};
    edge=E{cate};
    start=Time_start(edge);
    term=Time_end(edge);
    predict=PredictFlows{cate};
    predict=max(predict,0);
    n=length(E{cate});
    subplot(4,1,cate);
    hold on
    for i=1:n
        contain(i)=max(Time_var(edge(i),:));
        plot(datetime(2023,1,1:31),predict(i,:));
    end
    xlim([datetime("2023-01-01") datetime("2023-01-31")]);
    ylabel("货量");
    title(str{cate});
    hold off
    tbl=table(edge',start,term,contain',predict);
    Status{cate}=table2array(tbl);
    writetable(tbl,"FlowsPredict9.xlsx",'sheet',num2str(cate));
    clear node edge start term n contain
end
save("StatusAmong9.mat",'Status');
clear cate
