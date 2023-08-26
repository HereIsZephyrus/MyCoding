clc;close all;clear

data1 = readtable('路段1.xlsx');
data2 = readtable('路段2.xlsx');
data3 = readtable('路段3.xlsx');
data4 = readtable('路段4.xlsx');
%%
% 假设 time1 包含时、分、秒的矩阵
time1 = [data1(:, 5), data1(:, 6), data1(:, 7)];
time1 = table2array(time1);
roundedTime1 = round(time1(:,3));  % 进行四舍五入
time1(:,3)= roundedTime1;
time2 = [data2(:, 5), data2(:, 6), data2(:, 7)];
time2 = table2array(time2);
roundedTime2 = round(time2(:,3));  % 进行四舍五入
time2(:,3)= roundedTime2;
time3 = [data3(:, 5), data3(:, 6), data3(:, 7)];
time3 = table2array(time3);
roundedTime3 = round(time3(:,3));  % 进行四舍五入
time3(:,3)= roundedTime3;
time4 = [data4(:, 5), data4(:, 6), data4(:, 7)];
time4 = table2array(time4);
roundedTime4 = round(time4(:,3));  % 进行四舍五入
time4(:,3)= roundedTime4;

%% 位移
distance1 = table2array(data1(:,8));
distance2 = table2array(data2(:,8));
distance3 =table2array(data3(:,8));
distance4 =table2array(data4(:,8));
%% 速度
for i=2:length(time1)
    if time1(:,3) ==0
       v1(i) = (time1(i,3)-time1(i-1,3)+60) .\ distance1(i,1) ;  
    else
       v1(i) = (time1(i,3)-time1(i-1,3)) .\ distance1(i,1) ;
    end

end
v1=v1';
for i=2:length(time2)
    if time2(:,3) ==0
       v2(i) = (time2(i,3)-time2(i-1,3)+60) .\ distance2(i,1) ;  
    else
       v2(i) = (time2(i,3)-time2(i-1,3)) .\ distance2(i,1) ;
    end

end
v2=v2';
for i=2:length(time3)
    if time3(:,3) ==0
       v3(i) = (time3(i,3)-time3(i-1,3)+60) .\ distance3(i,1) ;  
    else
       v3(i) = (time3(i,3)-time3(i-1,3)) .\ distance3(i,1) ;
    end

end
v3=v3';
for i=2:length(time4)
    if time4(:,3) ==0
       v4(i) = (time4(i,3)-time4(i-1,3)+60) .\ distance4(i,1) ;  
    else
       v4(i) = (time4(i,3)-time4(i-1,3)) .\ distance4(i,1) ;
    end

end
v4=v4';
%% vt可视化
% 假设 time1 包含时、分、秒的矩阵
% 将时、分、秒合并为 "HH:mm:ss" 格式的字符串
timeFormatted1 = strcat(num2str(time1(:, 1), '%02d'), ':', num2str(time1(:, 2), '%02d'), ':', num2str(time1(:, 3), '%02d'));
% 假设你有一个字符数组 charArray 和一个数值数组 numArray
charArray1 = timeFormatted1;
numArray1 = v1;
datetimeArray1 = datetime(charArray1, 'InputFormat',  'HH:mm:ss');


% 假设 time1 包含时、分、秒的矩阵
% 将时、分、秒合并为 "HH:mm:ss" 格式的字符串
timeFormatted2 = strcat(num2str(time2(:, 1), '%02d'), ':', num2str(time2(:, 2), '%02d'), ':', num2str(time2(:, 3), '%02d'));
% 假设你有一个字符数组 charArray 和一个数值数组 numArray
charArray2 = timeFormatted2;
numArray2 = v2;
datetimeArray2 = datetime(charArray2, 'InputFormat',  'HH:mm:ss');

% 假设 time1 包含时、分、秒的矩阵
% 将时、分、秒合并为 "HH:mm:ss" 格式的字符串
timeFormatted3 = strcat(num2str(time3(:, 1), '%02d'), ':', num2str(time3(:, 2), '%02d'), ':', num2str(time3(:, 3), '%02d'));
% 假设你有一个字符数组 charArray 和一个数值数组 numArray
charArray3 = timeFormatted3;
numArray3 = v3;
datetimeArray3 = datetime(charArray3, 'InputFormat',  'HH:mm:ss');


% 假设 time1 包含时、分、秒的矩阵
% 将时、分、秒合并为 "HH:mm:ss" 格式的字符串
timeFormatted4 = strcat(num2str(time4(:, 1), '%02d'), ':', num2str(time4(:, 2), '%02d'), ':', num2str(time4(:, 3), '%02d'));
% 假设你有一个字符数组 charArray 和一个数值数组 numArray
charArray4 = timeFormatted4;
numArray4 = v4;
datetimeArray4 = datetime(charArray4, 'InputFormat',  'HH:mm:ss');



%%
% 假设你已经有 datetimeArray1, numArray1, datetimeArray2, numArray2, datetimeArray3, numArray3, datetimeArray4, numArray4

% 创建一个新的图形窗口
figure();

% 将图形窗口分为 2x2 的矩阵，并设置当前子图为第一个
subplot(2, 2, 1);

% 绘制第一条折线，并设置渐变颜色
plot(datetimeArray1, numArray1, '-o', 'Color', [0.2, 0.2, 0.5]);
% grid on;
title('Plot 1');

% 设置当前子图为第二个
subplot(2, 2, 2);

% 绘制第二条折线，并设置渐变颜色
plot(datetimeArray2, numArray2, '-o', 'Color', [0.3, 0.3, 0.8]);
% grid on;
title('Plot 2');
xtickformat('HH:mm:ss');
% 设置当前子图为第三个
subplot(2, 2, 3);

% 绘制第三条折线，并设置渐变颜色
plot(datetimeArray3, numArray3, '-o', 'Color', [0.1, 0.2, 1]);
% grid on;
title('Plot 3');
xtickformat('HH:mm:ss');
% 设置当前子图为第四个
subplot(2, 2, 4);

% 绘制第四条折线，并设置渐变颜色
plot(datetimeArray4, numArray4, '-o', 'Color', [0.5, 0.4, 1]);
% grid on;
title('Plot 4');
xtickformat('HH:mm:ss');

% 设置横坐标的显示格式，只显示时、分、秒部分
for i = 1:4
    subplot(2, 2, i);
    xtickformat('HH:mm:ss');
end
