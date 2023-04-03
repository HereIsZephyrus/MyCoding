%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023ICM\Data\Volunteers.xlsx
%    工作表: Sheet1
%
% 由 MATLAB 于 2023-04-01 14:15:16 自动生成
clc;clear;

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 18);

% 指定工作表和范围
opts.Sheet = "Sheet1";
opts.DataRange = "C34:T48";

% 指定列名称和类型
opts.VariableNames = ["VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
Is_volunteered = readtable("C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023ICM\Data\Volunteers.xlsx", opts, "UseExcel", false);
%% 转换为输出类型
Is_volunteered = table2array(Is_volunteered);
Is_volunteered=Is_volunteered';
%% 清除临时变量
clear opts

%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023ICM\Data\Volunteers.xlsx
%    工作表: Sheet1
%
% 由 MATLAB 于 2023-04-01 14:15:59 自动生成

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 1);

% 指定工作表和范围
opts.Sheet = "Sheet1";
opts.DataRange = "B34:B48";

% 指定列名称和类型
opts.VariableNames = "VarName2";
opts.VariableTypes = "string";

% 指定变量属性
opts = setvaropts(opts, "VarName2", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "VarName2", "EmptyFieldRule", "auto");

% 导入数据
VolunteerList = readmatrix("C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023ICM\Data\Volunteers.xlsx", opts, "UseExcel", false);

%% 清除临时变量
clear opts

save VolunteerWinter.mat