clc;clear;close all;
load arrayData.mat
load sleepData.mat
%% 建立分类标准
Res=m_Clustering(scoreSleep,4);
aver=zeros(1,4);barr=zeros(1,4);
for i=1:4
    aver(i)=mean(scoreSleep(Res{i}));
    barr(i)=min(scoreSleep(Res{i}));
end
[aver,ind]=sort(aver,'descend');
Res=Res(ind);barr=barr(ind);
clear i ind
%% 建立回归方程
[coef,weight,rate]=m_Factor(basic,3);
[residual,common]=m_FactorCheck(basic,1:3);
score=basic*coef;
Tscore=score*weight';
[d,~,~,~,stats]=regress(scoreSleep,[ones(len,1),Tscore]);

%% 利用回归和聚类结果分类
load scoreData.mat
len2=length(preData.ID);
physical=[preData.motherAge,preData.Marriage,preData.Education,preData.Time,preData.Method];
psychosocial=[preData.CBTS,preData.EPDS,preData.HADS];
basic=[physical,psychosocial];
Bscore=basic*coef;
BTscore=Bscore*weight';
scoreFinal=d(1)+BTscore*d(2);
scoreFinal=1.5*(scoreFinal-min(scoreFinal)+0.5);
cate=zeros(len2,1);
name=["优","良","中","差"];
for i=1:len2
    for j=1:4
        if (scoreFinal(i)>barr(j))
            cate(i)=j;
            cateStr(i)=name(j);
            break
        end
    end
end
clear i j
cateStr=cateStr';
res=table(cate,cateStr);
writetable(res,"problem4.xlsx");
writecell(Res,"SleepCate.xlsx");
save sleepCateData.mat aver barr

