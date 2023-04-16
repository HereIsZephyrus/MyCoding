clc;clear;close all;
load StatusAmong.mat
load maxVolume.mat
delete(gcp('nocreate'));
%最后一位是值的大小
P=parpool(12);
Population=20;
Generation=20;
edge=Status{3}(:,1);
EncodingLength=length(edge);
Genes=cell(1,31);
parfor day=1:31
    Fig=figure(day);
    genes=cell(Generation,1);
    tic
    t=0;
    genes{1}=GenerateParental2023(Population,EncodingLength,day);
    t=t+toc;
    disp(t);
    for k=2:Generation
        tic
        t=0;
        Parent=genes{k-1};%20
        Child1=Mate2023(Parent,3);%10
        Child2=Variate2023(Parent,0.1);%20
        genes{k}=Choose2023(Parent,Child1,Child2,day);
        t=t+toc;
        disp(t);
    end
    disp(day);
    Genes{day}=genes;
end
%str=strcat("Genes",num2str(int(rand*100)),".mat");
save("Genes.mat","Genes");
delete(P);

function Genes=GenerateParental2023(Population,EncodingLength,day)
    %遗传算法生成亲代种群
    %Population为种群大小,EncodingLength为染色体基因长度,Genes为种群染色体样本
    Genes=zeros(Population,EncodingLength);
    for p=1:Population
        Sequence=(rand(1,EncodingLength)<=0.7);  %生成个体基因序列
        [~,~,overflow]=SAforOrder(Sequence,day);
        while (overflow==1)%不能存活的个体
            Sequence=(rand(1,EncodingLength)<=0.7);  %生成个体基因序列
            [~,~,overflow]=SAforOrder(Sequence,day);
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
function superior=Choose2023(A,B,C,day)
    %遗传算法选择优秀基因型作为新的亲本
    %A,B,C分别为待选择的基因型
    Merge=[A;B;C];
    [Total,EncodingLength]=size(Merge);
    EncodingLength=EncodingLength;
    %[~,ind1]=sort(Merge,2);       %整合三个种群
    val=zeros(1,Total);
    for j=1:Total
        Sequence=Merge(j,:);
        chosen=nnz(Sequence);
        [~,tmp,~]=SAforOrder(Sequence,day);
        val(j)=tmp*(1/chosen);
    end
    [~,ind2]=sort(val,'descend');         %选择
    superior=Merge(ind2(1:Total/3),:); 
end