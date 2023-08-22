clc;clear;close all;
%% 导入标记数据
opts = spreadsheetImportOptions("NumVariables", 15);
opts.Sheet = "Sheet1";
opts.DataRange = "A2:O391";
opts.VariableNames = ["ID", "motherAge", "Marriage", "Education", "Time", "Method", "CBTS", "EPDS", "HADS", "Behavior", "Sex", "babyAge", "Sleeping", "Awake", "Asleep"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "char", "double", "double", "datetime", "double", "double"];
cateData = readtable("2023暑期培训第一轮模拟题A题附件.xlsx", opts, "UseExcel", false);
clear opts
marriage=cateData.Marriage;
ind=find(marriage<=2);
cateData=cateData(ind,:);
clear ind marriage
tmpBehavior=cateData.Behavior;
len=length(tmpBehavior);
tmpValue=zeros(len,1);
for i=1:len
    if (tmpBehavior{i}(1)=='安')
        tmpValue(i)=1;
    end
    if (tmpBehavior{i}(1)=='中')
        tmpValue(i)=0;
    end
    if (tmpBehavior{i}(1)=='矛')
        tmpValue(i)=-1;
    end
end
clear i
cateData.Behavior=tmpValue;
clear tmpValue tmpBehavior
tmpSleeping=cateData.Sleeping;
tmpChar=char(tmpSleeping);
tmpChar=tmpChar(:,13:16);
tmpValue=zeros(len,1);
for i=1:len
    tmpValue(i)=str2double(tmpChar(i,1:2));
    if (tmpChar(i,4)=='3')
        tmpValue(i)=tmpValue(i)+0.5;
    end
end
clear i
cateData.Sleeping=tmpValue;
sleep=cateData.Sleeping;
ind=find(sleep<20);
len=length(ind);
cateData=cateData(ind,:);
clear ind sleep
clear tmpSleeping tmpChar tmpValue

%% 导入未标记数据
opts = spreadsheetImportOptions("NumVariables", 12);
opts.Sheet = "Sheet1";
opts.DataRange = "A392:L411";
opts.VariableNames = ["ID", "motherAge", "Marriage", "Education", "Time", "Method", "CBTS", "EPDS", "HADS", "Behavior", "Sex", "babyAge"];
opts.SelectedVariableNames=["ID", "motherAge", "Marriage", "Education", "Time", "Method", "CBTS", "EPDS", "HADS",  "Sex", "babyAge"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double","double",];
preData = readtable("2023暑期培训第一轮模拟题A题附件.xlsx", opts, "UseExcel", false);

%% 收尾
clear opts
save rawData.mat
