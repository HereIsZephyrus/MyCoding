%% 恒定温度的伏安曲线
clc;clear;close all;
T=30+273.15;q=1.6e-19;
V=0.450:0.005:0.540;
I=[4.500,5.500,6.600,8.000,9.500,11.700,14.300,17.200,20.800,25.200,...
    30.500,38.000,44.700,54.500,66.500,78.000,95.000,116.500,143.000];
hold on;
scatter (V,I,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor','b',...
              'LineWidth',1);
f=@(a,K) (a(1)*exp(a(2)*K));%a(1)=Is,a(2)=q/(KT)
ahat=nlinfit(V,I,f,[0;0]);
plot(V,f(ahat,V),'g-','LineWidth',1.2);
legend("测量数据","拟合数据",'Location','northwest');
xlabel("正向电压V_s");  ylabel("正向电流I_f");
title("30^\circ C 时该半导体正向导通伏安曲线");
Is=ahat(1);K=q/(ahat(2)*T);
K0=1.38e-23;
eta=abs(K-K0)/K;
str={strcat("反向饱和电流I_{s}=",num2str(Is)),strcat("玻尔兹曼常数K=",num2str(K)),strcat("与公认值误差\eta=",num2str(eta))};
text(min(V)+0.002,max(I)-50,str);
hold off;

%% 恒定电流半导体温度特性曲线
clc;clear;close all;
T=[30:5:80]+273.15;q=1.6e-19;
Vup=[0.513	0.501	0.49	0.478	0.467	0.455	0.443	0.433	0.421	0.409	0.398];
Vdown=[0.512	0.501	0.489	0.477	0.466	0.454	0.443	0.432	0.409	0.409	0.398];
V=(Vup+Vdown)/2;
hold on
mdl=fitlm(T,V);
scatter (T,V,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor','b',...
              'LineWidth',1);
a=mdl.Coefficients.Estimate;
f=@(x) a(2)*x+a(1);
fplot(f);
xlabel("半导体温度T^{\circ} C");  ylabel("正向电压V_f(V)");
title("施加50 \mu A时该半导体温度特性曲线");
axis([300,350,0.4,0.52]);
legend("测量数据","拟合数据");
Eg=q*f(0)/(1.6021766208e-19);
str={strcat("灵敏度S=",num2str(a(2))),strcat("近似禁带宽度E_g(0)=",num2str(Eg))};
text(305,0.44,str);
hold off

%%