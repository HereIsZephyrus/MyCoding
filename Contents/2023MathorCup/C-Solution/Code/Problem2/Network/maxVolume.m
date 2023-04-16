clc;clear;close all;
load Series.mat
maxPop=zeros(1,num);
maxPush=zeros(1,num);
n=length(Gragh);
ind_start=1;
while (ind_start<=n)%按日起算
    ind_end=During(ind_start,Date,n);
    tmpPop=zeros(1,num);
    tmpPush=zeros(1,num);
    for edge=ind_start:ind_end
        tmpPop(Gragh(edge,1))=tmpPop(Gragh(edge,1))+Volume(edge);
        tmpPush(Gragh(edge,2))=tmpPush(Gragh(edge,2))+Volume(edge);
    end
    for i=1:num
        maxPop(i)=max(maxPop(i),tmpPop(i));
        maxPush(i)=max(maxPush(i),tmpPush(i));
    end
    ind_start=ind_end+1;
    clear i edge
end
clear ind_start ind_end ans
save("maxVolume.mat",'maxPop','maxPush');
writetable(table(maxPop',maxPush'),"maxVolume.xlsx");

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