clc;clear;close all;
load Series.mat
load predictResult.mat
%delete(gcp('nocreate'));
%最后一位是值的大小
%P=parpool(12);
Population=400;
Generation=200;
EncodingLength=81*2;
%disp(toOrder_all);
%solutionChange
Genes=cell(1,4);
global c2;
global c3;
global c1;
global yita;
c2=0.3+rand*0.4;
c3=0.3+rand*0.4;
c1=(c2+c3)*1000;
yita=4/9;
%% 
idx=0;
for i=1:7:21
    idx=idx+1;
    Flow(idx,:)=sum(Predict(i:i+7,:));
    Flow(idx,:)= filloutliers(Flow(idx,:),"linear");
end
clear idx;

%% GAforAdd
for week=1:4
    running=Flow(week);
    genes=cell(Generation,1);
    tic
    t=0;
    genes{1}=GenerateParental2023(Population,EncodingLength);
%top_gene=genes{1}{1};
%Goal(1)=top_gene(1,EncodingLength);
    t=t+toc;
    disp(t);
    for k=2:Generation
        tic
       t=0;
   Parent=genes{k-1};%20
   Child1=Mate2023(Parent,3);%10
   Child2=Variate2023(Parent,0.1);%20
   genes{k}=Choose2023(Parent,Child1,Child2,Population,running);
   t=t+toc;
   Genes{week}=genes;
   disp(t);
end
end
%str=strcat("Genes",num2str(int(rand*100)),".mat");
save("GenesAdd.mat","Genes");
%delete(P);

function Genes=GenerateParental2023(Population,EncodingLength,day,toOrder)
    %遗传算法生成亲代种群
    %Population为种群大小,EncodingLength为染色体基因长度,Genes为种群染色体样本
    Genes=zeros(Population,EncodingLength);
    for p=1:Population
        Sequence=(rand(1,EncodingLength)<=0.09);  %生成个体基因序列
        while (nnz(Sequence)>15)%约束条件,不能存活的个体
            Sequence=(rand(1,EncodingLength)<=0.09);  %生成个体基因序列
        end
        Genes(p,:)=Sequence;     %产生个体  
    end
end

function Child=Mate2023(Parent,IntersectionNum)
    %遗传算法交配亲代得到子代
    %Parent为亲代种群基因型,IntersectionNum为交换基因的数量
    Child=Parent;
    [Population,EncodingLength]=size(Parent);
    EncodingLength=EncodingLength-1;
    for i=1:2:Population
        %利用Logistics混沌序列生成交叉基因座序列
        Locus0=rand;   Locus(1)=4*Locus0*(1-Locus0);
        for loc=2:IntersectionNum
            Locus(loc)=4*Locus(loc-1)*(1-Locus(loc-1));
        end
        Locus=1+ceil(EncodingLength*Locus);
        Locus=unique(Locus);
        %第i个个体与第i+1个个体交配,对应基因座交叉互换
        temp=Child(i,Locus);
        Child(i,Locus)=Child(i+1,Locus);
        Child(i+1,Locus)=temp;
        while (nnz(Child(i,:))>15)%约束条件,不能存活的个体
                tmp=Child(i,:);
                ind=find(tmp==1);
                ind=ind(ceil(rand*length(ind)));
                tmp(ind)=0;
                Child(i,:)=tmp;
        end
        while (nnz(Child(i+1,:))>15)%约束条件,不能存活的个体
                tmp=Child(i+1,:);
                ind=find(tmp==1);
                ind=ind(ceil(rand*length(ind)));
                tmp(ind)=0;
                Child(i+1,:)=tmp;
        end
    end
end

function varied_genotype=Variate2023(initial_genotype,Rate)
    %遗传算法亲代变异得到新的种群基因型
    %initial_genotype为变异前种群基因型,varied_genotype为变异后种群基因型,Rate为变异率
    [Population,EncodingLength]=size(initial_genotype);
    EncodingLength=EncodingLength-1;
    Chosen=find(rand(1,Population)<Rate, 1);     %标记被变异的个体
    if (isempty(Chosen))                                     %如果都没人变异就找一个人变异
        Chosen=floor(Population*rand)+1;
    end
    varied_genotype=initial_genotype;
    numVaried=length(Chosen);
    for p=1:numVaried
            ind=GenerateBreakpoints2023(EncodingLength,3);  %使用三交换构造新的基因序列
            varied_genotype(Chosen(p),:)=varied_genotype(Chosen(p),[1:ind(1)-1,ind(2)+1:ind(3),ind(1):ind(2),ind(3)+1:EncodingLength+1]);
            while (nnz(varied_genotype(Chosen(p),:))>15)%约束条件,不能存活的个体
                tmp=varied_genotype(Chosen(p),:);
                ind=find(tmp==1);
                ind=ind(ceil(rand*length(ind)));
                tmp(ind)=0;
                varied_genotype(Chosen(p),:)=tmp;
            end
    end
end
function ind=GenerateBreakpoints2023(range,num)
    %生成用于交换的1*n的系数向量
    rng("shuffle");
    ind=ceil(range*rand(1,num));
    ind=unique(ind);
	while (length(ind)<num)
		ind=ceil(range*rand(1,num));
        ind=unique(ind);
    end
end
function superior=Choose2023(A,B,C,Population,running)
    %遗传算法选择优秀基因型作为新的亲本
    %A,B,C分别为待选择的基因型
    Merge=[A;B;C];
    [Total,EncodingLength]=size(Merge);
    tmp_order=zeros(1,EncodingLength);
    for j=1:Total
        Sequence=Merge(j,:);
        load(j)=Calccost(Sequence,running);
    end
    [~,ind2]=sort(load,'descend');         %选择
    superior=Merge(ind2(1:Population),:); 
end

function Res=Calccost(Sequence,running)
    global c1;
    global c2;
    global c3;
    global yita;
    num=nnz(Sequence);
    %c1开设成本,c2运输成本,c3处理成本
    reOrder=sum(running)*0.02;
    reOrder=reOrder*(1+rand*0.4-0.2);
    Load=mean(CalcLoad(Sequence,reOrder,running));
    Res=Load/(c1*num+(c2+c3)*reOrder/yita);
end