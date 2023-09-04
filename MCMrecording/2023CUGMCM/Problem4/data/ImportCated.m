clc;clear;close all;
opts = delimitedTextImportOptions("NumVariables", 42);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["GGT", "ALT", "ACT", "TP", "GLB", "ALP", "ID", "GRA", "K_Be", "HBeAg", "K_HBc", "K_HBs", "HBsAg", "LDL_C", "Date", "MO", "BAS", "EOS", "USG", "UA", "Age", "Sex", "TCHO", "LYM", "TG", "AG", "EBC", "ALB", "RDW", "HCT", "MCV", "MCHC", "MCH", "RBC", "CR", "PDW", "MPV", "PCT", "PLT", "GLU", "HGB", "HDL_C"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Sex", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "dd/MM/yyyy");

% Import the data
rawCatedData = readtable("附件1—有血糖值的检测数据.csv", opts);

clear opts
save rawCatedData.mat