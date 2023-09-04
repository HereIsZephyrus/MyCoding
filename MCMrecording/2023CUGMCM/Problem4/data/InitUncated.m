clc;clear;close all;
load rawUncatedData.mat
rawUncatedData_copy=rawUncatedData;
rawUncatedData_copy.ID=[];
rawUncatedData_copy.Date=[];
%% 将乙肝患者的样本分离开
K_Be=rawUncatedData_copy.K_Be;
HBVind=find(~isnan(K_Be));
HBVData=rawUncatedData_copy(HBVind,:);
save HBVUncatedData.mat HBVData HBVind
rawUncatedData_copy=rawUncatedData_copy(find(isnan(K_Be)),:);
%%
[len,rawVar]=size(rawUncatedData_copy);
indValued=[];
countNan=zeros(1,rawVar);
for i=1:rawVar
    tmp=table2array(rawUncatedData_copy(:,i));
    countNan(i)=sum(isnan(tmp));
    indNan=find(isnan(tmp));
    rawUncatedData_copy(indNan,i)=array2table(mean(rmmissing(tmp)));
    if (countNan(i)<(len/2))
        indValued=[indValued,i];
    end
end
clear i indNan
uncatedData=rawUncatedData_copy(:,indValued);
countNan=countNan(indValued);
clear indValued tmp
[countNan,ind]=sort(countNan,'ascend');
uncatedData=uncatedData(:,ind);
clear ind rawVar
%%
save uncatedData.mat uncatedData countNan
