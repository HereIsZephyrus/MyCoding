%对每一届奥运会申办国家申办时的情况进行聚类分析
clc;clear;close all;
load WorldsDevelopmentWinter_Series.mat
load VolunteerWinter.mat
load VolunteeringWinter.mat
[year,num]=size(Is_volunteered);

%% 标准化
GDP_Grouth=zscore(GDP_Grouth);
GDP_Per_Grouth=zscore(GDP_Per_Grouth);
IMF_Grouth=zscore(IMF_Grouth);
Population_Grouth=zscore(Population_Grouth);
ArmForce_Grouth=zscore(ArmForce_Grouth);
Export_Grouth=zscore(Export_Grouth);
Happiness_Grouth=zscore(Happiness_Grouth);
Urbanlize_Grouth=zscore(Urbanlize_Grouth);

%Education_Series(isnan(Education_Series))=0;
for i=1:351
    GDP_Series(:,i)=GDP_Series(:,i)/max(GDP_Series(:,i));
    GDP_Per_Series(:,i)=GDP_Per_Series(:,i)/max(GDP_Per_Series(:,i));
    IMF_Series(:,i)=IMF_Series(:,i)/max(IMF_Series(:,i));
    Population_Series(:,i)=Population_Series(:,i)/max(Population_Series(:,i));
    ArmForce_Series(:,i)=ArmForce_Series(:,i)/max(ArmForce_Series(:,i));
    Export_Series(:,i)=Export_Series(:,i)/max(Export_Series(:,i));
    Happiness_Series(:,i)=Happiness_Series(:,i)/max(Happiness_Series(:,i));
    Urbanlize_Series(:,i)=Urbanlize_Series(:,i)/max(Urbanlize_Series(:,i));
    %Cov2{i}=cov(Education_Series(:,i),GDP_Series(:,i));
    %Cov{i}=Cov1{i}-Cov2{i};
end
clear i
Developments{1,2}=GDP_Series;
Developments{1,3}=GDP_Per_Series;
Developments{1,4}=IMF_Series;
Developments{1,5}=Population_Series;
Developments{1,6}=ArmForce_Series;
Developments{1,7}=Export_Series;
Developments{1,8}=Happiness_Series;
Developments{1,1}=Urbanlize_Series;
Developments{2,2}=GDP_Grouth;
Developments{2,3}=GDP_Per_Grouth;
Developments{2,4}=IMF_Grouth;
Developments{2,5}=Population_Grouth;
Developments{2,6}=ArmForce_Grouth;
Developments{2,7}=Export_Grouth;
Developments{2,8}=Happiness_Grouth;
Developments{2,1}=Urbanlize_Grouth;

%% 找出每一个时刻申报国的聚类结果
tmp_ClusteringList=cell(351,4);
ClusteringList=cell(351,4);
for i=1:351
    Goal{i}=zeros(num,8);
    for j=1:8
      Goal{i}(:,j)=Developments{1,j}(:,i);
    end
    [tmp_Identification(i,:),Fig{i}]=Clustering_2023ICM(Goal{i},'Ward',4,VolunteerList);
    for country=1:num
        tmp_ClusteringList{i,tmp_Identification(i,country)}(end+1)=country;
    end
    for cate=1:4
        tmp_Cluster(i,cate)=nnz(tmp_Identification(i,:)==cate);
    end
    ylabel(num2str((i-1)/5+1952));
    %pause
end
%% 改变聚类下标，下标越大则发展程度越高
%rank=zeros(size(tmp_Identification),'like',tmp_Identification);
for time=1:351
    rank=zeros(1,4);
    for cate=1:4
        for country=tmp_ClusteringList{time,cate}
           temp=zeros(1,16);
           for i=1:2
             for j=1:8
               temp((i-1)*8+j)=temp((i-1)*8+j)+Developments{i,j}(country,time);
             end
           end
           temp(isnan(temp))=[];
           temp=reshape(temp,1,length(temp));
           rank(cate)=rank(cate)+sum(zscore(temp))/length(temp)*1e10;
        end
    end
    rank=rank./tmp_Cluster(time,:);
    [ranked,ind]=sort(rank);
    for cate=1:4
        Identification(time,find(tmp_Identification(time,:)==cate))=ind(cate);
        ClusteringList{time,ind(cate)}=tmp_ClusteringList{time,cate};
    end
    for cate=1:4
        Cluster(time,cate)=nnz(Identification(time,:)==cate);
    end
end

clear time cate country
%% 找出每一届申办国的类型变化趋势与申办意愿的对应
% 统计每一届申办国申办时的国家社会经济状态
for Year=3:year
    Time=(Year-1)*4+1952;
    Location=(Time-1950)*5+1-9;%假设在举办的九年前开始申请
    State{Year,1}=Identification(Location,find(Is_volunteered(Year,:)));%申办的国家聚类
    State{Year,2}=VolunteerList(find(Is_volunteered(Year,:)));%申报国家的名单
    p=3;
    for countries=find(Is_volunteered(Year,:))
        temp=zeros(18,1);
        for i=1:2
            for j=1:8
                temp((i-1)*8+j+1)=Developments{i,j}(countries,Location);
            end
        end
        temp(isnan(temp))=[];
        State{Year,p}={VolunteerList(countries),temp};%国家+综合发展指数
        p=p+1;
    end
end

%%
% 统计每一届每一类的意愿度
p=1;
for time=1:10:351
    for cate=1:4
        temp=0;
        for k=ClusteringList{time,cate}
            temp=temp+Volunteering(k);
        end
        Volunteering_clustered(p,cate)=temp/Cluster(time,cate);
    end
    p=p+1;
end
figure(1);
axis([1,4,1950,2020]);
heatmap(1:4,linspace(1950,2020,p-1),Volunteering_clustered);
clear Year countries i j p Time Location
