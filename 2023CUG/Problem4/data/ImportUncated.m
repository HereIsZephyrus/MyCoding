clc;clear;close all;
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 41);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["ID", "Sex", "Age", "Date", "ACT", "ALT", "ALP", "GGT", "TP", "ALB", "GLB", "AG", "TG", "TC", "HDL_C", "LDL_C", "USG", "CR", "UA", "HBsAg", "K_HBs", "HBeAg", "K_Be", "K_HBc", "EBC", "RBC", "HCT", "HGB", "MCV", "MCH", "MCHC", "RDW", "PLT", "MPV", "PDW", "PCT", "GRA", "LYM", "MO", "EOS", "BAS"];
opts.VariableTypes = ["double", "double", "double", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy");

% Import the data
rawUncatedData = readtable("附件2—无血糖值的检测数据.csv", opts);


%% Clear temporary variables
clear opts

save rawUncatedData.mat