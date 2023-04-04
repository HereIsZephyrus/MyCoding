clc;clear;
load GDP.mat
load VolunteeringWinter.mat
load DevelopmentScale.mat

num=length(VolunteerList);
%{
VolunteerList(1)="United States";
VolunteerList(10)="United Kingdom";
VolunteerList(18)="South Korea";
VolunteerList(23)="Russia";
%}

Population=zeros(num,70);
PPP=zeros(num,70);
GDP_Per=zeros(num,70);
IMF=zeros(num,70);
GDP=zeros(num,70);
SocialProtection=zeros(num,70);
GovenmentSpending=zeros(num,70);
EducationSpending=zeros(num,70);
ArmForce=zeros(num,70);
GovernProcurement=zeros(num,70);
Happiness=zeros(num,70);
BuildUp=zeros(num,70);
Export=zeros(num,70);
Urbanlize=zeros(num,70);

%% countrylevelgovernmentspendingvsincome
times=find(countrylevelgovernmentspendingvsincome.Year>=1952);
for i=1:num
    Index{i}=find(countrylevelgovernmentspendingvsincome.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        Population(countries,countrylevelgovernmentspendingvsincome.Year(ind)-1951)=countrylevelgovernmentspendingvsincome.PopulationhistoricalEstimates(ind);
        PPP(countries,countrylevelgovernmentspendingvsincome.Year(ind)-1951)=countrylevelgovernmentspendingvsincome.GDPPerCapitaPPPconstant2017International(ind);
    end
    p=1;
    for i=1:70
        if (Population(countries,i)>0)
            Year_Population(countries,p)=1951+i;
            p=p+1;
        end
    end
end

%% gdppercapitagrowth
clear Index times
times=find(gdppercapitagrowth.Year>=1952);
for i=1:num
    Index{i}=find(gdppercapitagrowth.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        GDP_Per(countries,gdppercapitagrowth.Year(ind)-1951)=gdppercapitagrowth.GDPPerCapitaGrowthannual(ind);
    end
    p=1;
    for i=1:70
        if (GDP_Per(countries,i)>0)
            Year_GDP_Per(countries,p)=1951+i;
            p=p+1;
        end
    end
end

%% historicalgovspendinggdp
clear Index times
times=find(historicalgovspendinggdp.Year>=1952);
for i=1:num
    Index{i}=find(historicalgovspendinggdp.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        IMF(countries,historicalgovspendinggdp.Year(ind)-1951)=historicalgovspendinggdp.GovernmentExpenditureIMFBasedOnMauroEtAl2015(ind);
    end
    p=1;
    for i=1:70
        if (IMF(countries,i)>0)
            Year_IMF(countries,p)=1951+i;
            p=p+1;
        end
    end
end

%% nationalgdp
clear Index times
times=find(nationalgdp.Year>=1952);
for i=1:num
    Index{i}=find(nationalgdp.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end
%Year_GDP=Year_GDP';

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        GDP(countries,nationalgdp.Year(ind)-1951)=nationalgdp.GDPoutputMultiplePriceBenchmarks(ind);
    end
    p=1;
    for i=1:70
        if (GDP(countries,i)>0)
            Year_GDP(countries,p)=1951+i;
            p=p+1;
        end
    end
end

%% sharesocialprotectioningovernmentexpoecd2013
%{
clear Index times
times=find(sharesocialprotectioningovernmentexpoecd2013.Year>=1952);
for i=1:num
    Index{i}=find(sharesocialprotectioningovernmentexpoecd2013.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
     len_SocialProtection(i)=length(Index{i});
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        SocialProtection(countries,sharesocialprotectioningovernmentexpoecd2013.Year(ind))=sharesocialprotectioningovernmentexpoecd2013.ShareOfSocialProtectionInGovernmentExpenditureOECD2017(ind);
    end
end
%}

%% totalgovexpenditurepercapitaOECD
%{
clear Index times
times=find(totalgovexpenditurepercapitaOECD.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(totalgovexpenditurepercapitaOECD.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
    len_GovernmentSpending(i)=length(Index{i});
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        GovernmentSpending(countries,totalgovexpenditurepercapitaOECD.Year(ind)-1951)=totalgovexpenditurepercapitaOECD.TotalGovernmentSpendingPerCapita(ind);
    end
end
%}

%% shareofeducationingovernmentexpenditure

clear Index times
times=find(shareofeducationingovernmentexpenditure.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(shareofeducationingovernmentexpenditure.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        EducationSpending(countries,shareofeducationingovernmentexpenditure.Year(ind)-1951)=shareofeducationingovernmentexpenditure.GovernmentExpenditureOnEducationTotalOfGovernmentExpenditure(ind);
    end
    p=1;
    for i=1:70
        if (EducationSpending(countries,i)>0)
            Year_Education(countries,p)=1951+i;
            p=p+1;
        end
    end
end
%% armedforcespersonnelpercent

clear Index times
times=find(armedforcespersonnelpercent.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(armedforcespersonnelpercent.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        ArmForce(countries,armedforcespersonnelpercent.Year(ind)-1951)=armedforcespersonnelpercent.armed_forces_share_population(ind);
    end
    p=1;
    for i=1:70
        if (ArmForce(countries,i)>0)
            Year_ArmForce(countries,p)=1951+i;
            p=p+1;
        end
    end
end
%% governmentprocurementsharegdp
clear Index timesrmForce
times=find(governmentprocurementsharegdp.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(governmentprocurementsharegdp.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        GovernProcurement(countries,governmentprocurementsharegdp.Year(ind)-1951)=governmentprocurementsharegdp.GeneralGovernmentProcurementExpenditureOfGDP(ind);
    end
    p=1;
    for i=1:70
        if (GovernProcurement(countries,i)>0)
            Year_Procurement(countries,p)=1951+i;
            p=p+1;
        end
    end
end
%% happinesscantrilladder
clear Index times
times=find(happinesscantrilladder.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(happinesscantrilladder.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        Happiness(countries,happinesscantrilladder.Year(ind)-1951)=happinesscantrilladder.CantrilLadderScore(ind);
    end
    p=1;
    for i=1:70
        if (Happiness(countries,i)>0)
            Year_Happyiness(countries,p)=1951+i;
            p=p+1;
        end
    end
end

%% landuseoverthelongterm
clear Index times
times=find(landuseoverthelongterm.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(landuseoverthelongterm.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        BuildUp(countries,landuseoverthelongterm.Year(ind)-1951)=landuseoverthelongterm.BuiltupAreaHYDE2017(ind);
    end
    p=1;
    for i=1:70
        if (BuildUp(countries,i)>0)
            Year_BuildUp(countries,p)=1951+i;
            p=p+1;
        end
    end
end

%% merchandiseexportsgdpcepii
clear Index times
times=find(merchandiseexportsgdpcepii.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(merchandiseexportsgdpcepii.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        Export(countries,merchandiseexportsgdpcepii.Year(ind)-1951)=merchandiseexportsgdpcepii.ValueOfGlobalMerchandiseExportsAsAShareOfGDPFouquinAndHugotCEPI(ind);
    end
    p=1;
    for i=1:70
        if (Export(countries,i)>0)
            Year_Export(countries,p)=1951+i;
            p=p+1;
        end
    end
end
%% urbanandruralpopulation
clear Index times
times=find(urbanandruralpopulation.Year>=1952);
%len_GovernmentSpending=zeros(1,num);
for i=1:num
    Index{i}=find(urbanandruralpopulation.Entity==VolunteerList(i));
    Index{i}=intersect(Index{i},times)';
end

for countries=1:num
    for i=1:length(Index{countries})
        ind=Index{countries}(i);
        Urbanlize(countries,urbanandruralpopulation.Year(ind)-1951)=urbanandruralpopulation.UrbanPopulation(ind)/(urbanandruralpopulation.UrbanPopulation(ind)+urbanandruralpopulation.RuralPopulation(ind));
    end
    p=1;
    for i=1:70
        if (Urbanlize(countries,i)>0)
            Year_Urbanlize(countries,p)=1951+i;
            p=p+1;
        end
    end
end
