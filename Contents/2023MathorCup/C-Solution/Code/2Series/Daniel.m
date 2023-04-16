clc;clear;close all;
load cleared_Series.mat
n=length(ind_edge);
p=0.95;
for i=1:n
    Data=Series_var{i};
    [sorted,ind_sorted]=sort(Data);
    len=length(Data);
    qs(i)=1-6/(len*(len^2-1))*sum(([1:len]-ind_sorted).^2);
    T(i)=qs(i)*sqrt(n-1)/sqrt(1-qs(i)^2);
    X(i)=tinv(p,len-2);
    clear sorted ind_sorted len Data
end
clear i n p
Flat=find(T<=X);
unFlat=find(T>X);
clear T X qs ans Series_var ind
save("DanielResult.mat");
%{
load cleared_Series.mat
n=length(ind);
p=0.95;
for i=unFlat
    Data=Series_var{i};
    [sorted,ind_sorted]=sort(Data);
    len=length(Data);
    qs(i)=1-6/(len*(len^2-1))*sum(([1:len]-ind_sorted).^2);
    T(i)=qs(i)*sqrt(n-1)/sqrt(1-qs(i)^2);
    X(i)=tinv(p,len-2);
    clear sorted ind_sorted len Data
end
%}