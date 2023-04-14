%ARMA时间序列,x为样本,此处暂时取正态分布随机数,利用Toeplit矩阵的递推公式得到样本偏相关函数
clc;clear;
randn('state',sum(clock));
elps=randn(1,10000);
x(1)=0;
for j=2:10000
    x(j)=0.8*x(j-1)+elps(j)-0.4*elps(j-1); %生成样本点
end


y=(x-mean(x));%中心化
gama0=var(x);%方差
L=10;
for j=1:L
    gama(j)=y(j+1:end)*y(1:end-j)'/10000;%协方差
end
rho=gama/gama0;%相关系数
f(1,1)=rho(1);
for k=2:L
    s1=rho(k);      s2=1;
    for j=1:k-1
        s1=s1-rho(k-j)*f(k-1,j);
        s2=s2-rho(j)*f(k-1,j);
    end
    f(k,k)=s1/s2;
    for j=1:k-1
        f(k,j)=f(k-1,j)-f(k,k)*f(k-1,k-j);
    end
end
%disp(f);
pcorr=diag(f)'; %提取偏相关函数
%disp(pcorr);
pcorr2=parcorr(x); %计算偏相关函数
disp(pcorr2);

%利用GARCH工具箱实现时间序列建模功能,函数原型为ARMAX(R,M,Nx)
% R,M表示ARMA(R,M)模型的阶次
%AR表示最回归中的R个系数向量
%MA表示滑动平均中的M个系数向量
%C表示模型中的常数
%[Coeff,Errors,LLF,Innovations,Sigmas]=garchfit(Spec,Series)
%Spec指定模型的结构,Series为时间序列的样本观测值.输出参数Coeff是模型的参数估计值,Errors是模型参数的标准差,
% LLF是最大似然估计法中的对数目标函数值,Innovations是残差向量,Sigmas是对应于Innovations的标准差.
spec=garchset('R',1,'M',1,'Display','off');