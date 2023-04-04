%使用插值与指数平滑序列由离散化数据得到连续数据,并得到一个时期一类申办国的社会经济状态
clc;clear
load WorldsDevelopmentWinter.mat
%load VolunteerSummer.mat
load VolunteerWinter.mat
%Eeconimic,Landuse,Consumption,Sports
x=linspace(1950,2022,351);
%n=size(Identification,5);%Identification是历史上申办国在当时的分类结果
%m=size(WorldsDevelopment,5);%WorldsDevelopment为世界发展变化的指标
%WorldsDevelopment_Series=interp1(Years,WorldsDevelopment,x,'pchip');
num=length(VolunteerList);


%figure(2);
%hold on;
%% GDP
for i=1:num
    flag=1;
    temp_Year_GDP=unique(Year_GDP(i,:));
    if (temp_Year_GDP(1)==0)
        flag=2;
    end
    if length(GDP(i,GDP(i,:)>0))<1
        continue;
    end
    GDP_Series(i,:)=interp1(temp_Year_GDP(flag:end),GDP(i,GDP(i,:)>0),x,'pchip');
    %xx=x((temp_Year_GDP(flag)-1950)*5:end);
    %plot(xx,GDP_Series(i,(temp_Year_GDP(flag)-1950)*5:end),'.');
end
%xlabel("time");
%ylabel("GDP");
%legend(VolunteerList,'Location','eastoutside');
%}

%% GDPPP
for i=1:num
    flag=1;
    temp_Year_GDP_Per=unique(Year_GDP_Per(i,:));
    if (temp_Year_GDP_Per(1)==0)
        flag=2;
    end
    if length(GDP_Per(i,GDP_Per(i,:)>0))<1
        continue;
    end
    GDP_Per_Series(i,:)=interp1(temp_Year_GDP_Per(flag:end),GDP_Per(i,GDP_Per(i,:)>0),x,'pchip');
    %[predict,weight]=Adaptive_filtering(GDP_Per_Series(i,1:end-10),3,10);
    %for t=1:10
    %    GDP_Per_Series(i,end-10+t)=sum(weight.*(GDP_Per_Series(i,end-10+t-3:end-10+t-1)));
    %end
    %xx=x((temp_Year_GDP_Per(flag)-1950)*5:end);
    %plot(xx,GDP_Per_Series(i,(temp_Year_GDP_Per(flag)-1950)*5:end),'.-');
end
%xlabel("time");
%ylabel("GDP-PerPeople");
%legend(VolunteerList,'Location','eastoutside');
%}

%% IMF
for i=1:num
    flag=1;
    temp_Year_IMF=unique(Year_IMF(i,:));
    if (temp_Year_IMF(1)==0)
        flag=2;
    end
    if length(IMF(i,IMF(i,:)>0))<1
        continue;
    end
    IMF_Series(i,:)=interp1(temp_Year_IMF(flag:end),IMF(i,IMF(i,:)>0),x,'pchip');
    %%xx=x((temp_Year_IMF(flag)-1950)*5:60);
    %%plot(xx,IMF_Series(i,(temp_Year_IMF(flag)-1950)*5:60),'.-');
end
%%xlabel("time");
    %%ylabel("IMF");
    %%legend(VolunteerList,'Location','eastoutside');
%}

%% Population
for i=1:num
    flag=1;
    temp_Year_Population=unique(Year_Population(i,:));
    if (temp_Year_Population(1)==0)
        flag=2;
    end
    if length(Population(i,Population(i,:)>0))<1
        continue;
    end
    Population_Series(i,:)=interp1(temp_Year_Population(flag:end),Population(i,Population(i,:)>0),x,'pchip');
    %%xx=x((temp_Year_Population(flag)-1950)*5:end);
    %%plot(xx,Population_Series(i,(temp_Year_Population(flag)-1950)*5:end),'.');
    %PPP_Series=interp1(len_PPP,PPP_Series,x,'pchip');
end
%%xlabel("time");
    %%ylabel("Population");
    %%legend(VolunteerList,'Location','eastoutside');
%}

