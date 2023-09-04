%% 建立回归方程
clc;clear;close all;
load arrayData.mat
[coef,weight,rate]=m_Factor(basic,3);
[residual,common]=m_FactorCheck(basic,1:3);
score=basic*coef;
Tscore=score*weight';
[ccoef,p]=corrcoef([Tscore,goal(:,1),scoreSleep]);
d=zeros(5,4);stats=zeros(5,4);
for i=1:4
    [d(i,:),~,~,~,stats(i,:)]=regress(goal(:,i),[ones(len,1),score]);
end
[d(5,:),~,~,~,stats(5,:)]=regress(scoreSleep,[ones(len,1),score]);
clear i
%d=abs(d);
writematrix(d,'RegressRatio.xlsx');
writematrix([cateData.ID,score],'score.xlsx');
save regressData.mat coef d score
varResidual=var(residual)';
t1=table(residual,varResidual,common);
rate=rate';weight=weight';
t2=table(rate,weight,ccoef);
writetable(t1,'FactorRegress.xlsx','Sheet',1);
writetable(t2,'FactorRegress.xlsx','Sheet',2);
