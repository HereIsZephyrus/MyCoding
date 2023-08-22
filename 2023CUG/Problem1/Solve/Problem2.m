%% 建立回归方程
clc;clear;close all;
load arrayData.mat
[coef,weight,rate]=m_Factor(basic,3);
[residual,common]=m_FactorCheck(basic,1:3);
score=basic*coef;
Tscore=score*weight';
[d,~,~,~,stats]=regress(goal(:,1),[ones(len,1),Tscore]);
dd=regress(goal(:,1),score);dd=normalize(dd);
save BehaviorRegress.mat d score Tscore weight dd

%% 利用回归方程预测
load scoreData.mat
len2=length(preData.ID);
physical=[preData.motherAge,preData.Marriage,preData.Education,preData.Time,preData.Method];
psychosocial=[preData.CBTS,preData.EPDS,preData.HADS];
basic=[physical,psychosocial];
Bscore=basic*coef;
BTscore=Bscore*weight';
scoreFinal=zscore([ones(len2,1),BTscore]*d);
scoreBehavior=round(scoreFinal);

for i=1:len2
    if (scoreBehavior(i)<0)
        cate(i)="矛盾型";
    elseif (scoreBehavior(i)>0)
        cate(i)="安静型";
    else
        cate(i)="中等型";
    end
end
clear i
cate=cate';
t=table(scoreFinal,cate);
writetable(t,"problem2.xlsx");
