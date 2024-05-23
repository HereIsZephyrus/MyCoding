clc;clear;close all;
load cleaned-data.mat
load aveData.mat
H.prep = calcH(data.prep);
H.supply = calcH(data.supply);
H.resource = calcH(data.resource);
H.contain = calcH(containAve);
H.consume = calcH(consumeAve);

function H = calcH(data)
    H = 0;
    sp = 50;
    [val,edge] = histcounts(data,sp);
    tot = sum(val);
    for i = 1: length(sp)
        p = val(i)/tot;
        H = H +  (-p) * log2(p);
    end
end
