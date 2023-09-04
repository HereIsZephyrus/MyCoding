clc;clear;close all;

checkData = readtable("PredictResult.csv");
GLU=checkData.GLU;
len=length(GLU);
indNormal=sort(intersect(find(GLU>=3.9),find(GLU<6.1)),'ascend');
glucoseNormal=GLU(indNormal);
indRisky=sort(intersect(find(GLU>=6.1),find(GLU<6.7)),'ascend');
glucoseRisky=GLU(indRisky);
indOther=setdiff([1:len]',[indRisky;indNormal]);
glucoseOther=GLU(indOther);
clear len GLU
save checkData_cate.mat