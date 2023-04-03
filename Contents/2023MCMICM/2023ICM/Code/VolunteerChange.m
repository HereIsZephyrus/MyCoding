clc;clear;
%使用指数平滑研究不同聚类国家申报意愿的变化
load VolunteerWinter.mat
[years,num]=size(Is_volunteered);%Volunteers申办国家列表cell数组
Volunteering=zeros(years,num);

Volunteering(1,:)=Is_volunteered(1,:);
for j=1:num
    Volunteering(2,j)=0;
    for k=-1:2
        Volunteering(2,j)=Volunteering(2,j)+(3-abs(k))*(3-abs(k))*Is_volunteered(2+k,j);
    end
    Volunteering(2,j)=sqrt(Volunteering(2,j))/5;
end
for i=3:years-2
    for j=1:num
        Volunteering(i,j)=0;
        for k=-2:2
            Volunteering(i,j)=Volunteering(i,j)+(3-abs(k))*(3-abs(k))*Is_volunteered(i+k,j);
        end
        Volunteering(i,j)=sqrt(Volunteering(i,j))/5;
    end
end
for j=1:num
    Volunteering(years-1,j)=0;
    for k=-2:1
        Volunteering(years-1,j)=Volunteering(years-1,j)+(3-abs(k))*(3-abs(k))*Is_volunteered(years-1+k,j);
    end
    Volunteering(years-1,j)=sqrt(Volunteering(years-1,j))/5;
end
Volunteering(years,:)=Is_volunteered(years,:)*0.8;
%{
for i=3:years
    for j=1:num
        Volunteering_clustered(i,dentification(j))=Volunteering_clustered(i,Identification(j))+Volunteering(i,j);
    end
end
for i=1:3
    Volunteering_clustered(:,i)=Volunteering_clustered(:,i)/length(ClusteringList{Identification(i)});
end
%}

figure(1);
Countries=VolunteerList(1:num);
Time=1952:4:2020;
%tbl = table(Countries;Volunteering);
%heatmap(tbl,'Countries','Time','Volunteering');
T=['Summer';Countries];
Output=table([T';Time',Volunteering]);
heatmap(Countries,Time,Volunteering);

filename = 'VolunteersWinter.xlsx';
writetable(Output,filename,'Sheet',1,'Range','B1');
%title('Change in willingness to host by country over time');
 
%{
[X,Y]=meshgrid(1952:4:2020,1:num);
meshgrid(X,Y);
Z=Volunteering';
C=X.*Y;
surf(Y,X,Z,C);
xticklabels(VolunteerList(1:num));
xx=xlabel('Countries');
yy=ylabel('Time');
zz=zlabel('Willingness');
set(xx,'Rotation',20);  
set(yy,'Rotation',-20);   
%}

clear num years i j k Is_volunteered Volunteers 
clear Output T Time filename Countries ans
save VolunteeringWinter.mat