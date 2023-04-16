%clc;clear;close all;
function [order,result,overFlow]=SAforOrder9(index,day)
    load StatusAmong9.mat
    load maxVolume.mat
    reOrder=0;
    rng('shuffle');
    num_node=81;
    %%init loading--E3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    local=find(index==1);
    edge=Status{3}(local,1);
    start=Status{3}(local,2);
    term=Status{3}(local,3);
    contain=Status{3}(local,4);
    predict=Status{3}(local,5+day-1);
    predict=min(predict,contain);
    predict=Clean(predict);
    %rate=sum(predict);%正在跑的总流量
    Total=sum(Status{1}(:,4));%流向DC5的需要分配的流量
    num_edge=length(edge);%E3集合的大小
    shutPop=ones(1,num_node);%一开始所有出点都开着
    shutPush=ones(1,num_node);%一开始所有入点都开着
    overFlow=0;%流量是否溢出
    %%产生一组可接受的初始解
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %order=predict*CalcPort(total,rate);
    reOrder=0;
    order=zeros(1,num_edge);
    order(:)=Total/num_edge;
    for i=1:num_edge%考虑E3的运输能力
        if (predict(i)+order(i)>contain(i))
            reOrder=predict(i)+order(i)-contain(i);%把边能多承载的流量拿出来
            order(i)=contain(i)-predict(i);%把边塞满
            if (order(i)<0)
                error("错误的分配");
            end
            if (predict(i)+order(i)>contain(i))
                error("错误的分配");
            end
        else%这条边没有塞满
            if (reOrder<=(contain(i)-(predict(i)+order(i))+1)/2)
                order(i)=order(i)+reOrder;
                reOrder=0;
            else
                order(i)=order(i)+(contain(i)-(predict(i)+order(i))+1)/2;
                reOrder=reOrder-(contain(i)-(predict(i)+order(i))+1)/2;
            end
        end
    end
    flag=1;%还存在有容量的边;
    while (reOrder>0 && flag==1)
        flag=0;
        for i=1:num_edge%考虑E3的运输能力
            if (predict(i)+order(i)<contain(i))
                flag=1;
                if (reOrder<=(contain(i)-(predict(i)+order(i))+1)/2)
                    order(i)=order(i)+reOrder;
                    reOrder=0;
                else
                    if (reOrder>0)
                    order(i)=order(i)+(contain(i)-(predict(i)+order(i))+1)/2;
                    reOrder=reOrder-(contain(i)-(predict(i)+order(i))+1)/2;
                    end
                end
            end
        end
    end
    if (flag==0 && reOrder>0)
        overFlow=1;
        result=-1;
        return
    end
    clear flag

    %考虑N1的出货能力和N3的收获能力
    runningPop=zeros(1,num_node);
    runningPush=zeros(1,num_node);
    for i=1:num_edge
        node=start(i);%取出N1中的点
        runningPop(node)=runningPop(node)+predict(i)+order(i);
        node=term(i);%取出N3中的点
        runningPush(node)=runningPush(node)+predict(i)+order(i);
        clear node
    end
    for i=1:num_edge%处理点的冲突
        if (shutPop(start(i))==0 || shutPush(term(i))==0)
            continue
        end
        node=start(i);%N1
        if (runningPop(node)>maxPop(node))
            if (runningPop(node)-maxPop(node)<=order(i))
                take=runningPop(node)-maxPop(node);
                reOrder=reOrder+take;
                order(i)=order(i)-take;
                runningPop(node)=runningPop(node)-take;
                shutPop(node)=0;%冲突已经解决关闭冲突节点
            else
                take=order(i);
                reOrder=reOrder+take;
                order(i)=order(i)-take;
                runningPop(node)=runningPop(node)-take;
            end
        end
        clear node take
        node=term(i);%N1
        if (runningPush(node)>maxPush(node))
            if (runningPush(node)-maxPush(node)<=order(i))
                take=runningPush(node)-maxPush(node);
                reOrder=reOrder+take;
                order(i)=order(i)-take;
                runningPush(node)=runningPush(node)-take;
                shutPush(node)=0;%冲突已经解决关闭冲突节点
            else
                take=order(i);
                reOrder=reOrder+take;
                order(i)=order(i)-take;
                runningPush(node)=runningPush(node)-take;
            end
        end
        clear node take
    
    end
    
    %循环解决冲突
    while (reOrder>0 && (nnz(shutPop)+nnz(shutPush))>0)%还有未分配的流量并且不能所有节点都关闭了
        for i=1:num_edge%考虑E3的运输能力
            if (shutPop(start(i))==0 || shutPush(term(i))==0)
                continue
            end
            if (predict(i)+order(i)>contain(i))
                reOrder=predict(i)+order(i)-contain(i);%把边能多承载的流量拿出来
                order(i)=contain(i)-predict(i);%把边塞满
            else%这条边没有塞满
                if (reOrder<=(contain(i)-(predict(i)+order(i))+1)/2)
                    order(i)=order(i)+reOrder;
                    reOrder=0;
                else
                    order(i)=order(i)+(contain(i)-(predict(i)+order(i))+1)/2;
                    reOrder=reOrder-(contain(i)-(predict(i)+order(i))+1)/2;
                end
            end
        end
        flag=1;%还存在有容量的边;
        while (reOrder>0 && flag==1)
            flag=0;
            for i=1:num_edge%考虑E3的运输能力
                if (shutPop(start(i))==0 || shutPush(term(i))==0)
                continue
            end
                if (predict(i)+order(i)<contain(i))
                    flag=1;
                    if (reOrder<=(contain(i)-predict(i)+1)/2)
                        order(i)=order(i)+reOrder;
                        reOrder=0;
                    else
                        if (reOrder>0)
                        order(i)=order(i)+(contain(i)-predict(i)+1)/2;
                        reOrder=reOrder-(contain(i)-predict(i)+1)/2;
                        end
                    end
                end
            end
        end
        if (flag==0 && reOrder>0)
            overFlow=1;
            result=-1;
            return
        end
        clear flag
    
    %考虑N1的出货能力和N3的收获能力
    runningPop=zeros(1,num_node);
    runningPush=zeros(1,num_node);
    for i=1:num_edge
        if (shutPop(start(i))==0 || shutPush(term(i))==0)
            continue
        end
        node=start(i);%取出N1中的点
        runningPop(node)=runningPop(node)+predict(i)+order(i);
        node=term(i);%取出N3中的点
        runningPush(node)=runningPush(node)+predict(i)+order(i);
        clear node
    end
        for i=1:num_edge%处理点的冲突
            if (shutPop(start(i))==0 || shutPush(term(i))==0)
                continue
            end
            node=start(i);%N1
            if (runningPop(node)>maxPop(node))
                if (runningPop(node)-maxPop(node)<=order(i))
                    take=runningPop(node)-maxPop(node);
                    reOrder=reOrder+take;
                    order(i)=order(i)-take;
                    runningPop(node)=runningPop(node)-take;
                    shutPop(node)=0;%冲突已经解决关闭冲突节点
                else
                    take=order(i);
                    reOrder=reOrder+take;
                    order(i)=order(i)-take;
                    runningPop(node)=runningPop(node)-take;
                end
            end
            clear node take
            node=term(i);%N1
            if (runningPush(node)>maxPush(node))
                if (runningPush(node)-maxPush(node)<=order(i))
                    take=runningPush(node)-maxPush(node);
                    reOrder=reOrder+take;
                    order(i)=order(i)-take;
                    runningPush(node)=runningPush(node)-take;
                    shutPush(node)=0;%冲突已经解决关闭冲突节点
                else
                    take=order(i);
                    reOrder=reOrder+take;
                    order(i)=order(i)-take;
                    runningPush(node)=runningPush(node)-take;
                end
            end
            clear node take
        end
    end

    %%退火,order为分配方案
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    order=Clean(order);
    begin_heat=10;
    end_heat=0.1;
    Heat=begin_heat;
    Rate=0.9;
    MarkovLength=100;
    totalContain=Status{3}(:,4);%全部边为了得到目标量
    totalPredict=Status{3}(:,5+day-1);
    totalLen=length(totalPredict);
    changed=Effected(totalPredict,order,local);
    Res=CalcGoal(changed,totalContain,totalLen);
    for Layer=1:MarkovLength
        upFlow=Generate(predict,contain,order);
        while (upFlow(1)==-1 || CheckValid(order+upFlow,start,term,maxPop,maxPush,contain)==0)
            upFlow=Generate(predict,contain,order);
        end
        changed=Effected(totalPredict,order+upFlow,local);
        tmp_Res=CalcGoal(changed,totalContain,totalLen);
        cost=tmp_Res-Res;
        if (cost>0 || exp(-cost/Heat)>rand)
            order=order+upFlow;
            Res=tmp_Res;
        end
        Heat=Heat*Rate;
        if (Heat<end_heat)
            break
        end
    end
    result=Res;
