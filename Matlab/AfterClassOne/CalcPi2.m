clc;clear;
n=1e8+80*1e7;
Res=0;
for i=1:n
    x=rand;y=rand;
    if (x^2+y^2<=1)
        Res=Res+1;
    end
end
Pi=4*Res/n;
fprintf('My answer is %.30f\nthe error is %.30f\n',vpa(Pi,30),abs(pi-Pi));
%