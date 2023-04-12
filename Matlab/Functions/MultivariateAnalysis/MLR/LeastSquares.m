% X,Y为原始数据
x=[];y=[];
%最小二乘拟合
mdl = fitlm(X,Y);
%拟合优度检验
[p,f] = coefTest(mdl);
% 显著性检验
%t = mdl.Coefficients.tStat(2);
%p = mdl.Coefficients.pValue(2);
