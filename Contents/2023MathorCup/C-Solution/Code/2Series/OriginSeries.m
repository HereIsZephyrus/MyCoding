load Gragh_Connect.mat
n=length(Gragh);
Time_var=zeros(num_connect,365*2);
Time_start=zeros(num_connect,1);
Time_end=zeros(num_connect,1);
Time_total=zeros(num_connect,1);
ind =0;
Calced=zeros(num);
for i=1:n
    if (Matrix_Connect(Gragh(i,1),Gragh(i,2))>0)
        if (Calced(Gragh(i,1),Gragh(i,2))==0)
            ind=ind+1;
            Calced(Gragh(i,1),Gragh(i,2))=ind;
            Time_start(ind)=Gragh(i,1);
            Time_end(ind)=Gragh(i,2);
        end
    end
end
clear i ind j
for i=1:n
    if (Matrix_Connect(Gragh(i,1),Gragh(i,2))>0)
        dates=days(Date(i)-Date(1))+1;
        ind=Calced(Gragh(i,1),Gragh(i,2));
        Time_var(ind,dates)=Volume(i);
        Time_total(ind)=Time_total(ind)+Volume(i);
    end
end
Index=[1:num_connect]';
tbl=table(Index,Time_total,Time_start,Time_end,Time_var);
tbl = sortrows(tbl,2,'descend');
writetable(tbl,'series.xlsx');
clear i dates ind Index
clear ans n Calced
clear tbl