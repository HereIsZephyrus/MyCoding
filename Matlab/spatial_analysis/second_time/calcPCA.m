clc;clear;close all
load totalvar.mat
score = cell(1,6); num = zeros(1,6); rate = cell(1,6);
for i = 1:6
    [score{i},rate{i},num(i)] = calc(D{i});
end

function [score,rate,num]=calc(Matrix)
    Correspond=corrcoef(Matrix);    
    [vec1,latent,rate]=pcacov(Correspond);  
    f=repmat(sign(sum(vec1)),size(vec1,1),1); 
    vec2=vec1.*f;   
    num = max(find(latent>1));
    score=Matrix*vec2(:,1:num);        
end