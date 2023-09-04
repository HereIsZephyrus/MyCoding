clc;close all;clear
loaded_data = load('road_data.mat');
Roaddata_loaded = loaded_data.Roaddata;

 time1 = [Roaddata_loaded(1).time];
 time1 = datetime(time1,'Format','HH:mm:ss');

 time2 = [Roaddata_loaded(2).time];
 time2 = datetime(time2,'Format','HH:mm:ss');

 time3 = [Roaddata_loaded(3).time];
 time3 = datetime(time3,'Format','HH:mm:ss');

 time4 = [Roaddata_loaded(4).time];
 time4 = datetime(time4,'Format','HH:mm:ss');
%% 路段1
% 假设 time1 是一个 datetime 变量，包含时间数据

% 获取时间数据的分钟部分和秒部分
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
startminutes1 = minutesData1(1);
endminutes1 = minutesData1(end);
continuteminutes1 = endminutes1 - startminutes1 ;
needdata1 = minutesData1(7:81);
avgpointperminutes1 = continuteminutes1  \ length(needdata1) ;
disp(['路段平均每分钟记录点: ', num2str(avgpointperminutes1),'个/分钟']);

%% 路段2
% 获取时间数据的分钟部分和秒部分
minutesData2 = minute(time2);
secondsData2 = second(time2);
modifiedTime2 = time2;
for i = 1:length(time2)
    if abs(secondsData2(i) - 59) < 1e-5 &&  abs(secondsData2(i)) > 59
        % 当前数据的秒数接近59秒时，将分钟加1，秒数重置为0
        modifiedTime2(i) = modifiedTime2(i) + minutes(1) - seconds(modifiedTime2(i));
    end
end
for i = 1:length(time2)
    if abs(secondsData2(i)) > 50
        % 当前数据的秒数大于59时，将分钟加1
       minutesData2(i) = minutesData2(i) + 1;
       secondsData2(i) = 0;

    end
    if abs(secondsData2(i)) < 30
        minutesData2(i) = minutesData2(i);
        secondsData2(i) = 0;
    end
end
startminutes2 = minutesData2(1);
endminutes2 = minutesData2(end);
continuteminutes2 = endminutes2 - startminutes2 ;
needdata2 = minutesData2(3:111);
avgpointperminutes2 = continuteminutes2  \ length(needdata2) ;
disp(['路段平均每分钟记录点: ', num2str(avgpointperminutes2),'个/分钟']);


%% 路段3
% 获取时间数据的分钟部分和秒部分
minutesData3 = minute(time3);
secondsData3 = second(time3);
modifiedTime3 = time3;
for i = 1:length(time3)
    if abs(secondsData3(i) - 59) < 1e-5 &&  abs(secondsData3(i)) > 59
        % 当前数据的秒数接近59秒时，将分钟加1，秒数重置为0
        modifiedTime3(i) = modifiedTime3(i) + minutes(1) - seconds(modifiedTime3(i));
    end
end
for i = 1:length(time3)
    if abs(secondsData3(i)) > 50
        % 当前数据的秒数大于59时，将分钟加1
       minutesData3(i) = minutesData3(i) + 1;
       secondsData3(i) = 0;

    end
    if abs(secondsData3(i)) < 30
        minutesData3(i) = minutesData3(i);
        secondsData3(i) = 0;
    end
end
startminutes3 = minutesData3(1);
endminutes3 = minutesData3(end);
continuteminutes3 = endminutes3 - startminutes3 ;
needdata3 = minutesData3(5:21);
avgpointperminutes3 = continuteminutes3  \ length(needdata3) ;
disp(['路段平均每分钟记录点: ', num2str(avgpointperminutes3),'个/分钟']);

%% 路段4
% 获取时间数据的分钟部分和秒部分
minutesData4 = minute(time4);
secondsData4 = second(time4);
modifiedTime4 = time4;
for i = 1:length(time4)
    if abs(secondsData4(i) - 59) < 1e-5 &&  abs(secondsData4(i)) > 59
        % 当前数据的秒数接近59秒时，将分钟加1，秒数重置为0
        modifiedTime4(i) = modifiedTime4(i) + minutes(1) - seconds(modifiedTime4(i));
    end
end
for i = 1:length(time4)
    if abs(secondsData4(i)) > 50
        % 当前数据的秒数大于59时，将分钟加1
       minutesData4(i) = minutesData4(i) + 1;
       secondsData4(i) = 0;

    end
    if abs(secondsData4(i)) < 30
        minutesData4(i) = minutesData4(i);
        secondsData4(i) = 0;
    end
end
startminutes4 = minutesData4(1);
endminutes4 = minutesData4(end);
continuteminutes4 = endminutes4 - startminutes4 ;
needdata4 = minutesData4(5:125);
avgpointperminutes4 = continuteminutes4  \ length(needdata4) ;
disp(['路段平均每分钟记录点: ', num2str(avgpointperminutes4),'个/分钟']);
