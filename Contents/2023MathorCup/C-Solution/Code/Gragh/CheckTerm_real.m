clc;clear;
load Gragh_Contain.mat
Matrix=Matrix_Contain;
for i=1:num
    Matrix(i,i)=0;
end
num_start=0;
for i=1:num
    if (any(Matrix(i,:))==0)
        num_start=num_start+1;
        ind_start(1,num_start)=i;
    end
end
clear i
num_end=0;
for i=1:num
    if (any(Matrix(:,i))==0)
        num_end=num_end+1;
        ind_end(1,num_end)=i;
    end
end
clear i
clear Matrix