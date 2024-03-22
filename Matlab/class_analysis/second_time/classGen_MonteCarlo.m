clc;clear;close all;
load class_info.mat
round = 10000;
numclass1 = 75;
numclass2 = 34;

group_class1 = basic_info.group(1:numclass1);
group_class2 = basic_info.group(numclass1+1:109);
sex_class1 = basic_info.sex(1:numclass1);
sex_class2 = basic_info.sex(numclass1+1:109);
class_class1 = basic_info.class(1:numclass1);
xloc_class1 = X(1:numclass1,:);
xloc_class2 = X(numclass1+1:109,:);
yloc_class1 = Y(1:numclass1,:);
yloc_class2 = Y(numclass1+1:109,:);
load adj_class1.mat
RAWgroup_class1 = CalcGroupMeanDistance(dis,group_class1);
RAWsex_class1 = CalcSexMeanDistance(dis,sex_class1);
RAW_class = CalcClassMeanDistance(dis,class_class1);
load adj_class2.mat
RAWgroup_class2 = CalcGroupMeanDistance(dis,group_class2);
RAWsex_class2 = CalcSexMeanDistance(dis,sex_class2);
clear dis

MDgroup_class1 = zeros(round,21);
MDgroup_class2 = zeros(round,8);
MDsex_class1 = zeros(round,2);
MDsex_class2 = zeros(round,2);
MDcount_class1 = zeros(round,numclass1);
MDcount_class2 = zeros(round,numclass2);
MD_class = zeros(round,3);
parfor i = 1 : round
    classCounting = size(X,2);
    xcur_class1 = zeros(numclass1,classCounting);
    ycur_class1 = zeros(numclass1,classCounting);
    xcur_class2 = zeros(numclass2,classCounting);
    ycur_class2 = zeros(numclass2,classCounting);
    for times = 1 : classCounting
        perm_class1 = randperm(numclass1);
        perm_class2 = randperm(numclass2);
        xcur_class1(:,times) = xloc_class1(perm_class1,times);
        ycur_class1(:,times) = yloc_class1(perm_class1,times);
        xcur_class2(:,times) = xloc_class2(perm_class2,times);
        ycur_class2(:,times) = yloc_class2(perm_class2,times);
    end
    [disclass1,MDcount_class1(i,:)] = calc_dis(times,xcur_class1,ycur_class1);
    [disclass2,MDcount_class2(i,:)] = calc_dis(times,xcur_class2,ycur_class2);
    MDgroup_class1(i,:) = CalcGroupMeanDistance(disclass1,group_class1);
    MDgroup_class2(i,:) = CalcGroupMeanDistance(disclass2,group_class2);
    MDsex_class1(i,:) = CalcSexMeanDistance(disclass1,sex_class1);
    MDsex_class2(i,:) = CalcSexMeanDistance(disclass2,sex_class2);
    MD_class(i,:) = CalcClassMeanDistance(disclass1,class_class1);
end
save MonteCarloResult_bias.mat MDgroup_class1 MDgroup_class2 MDsex_class1 MDsex_class2 MD_class MDcount_class1 MDcount_class2 MD_class RAWgroup_class1 RAWsex_class2 RAWgroup_class2 RAW_class RAWsex_class1

function [dis,count] = calc_dis(times,x,y)
    num = length(x);
    adj = zeros(num);
    count = zeros(num,1);
    %roll_in = zeros(num,1);
    for i=1 : times
        [part_adj,part_count] = rook_count(x,y);
        adj = adj + part_adj;
        count = count + part_count;
        %roll_in = roll_in + (part_count>0);
    end
    %count = count./roll_in;
    count = count /7;
    vec = zeros(times-1,num,2);
    for i=1: times-1
        vec(i,:,1) = x(:,i+1) - x(:,i);
        vec(i,:,2) = y(:,i+1) - y(:,i);
    end
    trace = ones(num);
    for i=1 : num
        for j=1: num
            if (i == j)
                continue;
            end
            res = sd_vec(reshape(vec(:,i,:),times-1,2),reshape(vec(:,j,:),times-1,2),times-1);
            trace(i,j) = res;
            trace(j,i) = res;
        end
    end
    dis = adj./trace;
end

function [adj,count] = rook_count(x,y)
    len = length(x);
    for i = 1:len
        if y(i)>=9
            y(i) = y(i)+1;
        end
        if y(i)>=4
            y(i) = y(i)+1;
        end
    end
    clear i
    adj = zeros(len);
    count = zeros(len,1);
    for i = 1 : len
        cur_id = i;
        cur_y = y(i);
        cur_x = x(i);
        if (cur_x == 0)
            continue;
        end
        for j = 1 : len 
            if (y(j) == 0)
                continue;
            end
            adj_id = j;
            if (cur_x == x(j))&&(abs(y(j)-cur_y) == 1)
                adj(cur_id,adj_id) = 3;
                adj(adj_id,cur_id) = 3;
                count(cur_id) = count(cur_id)+3;
            end
            if (cur_x == x(j))&&(abs(y(j)-cur_y) == 2)
                adj(cur_id,adj_id) = 1;
                adj(adj_id,cur_id) = 1;
                count(cur_id) = count(cur_id)+1;
            end
            if (cur_y == y(j))&&(abs(cur_x-x(j)) == 1)
                adj(cur_id,adj_id) = 1;
                adj(adj_id,cur_id) = 1;
                count(cur_id) = count(cur_id)+1;
            end
        end
        clear j
    end
    clear i
end

function res = sd_vec(trace_a,trace_b,n)
    d_trace = trace_a - trace_b;
    sqr_d_trace = d_trace .* d_trace;
    dis = sqrt(sqr_d_trace(:,1) + sqr_d_trace(:,2));
    res = sum(dis)/n;
end