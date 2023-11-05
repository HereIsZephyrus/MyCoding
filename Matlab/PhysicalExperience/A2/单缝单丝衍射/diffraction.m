clc;clear;close all;

lamda=650e-9;
Dis(1)=40e-2; Dis(2)=50e-2; D=abs(Dis(1)-Dis(2));

%% 单缝衍射
Xd=zeros(2,5);
Xd(1,:)=[0.75,0.725,0.833,0.95,0.98]*1e-2;
Xd(2,:)=[1.0,0.975,1.117,1.188,1.25]*1e-2;
mxd=mean(Xd,2); sxd=sqrt((Xd-mxd).*(Xd-mxd))*1000;
d=lamda*D/abs(mxd(1)-mxd(2));

%% 单丝衍射
Xa=zeros(2,5);
Xa(1,:)=[1.75,1.125,1.117,1.188,1.25]*1e-2;
Xa(2,:)=[1.5,1.35,1.5,1.65,1.6]*1e-2;
mxa=mean(Xa,2); sxa=sqrt((Xa-mxa).*(Xa-mxa))*1000;
a=lamda*D/abs(mxa(1)-mxa(2));
