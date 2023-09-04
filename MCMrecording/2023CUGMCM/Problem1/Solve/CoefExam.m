clc;clear;close all;
load scoreData.mat
load sleepData.mat
physical=[cateData.motherAge,cateData.Marriage,cateData.Education,cateData.Time,cateData.Method];
psychosocial=[cateData.CBTS,cateData.EPDS,cateData.HADS];
basic=[physical,psychosocial];
goal=[cateData.Behavior,cateData.Sleeping,cateData.Awake,cateData.Asleep];
sleepGoal=[scoreSleep,cateData.Sleeping,cateData.Awake,cateData.Asleep];
[R,P,RL,RU] = corrcoef([basic,goal],'Alpha',0.05);
save arrayData.mat