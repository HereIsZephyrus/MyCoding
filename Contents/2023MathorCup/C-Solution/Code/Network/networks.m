clc;clear;close all;
load Series.mat

n=length(Gragh);
ind_start=1;
while(ind_start<2)
    ind_end=During(ind_start,Date,n);
    Matrix=makeAdj(Gragh(ind_start:ind_end,:),num);
    [starts,ends]=checkterm(Matrix,num);
    Painting(Matrix,starts);
    
    ind_start=ind_end+1;
end
clear ind_start ind_end

function Matrix=makeAdj(edges,num)
    Matrix=zeros(num);
    num_connect=0;
    n=length(edges);
    for i=1:n
        Matrix(edges(i,1),edges(i,2))=Matrix(edges(i,1),edges(i,2))+1;
        %if (Matrix(edges(i,1),edges(i,2))==1)
        %    num_connect=num_connect+1;
        %end
    end
end
function [starts,ends]=checkterm(Matrix,num)   
    num_start=0;
    for i=1:num
        if (any(Matrix(:,i))==0)%i点没有出度
            num_start=num_start+1;
            starts(1,num_start)=i;
        end
    end
    clear i
    num_end=0;
    for i=1:num
        if (any(Matrix(i,:))==0)%i点没有入度
            num_end=num_end+1;
            ends(1,num_end)=i;
        end
    end
end
function Painting(Matrix,starts)
    ymax=100000;%纵坐标的最大值
    nodes=[];%已经处理完的点
    hold on
    Fig=figure(1);
    tmp_node=starts;%正在处理的点
    bias=0.2;
    boarden=2;
%% 处理初始点
    Layers=1;
    num(Layers)=length(tmp_node);%正在处理的点的数量
    inter(Layers)=ymax/num(Layers);%图像上的间隔
    for i=1:length(tmp_node)%打上初始点
        begin=tmp_node(i);
        Layer(begin)=Layers;
        Hight(begin)=inter(1)*i;
        plot(Layers*boarden,Hight(begin),'*');
        %text(Layers*boarden,inter*i-1,Node(begin));
    end
    next_node=[];
    next_num=0;
    for i=1:length(tmp_node)%找出树边
        begin=tmp_node(i);
        for term=find(Matrix(begin,:)>0)%遍历终点
            if (nnz(ismember(nodes,term))+nnz(ismember(tmp_node,term))==0)%%增加层数
                Layer(term)=Layers+1;
                next_num=next_num+1;    
                next_node(next_num)=term;
            end
        end
    end
    for i=1:length(tmp_node)%画出点
        begin=tmp_node(i);
        for term=find(Matrix(begin,:)>0)%遍历终点
            if (nnz(ismember(nodes,term))+nnz(ismember(tmp_node,term))==0)%%增加层数
                Layer(term)=Layers+1;
                next_num=next_num+1;    
                next_node(next_num)=term;
            end
        end
           %text(Layers*boarden,inter(Layers)*i-1,Node(begin));
    end
    Layers=Layers+1;
    nodes=[nodes,tmp_node];
    tmp_node=next_node;
    num(Layers)=length(tmp_node);
    inter(Layers)=ymax/num(Layers);

%% 多层处理
    termed=0;
    while (termed==0)
        termed=1;
        for i=1:length(tmp_node)%画出点
           begin=tmp_node(i);
           Hight(begin)=inter(Layers)*i;
           plot(Layers*boarden,Hight(begin),'*');
           %text(Layers*boarden,inter(Layers)*i-1,Node(begin));
        end
        
        next_node=[];
        next_num=0;
        for i=1:length(tmp_node)%处理反向边  
            begin=tmp_node(i);
            for term=find(Matrix(begin,:)>0)%遍历终点
                if (nnz(ismember(nodes,term)))
                    tmp_x=[Layer(term)*boarden,(Layer(term)+Layer(begin))/2*boarden,Layer(begin)*boarden];
                    tmp_y=[Hight(term),(Hight(term)+Hight(begin))/2+(-1)^(rand>=0.5)*bias,Hight(begin)];
                    plot(tmp_x,tmp_y);
                end
            end
        end
        for i=1:length(tmp_node)%建立非树边
            for j=1:i-1
                begin=tmp_node(i);
                term=tmp_node(j);
                if (Matrix(begin,term)>0)
                   tmp_x=[Layer(term)*boarden,(Layer(term)+Layer(begin))/2*boarden+(-1)^(rand>=0.5)*bias,Layer(begin)*boarden];
                   tmp_y=[Hight(term),(Hight(term)+Hight(begin))/2,Hight(begin)];
                   plot(tmp_x,tmp_y);
                end
            end
        end
        for i=1:length(tmp_node)%找出树边
            begin=tmp_node(i);
            for term=find(Matrix(begin,:)>0)%遍历终点
                if (nnz(ismember(nodes,term))+nnz(ismember(tmp_node,term))==0)%%增加层数
                    Layer(term)=Layers+1;
                    next_num=next_num+1;    
                    next_node(next_num)=term;
                    termed=0;
                end
            end
        end
        Layers=Layers+1;
        nodes=[nodes,tmp_node];
        tmp_node=next_node;
        num(Layers)=length(tmp_node);
        inter(Layers)=ymax/num(Layers);
    end
    hold off;
end


function ind=During(init,Date,n)
    val=Date(init);
    for i=init:n
        if (Date(i)~=val)
            break
        end
    end
    if (i==n)
        ind=n;
    else
        ind=i-1;
    end
end
function str=Node(node)
    str=strcat("DC",num2str(node));
end