clc;clear;close all;
load FlowsAmong.mat
load cateNode.mat
load Series.mat
%预测DC5附近的流量
delete(gcp('nocreate'));
p=parpool(12);
nearFlows=Flows(:,365*2-61+1:365*2);

clear i
len_pre=31;%预测长度
Predict=zeros(4,len_pre);
str={'左节点一月预测','右节点一月预测','左节点的右节点一月预测','右节点的左节点一月预测'};
err=zeros(1,4);
Predict=cell(1,4);
figure(2);
for cate=1:4
    subplot(4,1,cate);
    hold on
    for i=1:length(E{cate})
        edge=E{cate}(i);
        Data=Time_var(edge,365*2-61+1:365*2);
        Data=filloutliers(Data,"linear");
        len=length(Data);
        tmp_data=Data;
        for j=1:len_pre
            len_block=40;%滑块长度
            len=len+1;
            try
            model = arima(5,0,1);
            fit = estimate(model,tmp_data(len-len_block:len-1)');
            %fit = estimate(model,tmp_data');
            fore = forecast(fit,1);
            tmp_data(len)=fore;
            %[a,b]=Smoothing(tmp_data,0.3);
            %tmp_data(len)=a+b;
            catch
                tmp_data(len)=Average(tmp_data,len_block);
            end
        end
        %bias=randn(1,31)*std(result{i})*0.5+exp(1:0.1:4);bias(1)=bias(1)+5;
        Predict{cate}(i,:)=tmp_data(len-len_pre+1:len);
        %plot([datetime(2022,11,12:30),datetime(2022,12,1:31)],Data(end-50+1:end),'b-');
        %plot(41:81,[tmp_data(end-len_proving+1:end),Predict(i,:)],'r+-');
        plot(datetime(2023,1,1:31),Predict{cate}(i,:));
        %datetick('x','mm-dd');    
        
        clear len a b edge
    end
    xlim([datetime("2023-01-01") datetime("2023-01-31")]);
    ylabel("货量");
    title(str{cate});
    hold off
end
PredictFlows=Predict;
clear Predict
save("PredictFlows.mat","PredictFlows");
delete(p);
clear ans

function y_pre=Average(y,n)
    m=length(y);
    y_pre=sum( y(m-n+1:m) ) / n;
end
function str=Node(node)
    str=strcat("DC",num2str(node));
end