%% ArmForce
for i=1:num
    flag=1;
    temp_Year_ArmForce=unique(Year_ArmForce(i,:));
    if (temp_Year_ArmForce(1)==0)
        flag=2;
    end
    if length(ArmForce(i,ArmForce(i,:)>0))<1
        continue;
    end
    ArmForce_Series(i,:)=interp1(temp_Year_ArmForce(flag:end),ArmForce(i,ArmForce(i,:)>0),x,'pchip');
    %xx=x((temp_Year_ArmForce(flag)-1950)*5:end-20);
    %plot(xx,ArmForce_Series(i,(temp_Year_ArmForce(flag)-1950)*5:end-20),'.-');
end
%xlabel("time");
%ylabel("ArmForce");
%legend(VolunteerList,'Location','eastoutside');
%}
%% BuildUp
%{
for i=1:num
    flag=1;
    temp_Year_BuildUp=unique(Year_BuildUp(i,:));
    if (temp_Year_BuildUp(1)==0)
        flag=2;
    end
    if length(BuildUp(i,BuildUp(i,:)>0))<1
        continue;
    end
    BuildUp_Series(i,:)=interp1(temp_Year_BuildUp(flag:end),BuildUp(i,BuildUp(i,:)>0),x,'pchip');
    %xx=x((temp_Year_BuildUp(flag)-1950)*5:end);
    %plot(xx,BuildUp_Series(i,(temp_Year_BuildUp(flag)-1950)*5:end),'.');
end
%xlabel("time");
%ylabel("BuildUp");
%legend(VolunteerList,'Location','eastoutside');
%}
%}
%% Export
for i=1:num
    flag=1;
    temp_Year_Export=unique(Year_Export(i,:));
    if (temp_Year_Export(1)==0)
        flag=2;
    end
    if length(Export(i,Export(i,:)>0))<1
        continue;
    end
    Export_Series(i,:)=interp1(temp_Year_Export(flag:end),Export(i,Export(i,:)>0),x,'pchip');
    %xx=x((temp_Year_Export(flag)-1950)*5:end-25);
    %plot(xx,Export_Series(i,(temp_Year_Export(flag)-1950)*5:end-25),'.-');
end
%xlabel("time");
%ylabel("Export");
%legend(VolunteerList,'Location','eastoutside');
%}
%% Urbanlize
for i=1:num
    flag=1;
    temp_Year_Urbanlize=unique(Year_Urbanlize(i,:));
    if (temp_Year_Urbanlize(1)==0)
        flag=2;
    end
    if length(Urbanlize(i,Urbanlize(i,:)>0))<1
        continue;
    end
    Urbanlize_Series(i,:)=interp1(temp_Year_Urbanlize(flag:end),Urbanlize(i,Urbanlize(i,:)>0),x,'pchip');
    %xx=x((temp_Year_Urbanlize(flag)-1950)*5:end);
    %plot(xx,Urbanlize_Series(i,(temp_Year_Urbanlize(flag)-1950)*5:end),'.');
end
%xlabel("time");
%ylabel("Urbanlize");
%legend(VolunteerList,'Location','eastoutside');
%}
%% Happiness
for i=1:num
    flag=1;
    temp_Year_Happiness=unique(Year_Happyiness(i,:));
    if (temp_Year_Happiness(1)==0)
        flag=2;
    end
    if length(Happiness(i,Happiness(i,:)>0))<1
        continue;
    end
    Happiness_Series(i,:)=interp1(temp_Year_Happiness(flag:end),Happiness(i,Happiness(i,:)>0),x,'pchip');
    %xx=x((temp_Year_Happiness(flag)-1950)*5:end);
    %plot(xx,Happiness_Series(i,(temp_Year_Happiness(flag)-1950)*5:end),'.-');
end
%xlabel("time");
%ylabel("Happiness");
%legend(VolunteerList,'Location','eastoutside');
%}
%%
%hold off;

%%
GDP_Grouth=nan(size(GDP_Series),'like',GDP_Series);
GDP_Per_Grouth=nan(size(GDP_Per_Series),'like',GDP_Per_Series);
IMF_Grouth=nan(size(IMF_Series),'like',IMF_Series);
Population_Grouth=nan(size(Population_Series),'like',Population_Series);
ArmForce_Grouth=nan(size(ArmForce_Series),'like',ArmForce_Series);
Export_Grouth=nan(size(Export_Series),'like',Export_Series);
Urbanlize_Grouth=nan(size(Urbanlize_Series),'like',Urbanlize_Series);
Happiness_Grouth=nan(size(Happiness_Series),'like',Happiness_Series);

