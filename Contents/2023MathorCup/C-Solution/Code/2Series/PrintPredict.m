clc;clear;close all;
load predictResult.mat
load Series.mat
load Cate.mat
n=length(Predict);
count=0;
figure;
for i=Count{1}
    if (nnz(Predict(i,:))==0)
        plot(1:365*2,Time_var(i,:));
        system("pause");
        continue;
    end
    count=count+1;
    start(count)=Time_start(i);
    term(count)=Time_end(i);
    predict(count,:)=Predict(i,:);
end
clear i
tbl=table(start',term',predict);
writetable(tbl,"predictResult.xlsx");