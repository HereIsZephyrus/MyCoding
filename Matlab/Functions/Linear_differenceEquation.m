clc;clear;
syms a k yk;
a=[0,1;-2,-3];  a=sym(a);
[vec,val]=eig(a);
y0=[0;1];
yk=vec*val.^k*inv(vec)*y0;
collect(yk);
disp(yk);