for countries=1:num
    for i=3:351
        if (isnan(GDP_Per_Series(countries,i)) || GDP_Per_Series(countries,i)==0)
            continue;
        end
        if (~isnan(GDP_Per_Series(countries,i-1)))
            GDP_Per_Grouth(countries,i)=(GDP_Per_Series(countries,i)-GDP_Per_Series(countries,i-1))/GDP_Per_Series(countries,i);
        else
            if (~isnan(GDP_Per_Series(countries,i-2)))
                GDP_Per_Grouth(countries,i)=(GDP_Per_Series(countries,i)-GDP_Per_Series(countries,i-2))/GDP_Per_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(GDP_Series(countries,i)) || GDP_Series(countries,i)==0)
            continue;
        end
        if (~isnan(GDP_Series(countries,i-1)))
            GDP_Grouth(countries,i)=(GDP_Series(countries,i)-GDP_Series(countries,i-1))/GDP_Series(countries,i);
        else
            if (~isnan(GDP_Series(countries,i-2)))
                GDP_Grouth(countries,i)=(GDP_Series(countries,i)-GDP_Series(countries,i-2))/GDP_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(IMF_Series(countries,i)) || IMF_Series(countries,i)==0)
            continue;
        end
        if (~isnan(IMF_Series(countries,i-1)))
            IMF_Grouth(countries,i)=(IMF_Series(countries,i)-IMF_Series(countries,i-1))/IMF_Series(countries,i);
        else
            if (~isnan(IMF_Series(countries,i-2)))
                IMF_Grouth(countries,i)=(IMF_Series(countries,i)-IMF_Series(countries,i-2))/IMF_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(Population_Series(countries,i)) || Population_Series(countries,i)==0)
            continue;
        end
        if (~isnan(Population_Series(countries,i-1)))
            Population_Grouth(countries,i)=(Population_Series(countries,i)-Population_Series(countries,i-1))/Population_Series(countries,i);
        else
            if (~isnan(Population_Series(countries,i-2)))
                Population_Grouth(countries,i)=(Population_Series(countries,i)-Population_Series(countries,i-2))/Population_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(ArmForce_Series(countries,i)) || ArmForce_Series(countries,i)==0)
            continue;
        end
        if (~isnan(ArmForce_Series(countries,i-1)))
            ArmForce_Grouth(countries,i)=(ArmForce_Series(countries,i)-ArmForce_Series(countries,i-1))/ArmForce_Series(countries,i);
        else
            if (~isnan(ArmForce_Series(countries,i-2)))
                ArmForce_Grouth(countries,i)=(ArmForce_Series(countries,i)-ArmForce_Series(countries,i-2))/ArmForce_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(Export_Series(countries,i)) || Export_Series(countries,i)==0)
            continue;
        end
        if (~isnan(Export_Series(countries,i-1)))
            Export_Grouth(countries,i)=(Export_Series(countries,i)-Export_Series(countries,i-1))/Export_Series(countries,i);
        else
            if (~isnan(Export_Series(countries,i-2)))
                Export_Grouth(countries,i)=(Export_Series(countries,i)-Export_Series(countries,i-2))/Export_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(Urbanlize_Series(countries,i)) || Urbanlize_Series(countries,i)==0)
            continue;
        end
        if (~isnan(Urbanlize_Series(countries,i-1)))
            Urbanlize_Grouth(countries,i)=(Urbanlize_Series(countries,i)-Urbanlize_Series(countries,i-1))/Urbanlize_Series(countries,i);
        else
            if (~isnan(Urbanlize_Series(countries,i-2)))
                Urbanlize_Grouth(countries,i)=(Urbanlize_Series(countries,i)-Urbanlize_Series(countries,i-2))/Urbanlize_Series(countries,i);
            else    
                continue;
            end
        end
    end
end
for countries=1:num
    for i=3:351
        if (isnan(Happiness_Series(countries,i)) || Happiness_Series(countries,i)==0)
            continue;
        end
        if (~isnan(Happiness_Series(countries,i-1)))
            Happiness_Grouth(countries,i)=(Happiness_Series(countries,i)-Happiness_Series(countries,i-1))/Happiness_Series(countries,i);
        else
            if (~isnan(Happiness_Series(countries,i-2)))
                Happiness_Grouth(countries,i)=(Happiness_Series(countries,i)-Happiness_Series(countries,i-2))/Happiness_Series(countries,i);
            else    
                continue;
            end
        end
    end
end