clc;clear
load Series.mat
%未按照流量排序
Count=cell(1,7);%七类
% 1优秀节点
% 2临时节点
% 3延迟开启节点
% 4永久关闭节点
% 5短时间节点
% 6式微节点
% 7繁荣节点
crisis=120;
time=size(Time_var,2);
for i=1:num_connect
    IsTemp(i)=(Time_total(i)<=10) || ((nnz(Time_var(i,:))<=10));
    if (IsTemp(i)==1)
        Count{2}(end+1)=i;
    end
end
clear i
for i=1:num_connect
    if (IsTemp(i)==1)
        continue
    end
    Delay=1;%是否开始很长一段时间未运行
    Shut=1;%是否永久关闭
    for j=1:time
        if (j<crisis && Time_var(i,j)>0)
            Delay=0;
        end
        if (j>time-crisis && Time_var(i,j)>0)
            Shut=0;
        end
    end
    if (Delay+Shut==2)
        Count{5}(end+1)=i;
    end
    if (Delay==1)
        Count{3}(end+1)=i;%记录下节点编号
    end
    if (Shut==1)
        Count{4}(end+1)=i;%记录下节点编号
    end
    if (Delay+Shut==0)%既不是很长时间未运行也不是永久关闭
        Count{1}(end+1)=i;
    end
    clear Delay Shut Temp
end
clear i j
%对正常节点再细分
tmp=[];
for i=Count{1}
    delta=mean(Time_var(i,end-crisis+1:end))/mean(Time_var(i,crisis+1:end-crisis+1));
    if (log(delta)<-0.1 || max(Time_var(i,end-crisis+1:end))<10)
        Count{6}(end+1)=i;
    else
        if (log(delta)>1)
            Count{7}(end+1)=i;
        else
            tmp(end+1)=i;
        end
    end
end
Count{1}=tmp;
clear i tmp delta
save Cate.mat Count
clear ans time crisis IsTemp