clc;clear;close all;
load catedData.mat
load catedCorrcoef.mat
glucose=normalize(glucose,'range');
num=size(catedData,2);
seq=normalize(seq,'range');
SignificantSeq=normalize(significantSeq,'range');
UnsignificantSeq=normalize(unsignificantSeq,'range');
for i=5:num
    catedData(:,i)=normalize(catedData(:,i),'range');
end
catedData.GLU=normalize(catedData.GLU,'range');
clear i num
save normalizeCatedData.mat