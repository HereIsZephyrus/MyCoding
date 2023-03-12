clc;clear;
n=1e7+80*1e4;
Arctanx=0;
for i=1:2:n
    Arctanx=Arctanx+(-1)^((i-1)/2)/i;
end
Pi_Calculated=Arctanx*4;
fprintf('My answer is %.30f\nthe error is %.30f\n',vpa(Pi_Calculated,30),abs(pi-Pi_Calculated));
%
