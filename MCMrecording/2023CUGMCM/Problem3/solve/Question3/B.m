clc;close all;clear
data=xlsread('摩擦力.xlsx');
soga=readtable('摩擦力.xlsx');
time=soga(:,1);
beta_diff1 = diff(data(:, 3));
data2=xlsread('第二段摩擦力.xlsx');
beta_diff2=diff(data2(:,3));
