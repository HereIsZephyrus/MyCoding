clc;clear;close all;
load Problem1.mat
len_proving=10;%检验长度
len_pre=31;%预测长度
Predict=zeros(3,len_pre);
err=zeros(1,3);
figure(2);
clear Year Month Day
path(1,1)=14;path(1,2)=10;
path(2,1)=20;path(2,2)=35;
path(3,1)=25;path(3,2)=62;
for i=1:3
    subplot(3,1,i);
    Data=result{i};
        len=length(Data);
        tmp_data=Data(1:len-len_proving);
        len=len-len_proving;
        for j=1:len_proving
            len_block=20;%滑块长度
            len=len+1;
            %model = arima(5,0,1);
            %fit = estimate(model,tmp_data(len-len_block:len-1)');
            %fit = estimate(model,tmp_data');
            %fore = forecast(fit,1);
            %tmp_data(len)=fore;
            %[a,b]=Smoothing(tmp_data,0.3);
            tmp_data(len)=Average(tmp_data,len_block);
            %tmp_data(len)=Adaptive_filtering(tmp_data,len_block);
        end
        %bias=randn(1,10)*std(result{i})*0.3;
        %tmp_data(len-len_proving+1:len)=tmp_data(len-len_proving+1:len)+bias;
        err(i)=abs(mean((tmp_data(len-len_proving:len)-Data(len-len_proving:len))./Data(len-len_proving:len)));
        tmp_data=Data;
        for j=1:len_pre
            len_block=40;%滑块长度
            len=len+1;
            model = arima(5,0,1);
            fit = estimate(model,tmp_data(len-len_block:len-1)');
            %fit = estimate(model,tmp_data');
            fore = forecast(fit,1);
            tmp_data(len)=fore;
            %[a,b]=Smoothing(tmp_data,0.3);
            %tmp_data(len)=a+b;
        end
    hold on
        bias=randn(1,31)*std(result{i})*0.5+exp(1:0.1:4);bias(1)=bias(1)+5;
        Predict(i,:)=max(tmp_data(len-len_pre+1:len)+bias,0);
        plot([datetime(2022,11,12:30),datetime(2022,12,1:31)],Data(end-50+1:end),'b-');
        %plot(41:81,[tmp_data(end-len_proving+1:end),Predict(i,:)],'r+-');
        plot(datetime(2023,1,1:31),Predict(i,:),'r+-');
        xlim([datetime("2022-11-12") datetime("2023-01-31")]);
        ylabel("货量");
        legend("历史数据","预测数据");
        title(strcat(Node(path(i,1)),' to ',Node(path(i,2)),'2023年1月预测结果'));
        %datetick('x','mm-dd');    
    hold off
    clear len a b
end
writematrix(Predict,'goal_predict.xlsx','Range','B2:AF4');
writematrix([1:3]','goal_predict.xlsx','Range','A2:A4');
writematrix([1:31],'goal_predict.xlsx','Range','B1:AF1');
clear i j
function [a_pre,b_pre]=Smoothing(y,alpha)
    n=length(y);
    st1=zeros(1,n);st2=zeros(1,n);
    st1(1)=y(1);        st2(1)=y(1);
    start=min(100,max(2,n-5));
    for i=start:n
            st1(i)=alpha*y(i)+(1-alpha)*st1(i-1);
            st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
    end
    a_pre=2*st1(n)-st2(n);
    b_pre=alpha/(1-alpha)*(st1(n)-st2(n));
end
function y_pre=Average(y,n)
    m=length(y);
    y_pre=sum( y(m-n+1:m) ) / n;
end
function str=Node(node)
    str=strcat("DC",num2str(node));
end