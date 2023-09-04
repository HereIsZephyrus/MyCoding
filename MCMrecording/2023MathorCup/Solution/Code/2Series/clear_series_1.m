clc;clear;close all;
load Cate.mat
load Series.mat
ind=[Count{1},Count{3}];
ind=sort(ind);
result=cell(1,3);
p=0;
%%
bias=10;%极小值的剔除偏置
for len=1:length(ind)
    tmp_Series_var{len}=Time_var(ind(len),:);
end
edges=0;
ind_edge=[];
for i=1:len
    %{
    tmp_ind=[];
    for j=1:365*2
        if (Series_var{i}(j)>min)
            tmp_ind=[tmp_ind,j];
        end
    end
    %}
    c=-1/(sqrt(2)*erfcinv(3/2));
    Med=median(tmp_Series_var{i});
    tmp=[];
    MAD=2*c*median(abs(tmp_Series_var{i}-Med));
    %{
    if (i==145)
        disp(MAD);
        disp(Med);
        %system("pause");
    end
    %}
    for j=1:length(tmp_Series_var{i})
        if (tmp_Series_var{i}(j)<=Med+MAD && tmp_Series_var{i}(j)>=Med-MAD)
            tmp=[tmp,tmp_Series_var{i}(j)];
        end
    end
    %tmp = rmoutliers(Series_var{i},'gesd'); 
    clear c MAD j Med
    %{
    if (i==145)
        %disp(tmp);
        %disp(Series_var{i});e");
        setdiff(tmp_Series_var{i},tmp)
        %system("pause");
    end
    %}
    Min=min(tmp);%第i条的最小值
    %tmp_ind=find(tmp>(Min+bias));%下标
    tmp_ind=find(tmp>(max(tmp)*0.03));%下标
    tmp=tmp(tmp_ind);
    %{
    if (i==145)
        %disp(tmp);
        %disp(Series_var{i});
        setdiff(tmp_Series_var{i},tmp)
        %system("pause");
    end
    %}
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
        
    if (length(tmp)>=5)
        if (ind(i)==33 || ind(i)==61 || ind(i)==711)
            p=p+1;
            result{p}=tmp;
        end
        edges=edges+1;
        Series_var{edges} = tmp; 
        ind_edge(edges)=ind(i);
    end    
    clear tmp_ind Min tmp 
    clear TF ind_TF k res res_ind
end
clear i j bias
%% 去噪
figure(1);
hold on
for i=1:p
    subplot(3,1,i);
    plot(1:length(result{i}),result{i},'b-');
end
for i=1:edges
    for j=3:length(Series_var{i})-2
        Series_var{i}(j)=mean(Series_var{i}(j-2:j+2));
    end
    Series_var{i}(1)=mean(Series_var{i}(1:1+2));
    Series_var{i}(2)=mean(Series_var{i}(1:2+2));
    Series_var{i}(end)=mean(Series_var{i}(end-2:end));
    Series_var{i}(end-1)=mean(Series_var{i}(end-3:end));
end
%for i=1:p
%    subplot(3,1,i);
%    plot(1:length(result{i}),result{i},'r*');
%end
hold off
clear i j p
save("cleared_Series.mat","Series_var","ind_edge");

clear ans