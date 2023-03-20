%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%    ������: C:\Users\Administrator\GitHub\MyCoding\Matlab\PhysicalExperience\������̫���������\̫���ܵ��.xlsx
%    ������: Matlab����Դ

%% �������
opts = spreadsheetImportOptions("NumVariables", 18);

% ָ��������ͷ�Χ
opts.Sheet = "Matlab����Դ";
opts.DataRange = "A26:R40";

% ָ�������ƺ�����
opts.VariableNames = ["Var1", "Var2", "VarName3", "Var4", "Var5", "Var6", "Var7", "VarName8", "Var9", "Var10", "Var11", "Var12", "VarName13", "Var14", "Var15", "Var16", "Var17", "VarName18"];
opts.SelectedVariableNames = ["VarName3", "VarName8", "VarName13", "VarName18"];
opts.VariableTypes = ["char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double"];

% ָ����������
opts = setvaropts(opts, ["Var1", "Var2", "Var4", "Var5", "Var6", "Var7", "Var9", "Var10", "Var11", "Var12", "Var14", "Var15", "Var16", "Var17"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var4", "Var5", "Var6", "Var7", "Var9", "Var10", "Var11", "Var12", "Var14", "Var15", "Var16", "Var17"], "EmptyFieldRule", "auto");

% ��������
I = readtable("C:\Users\Administrator\GitHub\MyCoding\Matlab\PhysicalExperience\������̫���������\̫���ܵ��.xlsx", opts, "UseExcel", false);

% ת��Ϊ�������
I = table2array(I);
I=I';
% �����ʱ����
clear opts

%% �����ѹ
opts = spreadsheetImportOptions("NumVariables", 19);

% ָ��������ͷ�Χ
opts.Sheet = "Matlab����Դ";
opts.DataRange = "A26:S40";

% ָ�������ƺ�����
opts.VariableNames = ["Var1", "Var2", "Var3", "VarName4", "Var5", "Var6", "Var7", "Var8", "VarName9", "Var10", "Var11", "Var12", "Var13", "VarName14", "Var15", "Var16", "Var17", "Var18", "VarName19"];
opts.SelectedVariableNames = ["VarName4", "VarName9", "VarName14", "VarName19"];
opts.VariableTypes = ["char", "char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double", "char", "char", "char", "char", "double"];

% ָ����������
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var5", "Var6", "Var7", "Var8", "Var10", "Var11", "Var12", "Var13", "Var15", "Var16", "Var17", "Var18"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var5", "Var6", "Var7", "Var8", "Var10", "Var11", "Var12", "Var13", "Var15", "Var16", "Var17", "Var18"], "EmptyFieldRule", "auto");

% ��������
U = readtable("C:\Users\Administrator\GitHub\MyCoding\Matlab\PhysicalExperience\������̫���������\̫���ܵ��.xlsx", opts, "UseExcel", false);

% ת��Ϊ�������
U = table2array(U);
U=U';
% �����ʱ����
clear opts

%% ���������
R=1000*U./I;
Is=[45,35,25,15]';
U0=[2.05,2.01,1.99,1.92]';
P=U.*I;
%% ����������mat
save BatteryData.mat