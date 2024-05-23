clc;clear;close all;
times = 7;
num = 34;
adj = zeros(num);
count = zeros(num,1);
roll_in = zeros(num,1);
for i=1 :times
    [part_adj,part_count] = rook_count(i);
    adj = adj + part_adj;
    count = count + part_count;
    roll_in = roll_in + (part_count>0);
    clear j
    writematrix(part_adj,'adj_class2.xlsx',Sheet=i);
    writematrix(part_count,'count_class2.xlsx',Sheet=i);
end
writematrix(adj,'adj_class2.xlsx',Sheet=8);
writematrix(count./roll_in,'count_class2.xlsx',Sheet=8);
clear i

vec = zeros(times-1,num,2);
var_vec = zeros(num,2);
mean_vec = zeros(num,2);
for i=1: times-1
    [vec_x,vec_y] = calc_vec(i);
    vec(i,:,1) = vec_x;
    vec(i,:,2) = vec_y;
    var_vec(:,1) = var_vec(:,1)+vec_x.*vec_x;
    var_vec(:,2) = var_vec(:,2)+vec_y.*vec_y;
    mean_vec(:,1) = mean_vec(:,1)+vec_x;
    mean_vec(:,2) = mean_vec(:,2)+vec_y;
end
clear i
writematrix(var_vec./roll_in,'vec_class2.csv');
writematrix(mean_vec./roll_in,'mean_class2.csv');
save trace_class2.mat vec adj count

function [adj,count] = rook_count(index)
    load class_info.mat X Y basic_info
    num = 34;
    x = X(109-num+1:109,index);
    y = Y(109-num+1:109,index);
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
        cur_id = basic_info.ID(i);
        cur_y = y(i);
        cur_x = x(i);
        if (cur_x == 0)
            continue;
        end
        for j = 1 : len 
            if (y(j) == 0)
                continue;
            end
            adj_id = basic_info.ID(j);
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

function [x,y] = calc_vec(index)
    load class_info.mat X Y
    num = 34;
    x = X(109-num+1:109,index+1) - X(1:num,index);
    y = Y(109-num+1:109,index+1) - Y(1:num,index);
end