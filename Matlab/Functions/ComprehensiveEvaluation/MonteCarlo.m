function MonteCarlo(Space,num)
% 蒙特卡洛模拟：指标的标准差和信息熵成反比
% Space表示样本个数,num表示实验次数
result = zeros(num,2);  % 初始化用来保存信息熵和标准差的矩阵，横坐标表示信息熵，纵坐标表示标准差
for i = 1:num
    x = rand(Space,1);  % 随机生成n个位于区间[0,1]上面的样本 (随机数生成是视频第四讲的内容)
    p = x / sum(x);
    e = -sum(p .* mylog(p)) / log(Space); % 计算信息熵
    sd = std(x);  % 计算标准差(描述性统计是视频第五讲的内容)
    result(i,1) = e;
    result(i,2) = sd;
end
xlabel('信息熵')
ylabel('标准差')
[r,p] = corrcoef(result(:,1),result(:,2)); % 计算相关系数和对应的p值(相关系数是视频第五讲的内容)
end