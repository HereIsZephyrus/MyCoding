clc;close all;clear
load('sudu.mat','v')
load('hengxianga.mat','needdata')
load('zongxianga.mat','needdata2')
load('daxiaoa.mat','needdata3')
load('jiaodu.mat','angle')
load('shijiana.mat','needtime')

road1=[needtime(:,1),v(:,1),needdata(:,1),needdata2(:,1),angle(:,1)];%时间 速度 横向 纵向 角度
road2=[needtime(:,2),v(:,2),needdata(:,2),needdata2(:,2),angle(:,2)];
road3=[needtime(:,3),v(:,3),needdata(:,3),needdata2(:,3),angle(:,3)];
road4=[needtime(:,4),v(:,4),needdata(:,4),needdata2(:,4),angle(:,4)];
%% 速度
clc;clear;
clear i

%确定图片的位置和大小，[x y width height]

figure('visible','on','position',[350,200,800,550]); 
subplot(2,2,1)
x_position=[];
speed=[-0.377,4.33;4.33,9.036;9.036,13.742;13.742,18.448];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [47.1,24, 20.9 8];

%每个柱子的颜色设置
color = [200,65,68;200,132,174;249,199,179;100,190,190;10,250,139]/255;  
hold on
% 添加5个柱子，facecolor用来修改颜色               
for i = 1:4
    b = bar(i,Y(i),0.9,'stacked');  
    set(b(1),'facecolor',color(i,:))
end
box on
%x轴每个柱子的横坐标
Xlabel = {'A1','A2','A3','A4'};
set(gca,'XTick',[1 2 3 4]);
%设置柱状图每个柱子的横坐标
set(gca,'XTickLabel',Xlabel);
%设置小标签字体
set(gca,'FontSize',10,'Fontname','Times New Roman');
%设置纵坐标的数值范围
set(gca,'YLim',[0 100]);
%修改大标签
ylabel('占比(%)','Fontname','宋体','FontSize',14) 
xlabel('路段1','Fontname','宋体','FontSize',14) 
legend({'-0.377-4.330', '4.330-9.036', '9.036-13.742', '13.742-18.448'}, 'Location', 'NorthEast');
clear
%%


subplot(2,2,2)
x_position=[];
speed=[-1.263,5.747;5.747,12.756;12.756,19.765;19.765,26.774];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [37.7,30.9,25,6.4];

%每个柱子的颜色设置
color = [200,65,68;200,132,174;249,199,179;100,190,190;10,250,139]/255;  
hold on
% 添加5个柱子，facecolor用来修改颜色               
for i = 1:4
    b = bar(i,Y(i),0.9,'stacked');  
    set(b(1),'facecolor',color(i,:))
end
box on
%x轴每个柱子的横坐标
Xlabel = {'A1','A2','A3','A4'};
set(gca,'XTick',[1 2 3 4]);
%设置柱状图每个柱子的横坐标
set(gca,'XTickLabel',Xlabel);
%设置小标签字体
set(gca,'FontSize',10,'Fontname','Times New Roman');
%设置纵坐标的数值范围
set(gca,'YLim',[0 100]);
%修改大标签
ylabel('占比(%)','Fontname','宋体','FontSize',14) 
xlabel('路段2','Fontname','宋体','FontSize',14) 
legend({'-1.263,5.747', '5.747,12.756', '12.756,19.765', '19.765,26.774'}, 'Location', 'NorthEast');
clear 
%%
subplot(2,2,3)
x_position=[];
speed=[-0.062,2.872;2.872,5.807;5.807,8.74;8.742,11.676];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [45.7,35.1, 9.2,10];

%每个柱子的颜色设置
color = [200,65,68;200,132,174;249,199,179;100,190,190;10,250,139]/255;  
hold on
% 添加5个柱子，facecolor用来修改颜色               
for i = 1:4
    b = bar(i,Y(i),0.9,'stacked');  
    set(b(1),'facecolor',color(i,:))
end
box on
%x轴每个柱子的横坐标
Xlabel = {'A1','A2','A3','A4'};
set(gca,'XTick',[1 2 3 4]);
%设置柱状图每个柱子的横坐标
set(gca,'XTickLabel',Xlabel);
%设置小标签字体
set(gca,'FontSize',10,'Fontname','Times New Roman');
%设置纵坐标的数值范围
set(gca,'YLim',[0 100]);
%修改大标签
ylabel('占比(%)','Fontname','宋体','FontSize',14) 
xlabel('路段3','Fontname','宋体','FontSize',14) 
legend({'-0.062-2.872','2.872-5.807','5.807-8.74','8.742-11.676'}, 'Location', 'NorthEast');

subplot(2,2,4)
x_position=[];
speed=[-1.264,3.586;3.586,8.435;8.435,13.285;13.285,18.135];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [42.5,35.7, 17.7,4.1];

%每个柱子的颜色设置
color = [200,65,68;200,132,174;249,199,179;100,190,190;10,250,139]/255;  
hold on
% 添加5个柱子，facecolor用来修改颜色               
for i = 1:4
    b = bar(i,Y(i),0.9,'stacked');  
    set(b(1),'facecolor',color(i,:))
end
box on
%x轴每个柱子的横坐标
Xlabel = {'A1','A2','A3','A4'};
set(gca,'XTick',[1 2 3 4]);
%设置柱状图每个柱子的横坐标
set(gca,'XTickLabel',Xlabel);
%设置小标签字体
set(gca,'FontSize',10,'Fontname','Times New Roman');
%设置纵坐标的数值范围
set(gca,'YLim',[0 100]);
%修改大标签
ylabel('占比(%)','Fontname','宋体','FontSize',14) 
xlabel('路段4','Fontname','宋体','FontSize',14) 
legend({'-1.264,3.586','3.586,8.435','8.435,13.285','13.285,18.135'}, 'Location', 'NorthEast');

sgtitle('四个路段速度频数占比直方图', 'FontSize', 16, 'FontWeight', 'bold');
