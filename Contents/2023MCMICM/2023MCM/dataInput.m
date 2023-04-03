%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023_MCM_Problem_Y_Boats.xlsx
%    工作表: Monohulled Sailboats
%
% 由 MATLAB 于 2023-03-31 09:39:30 自动生成

%% 初始化导入表格
clear;clc;
n=2;
Monohulled=1;Catamarans=2;
Make=cell(1,n);
Variant = cell(1,n);
Lengthft =cell(1,n);
GeographicRegion = cell(1,n);
Region = cell(1,n);
ListingPriceUSD = cell(1,n);
Year = cell(1,n);

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 7);

% 指定工作表和范围
opts.Sheet = "Monohulled Sailboats ";
opts.DataRange = "A2:G2347";

% 指定列名称和类型
opts.VariableNames = ["Make", "Variant", "Lengthft", "GeographicRegion", "CountryRegionState", "ListingPriceUSD", "Year"];
opts.VariableTypes = ["categorical", "categorical", "double", "categorical", "categorical", "double", "double"];

% 指定变量属性
opts = setvaropts(opts, ["Make", "Variant", "GeographicRegion", "CountryRegionState"], "EmptyFieldRule", "auto");

% 导入数据
tbl = readtable("C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023_MCM_Problem_Y_Boats.xlsx", opts, "UseExcel", false);

%% 转换为输出类型
Make{Monohulled} = tbl.Make;
Variant{Monohulled} = tbl.Variant;
Lengthft{Monohulled} = tbl.Lengthft;
GeographicRegion{Monohulled} = tbl.GeographicRegion;
Region{Monohulled} = tbl.CountryRegionState;
ListingPriceUSD{Monohulled} = tbl.ListingPriceUSD;
Year{Monohulled} = tbl.Year;

%%
%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 7);

% 指定工作表和范围
opts.Sheet = "Catamarans";
opts.DataRange = "A2:G1146";

% 指定列名称和类型
opts.VariableNames = ["Make", "Variant", "Lengthft", "GeographicRegion", "CountryRegionState", "ListingPriceUSD", "Year"];
opts.VariableTypes = ["categorical", "string", "double", "categorical", "categorical", "double", "categorical"];

% 指定变量属性
opts = setvaropts(opts, "Variant", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Make", "Variant", "GeographicRegion", "CountryRegionState", "Year"], "EmptyFieldRule", "auto");

% 导入数据
tb2 = readtable("C:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023_MCM_Problem_Y_Boats.xlsx", opts, "UseExcel", false);

%% 转换为输出类型
Make{Catamarans} = tb2.Make;
Variant{Catamarans} = tb2.Variant;
Lengthft{Catamarans} = tb2.Lengthft;
GeographicRegion{Catamarans} = tb2.GeographicRegion;
Region{Catamarans} = tb2.CountryRegionState;
ListingPriceUSD{Catamarans} = tb2.ListingPriceUSD;
Year{Catamarans} = tb2.Year;

%% 清除临时变量
clear opts tb1 tb2


save data_origin.mat