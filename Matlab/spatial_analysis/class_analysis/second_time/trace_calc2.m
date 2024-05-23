clc;clear; close all;
load trace_class2.mat

[times,len,~] = size(vec);
trace = ones(len);
for i=1 : len
    for j=1: len
        if (i == j)
            continue;
        end
        res = sd_vec(reshape(vec(:,i,:),times,2),reshape(vec(:,j,:),times,2),times);
        trace(i,j) = res;
        trace(j,i) = res;
    end
end
dis = adj./trace;
save adj_class2.mat dis
writematrix(dis,"adj_class2.csv");

function res = sd_vec(trace_a,trace_b,n)
    d_trace = trace_a - trace_b;
    sqr_d_trace = d_trace .* d_trace;
    dis = sqrt(sqr_d_trace(:,1) + sqr_d_trace(:,2));
    res = sum(dis)/n;
end
