function [opt_chosen,opt_fval]=Backpack(Goal,Weight,max_Weight)
%指派问题,goal为目标函数的系数矩阵,Weight为物品重量的系数向量,max_Weight为背包的最大容量
n=length(Goal);
%若干非数据约束
intcon=ones(n,1);
lb=zeros(n,1);
ub=ones(n,1);
%求解
[opt_chosen,opt_fval]=intlinprog(Goal,intcon,A,b,[],[],lb,ub);
opt_fval=-opt_fval;
end