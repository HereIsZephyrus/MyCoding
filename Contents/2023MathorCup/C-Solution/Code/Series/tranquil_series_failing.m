clc;clear;close all;
load cleared_Series.mat
load DanielResult.mat
%load dd_cleared.mat
len_AR=15;%滑块长度
len_MA=15;
len_proving=15;%检验长度
len_grant=50; %数据完整点判定阈值
len_pre=20;%预测长度
Predict=zeros(length(ind),len_pre);
broken=0;
%% 对于平稳序列
for i=Flat
    Data=Series_var{i};
    if (length(Data)<=2)
        continue
    end
    % 完整点
    if (length(Data)>=len_grant)
        len_AR=30;%滑块长度
        len_proving=15;%检验长度
        len_grant=len_AR+len_proving; %数据完整点判定阈值
        len_pre=20;%预测长度

        len=length(Data);
        tmp_data=Data(1:len-len_proving);
        len=len-len_proving;
        for j=1:len_proving
            len=len+1;
            %[a,b]=Smoothing(tmp_data,0.3);
            %tmp_data(len)=a+b;
            %tmp_data(len)=Average(Data,len_AR);

            model = arima(15,0,0);
            fit = estimate(model,tmp_data');
            %fore = forecast(fit,len_proving);
            tmp_data=[tmp_data,fore'];
        end
        err(i)=abs(mean((tmp_data(len-len_proving:len)-Data(len-len_proving:len))./Data(len-len_proving:len)));
        for j=1:len_pre
            [a,b]=Smoothing(tmp_data,0.3);
            len=len+1;
            tmp_data(len)=a+b;
        end
        Predict(i,:)=tmp_data(len-len_pre+1:len);
        clear len a b
    else
    % 非完整点
        len_AR=2;%滑块长度
        len_proving=2;%检验长度
        len_pre=20;%预测长度
        
        len=length(Data);
        tmp_data=Data(1:len-len_proving);
        len=len-len_proving;
        for j=1:len_proving
            len=len+1;
            %[a,b]=Smoothing(tmp_data,0.3);
            %tmp_data(len)=a+b;
            tmp_data(len)=Average(Data,len_AR);
        end
        err(i)=abs(mean((tmp_data(len-len_proving:len)-Data(len-len_proving:len))./Data(len-len_proving:len)));
        for j=1:len_pre
            [a,b]=Smoothing(tmp_data,0.3);
            len=len+1;
            tmp_data(len)=a+b;
        end
        Predict(i,:)=tmp_data(len-len_pre+1:len);
        broken=broken+1;
        clear len a b
    end
end
clear i j ans Data

%% 对于非平稳序列
for i=unFlat
    Data=diff(Series_var{i});
    if (length(Data)<=2)
        continue
    end
    % 完整点
    if (length(Data)>=len_grant)
        len_AR=30;%滑块长度
        len_proving=15;%检验长度
        len_grant=50; %数据完整点判定阈值
        len_pre=20;%预测长度

        len=length(Data);
        tmp_data=Data(1:len-len_proving);
        len=len-len_proving;
        for j=1:len_proving
            len=len+1;
            %[a,b]=Smoothing(tmp_data,0.3);
            %tmp_data(len)=a+b;
            tmp_data(len)=Average(Data,len_AR);
        end
        err(i)=abs(mean((tmp_data(len-len_proving:len)-Data(len-len_proving:len))./Data(len-len_proving:len)));
        for j=1:len_pre
            [a,b]=Smoothing(tmp_data,0.3);
            len=len+1;
            tmp_data(len)=a+b;
        end
        Predict(i,:)=tmp_data(len-len_pre+1:len);
        clear len a b
    else
    % 非完整点
        len_AR=2;%滑块长度
        len_proving=2;%检验长度
        len_pre=20;%预测长度
        
        len=length(Data);
        tmp_data=Data(1:len-len_proving);
        len=len-len_proving;
        for j=1:len_proving
            len=len+1;
            %[a,b]=Smoothing(tmp_data,0.3);
            %tmp_data(len)=a+b;
            tmp_data(len)=Average(Data,len_AR);
        end
        err(i)=abs(mean((tmp_data(len-len_proving:len)-Data(len-len_proving:len))./Data(len-len_proving:len)));
        for j=1:len_pre
            [a,b]=Smoothing(tmp_data,0.3);
            len=len+1;
            tmp_data(len)=a+b;
        end
        Predict(i,:)=tmp_data(len-len_pre+1:len);
        broken=broken+1;
        clear len a b
    end
end
clear i j ans Data

%% 结论输出
%err=reshape(err,33,19);
err=err(~isnan(err));
err=err(~isinf(err));
writematrix(err','err.xlsx');
%% 平滑函数
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