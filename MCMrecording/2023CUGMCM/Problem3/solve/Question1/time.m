clc; close all;clear
data = readtable('路段1.xlsx');

time1 = datetime(data.Var4,'Format','HH:mm:ss');
minutesData1 = minute(time1);
secondsData1 = second(time1);
modifiedTime1 = time1;
for i = 1:length(time1)
    if abs(secondsData1(i) - 59) < 1e-5 &&  abs(secondsData1(i)) > 59
        % 当前数据的秒数接近59秒时，将分钟加1，秒数重置为0
        modifiedTime1(i) = modifiedTime1(i) + minutes(1) - seconds(modifiedTime1(i));
    end
end
for i = 1:length(time1)
    if abs(secondsData1(i)) > 50
        % 当前数据的秒数大于59时，将分钟加1
       minutesData1(i) = minutesData1(i) + 1;
       secondsData1(i) = 0;

    end
    if abs(secondsData1(i)) < 30
        minutesData1(i) = minutesData1(i);
        secondsData1(i) = 0;
    end

end
%%

unique_values = unique(minutesData1(1:end));
counts = histc(minutesData1, unique_values);
seconds_per_interval = 60 ./ counts;
resampled_data = [];
resampled_descriptions = [];
for i = 1:length(unique_values)
    value = unique_values(i);
    interval = seconds_per_interval(i);
    
    % 生成一分钟内的秒数
    seconds = 0:interval:59;
    
    % 添加到重新采样后的数据
    resampled_data = [resampled_data; ones(length(seconds), 1) * value];
    
    % 生成描述，例如 10, 20, 30, ...
    descriptions = 0:interval:59;
    resampled_descriptions = [resampled_descriptions; descriptions'];
end

timedata = [resampled_data,resampled_descriptions];