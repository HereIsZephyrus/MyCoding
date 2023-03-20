%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%    工作簿: C:\Users\Administrator\GitHub\MyCoding\Matlab\PhysicalExperience\试验四太阳电池特性\太阳能电池.xlsx
%    工作表: Matlab数据源

%% 导入电流
opts = spreadsheetImportOptions("NumVariables", 18);

% 指定工作表和范围
opts.Sheet = "Matlab数据源";
opts.DataRange = "A26:R40";

% 指定列名称和类型
opts.VariableNames = ["Var1", "Var2", "VarName3", "Var4", "Var5", "Var6", "Var7", "VarName8", "Var9", "Var10", "Var11", "Var12", "VarName13", "Var14", "Var15", "Var16", "Var17", "VarName18"];
opts.SelectedVariableNames = ["VarName3", "VarName8", "VarName13", "VarName18"];
opts.VariableTypes = ["char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double"];

% 指定变量属性
opts = setvaropts(opts, ["Var1", "Var2", "Var4", "Var5", "Var6", "Var7", "Var9", "Var10", "Var11", "Var12", "Var14", "Var15", "Var16", "Var17"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var4", "Var5", "Var6", "Var7", "Var9", "Var10", "Var11", "Var12", "Var14", "Var15", "Var16", "Var17"], "EmptyFieldRule", "auto");

% 导入数据
I = readtable("C:\Users\Administrator\GitHub\MyCoding\Matlab\PhysicalExperience\试验四太阳电池特性\太阳能电池.xlsx", opts, "UseExcel", false);

% 转换为输出类型
I = table2array(I);
I=I';
% 清除临时变量
clear opts

%% 导入电压
opts = spreadsheetImportOptions("NumVariables", 19);

% 指定工作表和范围
opts.Sheet = "Matlab数据源";
opts.DataRange = "A26:S40";

% 指定列名称和类型
opts.VariableNames = ["Var1", "Var2", "Var3", "VarName4", "Var5", "Var6", "Var7", "Var8", "VarName9", "Var10", "Var11", "Var12", "Var13", "VarName14", "Var15", "Var16", "Var17", "Var18", "VarName19"];
opts.SelectedVariableNames = ["VarName4", "VarName9", "VarName14", "VarName19"];
opts.VariableTypes = ["char", "char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double"];

% 指定变量属性
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var5", "Var6", "Var7", "Var8", "Var10", "Var11", "Var12", "Var13", "Var15", "Var16", "Var17", "Var18"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var5", "Var6", "Var7", "Var8", "Var10", "Var11", "Var12", "Var13", "Var15", "Var16", "Var17", "Var18"], "EmptyFieldRule", "auto");

% 导入数据
U = readtable("C:\Users\Administrator\GitHub\MyCoding\Matlab\PhysicalExperience\试验四太阳电池特性\太阳能电池.xlsx", opts, "UseExcel", false);

% 转换为输出类型
U = table2array(U);
U=U';
% 清除临时变量
clear opts

%% 导出相关量
R=1000*U./I;
Is=[45,35,25,15]';
U0=[2.05,2.01,1.99,1.92]';
P=U.*I;
%% 导出数据至mat
save BatteryData.mat