end

function rate=CalcPort(total,running)
    rate=total/running;
end
function valid=CheckValid(runningFlow,start,term,maxPop,maxPush,edgeContain)
    len=length(runningFlow);
    num=81;
    valid=1;
    runningPop=zeros(1,num);
    runningPush=zeros(1,num);
    for i=1:len
        if (runningFlow(i)>edgeContain(i))
            valid=0;
            return
        end
        s=start(i);
        t=term(i);
        runningPop(s)=runningPop(s)+runningFlow(i);
        runningPush(t)=runningPush(t)+runningFlow(i);
    end
    for i=1:num
        if (runningPop(i)>maxPop(i))
            valid=0;
            return;
        end
        if (runningPush(i)>maxPush(i))
            valid=0;
            return;
        end
    end
end
function upFlow=Generate(predict,contain,res)
    res=res';
    running=predict+res;%在当前分配方案下的流量
    running=Clean(running);
    n=length(running);
    release=contain-running;
    release=Clean(release);
    if (~isempty(find(release < 0)))
        upFlow=-ones(1,n);
        return;
        %error("分配了大于线路容量的流量");
    end
    [sorted_release,ind_sort]=sort(release);
    shake=0;
    for i=1:n
        if (shake>=0)
            upFlow(ind_sort(i))=sorted_release(i)*0.1;
            shake=shake+upFlow(ind_sort(i));
        else
            upFlow(ind_sort(i))=-min(sorted_release(i)*0.1,res(i));
            shake=shake+upFlow(ind_sort(i));
        end
    end
    clear i
    p=1;
    while(shake>0)
        if (shake<1 && res(ind_sort(p))+upFlow(ind_sort(p))>shake)%消除抖动循环
            upFlow(ind_sort(p))=upFlow(ind_sort(p))-shake;
            shake=0;
            break
        end
        take=shake*0.2;
        while (res(ind_sort(p))+upFlow(ind_sort(p))-take<=0)%不能够被调节
            take=take*0.8;
        end
        upFlow(ind_sort(p))=upFlow(ind_sort(p))-take;
        shake=shake-take;
        p=mod(p,n)+1;
    end
    while(shake<0)
        if (shake>-1 && res(ind_sort(p))+upFlow(ind_sort(p))-shake<=contain(ind_sort(p)))%消除抖动循环
            upFlow(ind_sort(p))=upFlow(ind_sort(p))-shake;%减负等于加正下同理;
            shake=0;
            break
        end
        take=shake*0.2;
        if (res(ind_sort(p))+upFlow(ind_sort(p))+take<=contain(ind_sort(p)))%能够被调节
            upFlow(ind_sort(p))=upFlow(ind_sort(p))-take;
            shake=shake-take;
        end
        p=mod(p,n)+1;
    end
end
function Res=Effected(raw,var,index)
    len=length(var);
    for i=1:len
        raw(index(i))=raw(index(i))+var(i);
    end
    Res=raw;
end
function loading=CalcLoad(contain,running)
    loading=running./contain;
end
function Res=CalcGoal(running,contain,totalLen)
    loading=CalcLoad(contain,running);
    Average=sum(loading)/totalLen;
    Res=sum((loading-Average).^2)/totalLen;
    Res=1/Res;
end
function Res=Clean(raw)
    Res=fix(raw);
end