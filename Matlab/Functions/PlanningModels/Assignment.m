function [opt_chosen,opt_fval]=Assignment(goal)
%指派问题,goal为目标函数的系数矩阵
[n,m]=size(goal);
%不等式约束矩阵的构建——对被指派人的约束
A=zeros(n,n*m); 
b=ones(n,1);
for i=1:n
    A(i,(i-1)*m+1:m*i)=1;
end
%线性等式约束矩阵的构建——对被指派对象的约束
Aeq=repmat(eye(m),1,n);
beq=ones(m,1);

%若干非数据约束
intcon=ones(n*m,1);
lb=zeros(n*m,1);
ub=ones(n*m,1);
%求解
[opt_chosen,opt_fval]=intlinprog(goal,intcon,A,b,Aeq,beq,lb,ub);
opt_chosen=reshape(opt_chosen,[5,5]);
end