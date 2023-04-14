clc;clear;close all;
load Cate.mat
load Series.mat
ind=[Count{1},Count{3}];
ind=sort(ind);
for len=1:length(ind)
    Series_var{len}=Time_var(ind(len),:);
end
for i=1:len
    Min=min(Series_var{i});%第i条的最小值
    %{
    tmp_ind=[];
    for j=1:365*2
        if (Series_var{i}(j)>min)
            tmp_ind=[tmp_ind,j];
        end
    end
    %}
    tmp_ind=find(Series_var{i}>Min);%下标
    tmp=Series_var{i}(tmp_ind);
    %{
    TF=isoutlier(tmp);
    ind_TF=find(TF);
    %tmp=filloutliers(tmp,'nearest');
    res_ind=0;res=[];
    for k=1:length(tmp)
        if nnz(ismember(ind_TF,k)>0)
            continue;
        end
        res_ind=res_ind+1;
        res=[res,tmp(k)];
    end
    Series_var{i}=res;
    %}
    Series_var{i} = rmoutliers(tmp); 
    clear tmp_ind Min tmp 
    clear TF ind_TF k res res_ind
end
clear i j
save("cleared_Series.mat","Series_var","ind");

clear ans