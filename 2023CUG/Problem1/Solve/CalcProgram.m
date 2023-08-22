function [cost,x]=CalcProgram(select,init,Aeq,dScore)
    k=zeros(1,3);
    k(1)=(2812-200)/(3-0);
    k(2)=(1890-500)/(2-0);
    k(3)=(12500-300)/(5-0);
    k=k(select);init=init(select);Aeq=Aeq(select);
    A=eye(length(select));B=ones(1,length(select));
    k=k./init;
    x=linprog(k,A,B,Aeq,dScore)';
    cost=0;
    if (~isempty(x))
        cost=sum(-k.*x);                                                                                                              
    else
        cost=inf;
    end
end