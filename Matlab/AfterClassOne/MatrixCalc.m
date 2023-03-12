clc;clear;
N=80;
A=rand(N*10,N*20)
Index=find(A>0.4&A<0.5);
Sum=length(Index)
Val=A(Index)
Average=sum(Val)/Sum
A(Index)=Average
