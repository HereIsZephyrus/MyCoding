clc;clear;
format shortG;
L=65.33;%cm
H=67.81;%cm
D=3.824;%cm
d0=1.2e-3;%cm
d=[4.96e-2,5.05e-2,5.02e-2,5.07e-2,5.00e-2];
Average_d=sum(d)/length(d)-d0;
N=6;%times
m=linspace(1,N,N);%kg
x_upper=[1.22,1.95,2.75,3.18,3.78,4.45];%cm
x_lower=[1.40,2.15,2.90,3.68,4.45,5.00];%cm
x_average=(x_upper+x_lower)/2;%cm
dx=zeros(1,3);%逐差存储
for k=1:fix(N/2)
    dx(k)=(x_average(k+fix(N/2))-x_average(k))/fix(N/2);
end
g=9.8;%N*m^-2
E=8*g*L*H/pi/D/(Average_d^2)/(sum(dx)/3);%kg;cm;
%vpa(E,2);
disp(E);
ep=[5e-4,2e-3,5e-2,5e-2,5e-2,1e-2];
%直径-千分尺,臂长-游标卡尺,线长-卷尺,高度-卷尺,标尺,拉力-拉力计;cm,kg;

U=0.683*ep; %Bclass,置信概率取0.683
U(1)=sqrt(sum(d-Average_d)^2/length(d)/(length(d)-1)+(U(1))^2);%Aclass
U(5)=sqrt(sum(dx-(sum(dx)/3))^2/length(dx)/(length(dx)-1)+(U(5))^2);%A
%Y=Uncertainty1(U);
Y=Uncertainty2(U,d0,D,L,H,sum(dx)/3,g);
disp(Y);
function dY=Uncertainty1(U)
    syms x y l  h n w;%x-直径,y-臂长,l-线长,h-高度,n-逐差长度,w-重量
    f_expr=@(x,y,l,n,h,w)(8*9.8*l*h*w/pi/y/(x^2)/n);
    df1=diff(f_expr,x);     df2=diff(f_expr,y);         df3=diff(f_expr,l);
    df4=diff(f_expr,h);     df5=diff(f_expr,w);       df6=diff(f_expr,n);
    x=U(1);       y=U(2);       l=U(3);        h=U(4);   n=U(5);    w=U(6);
    duf=zeros(1,6);
    duf(1)=subs(df1);        duf(2)=subs(df2);          duf(3)=subs(df3);
    duf(4)=subs(df4);       duf(5)=subs(df5);          duf(6)=subs(df6);
    dY=sqrt(sum(duf.^2));
end
function dY=Uncertainty2(U,d,D,L,H,x,F)
    dY=sqrt((U(1)/d)^2+4*(U(2)/D)^2+(U(3)/L)^2+(U(4)/H)^2+(U(5)/x)^2+(U(6)/F^2));
end
