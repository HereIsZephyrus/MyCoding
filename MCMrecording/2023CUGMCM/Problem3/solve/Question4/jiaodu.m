clc;clear;
clear i

%确定图片的位置和大小，[x y width height]

figure('visible','on','position',[350,200,800,550]); 
subplot(2,2,1)
x_position=[];
speed=[-136.223,-52.329;-52.329,31.565;31.565,115.459;115.459,199.352];%x轴范围
Y = [7.5,31.1,18.0,43.4];%占比
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;


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
legend({'-136.223,-52.329','-52.329,31.565','31.565,115.459','115.459,199.352'}, 'Location', 'NorthEast');
clear
%%


subplot(2,2,2)
x_position=[];
speed=[-193.404,-93.774;-93.774,5.856;5.856,105.486;105.486,205.117];
Y = [55.2,6.1,7.6,31.1];

for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;


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
legend({'-193.404,-93.774','-93.774,5.856','5.856,105.486','105.486,205.117'}, 'Location', 'NorthEast');
clear 
%%
subplot(2,2,3)
x_position=[];
speed=[-179.756,-73.278;-73.278,33.2;33.2,139.678;139.678,246.156];
Y = [34.2,29.5,8.2,28.1];

for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
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
legend({'-179.756,-73.278','-73.278,33.2','33.2,139.678','139.678,246.156'}, 'Location', 'NorthEast');

%%
subplot(2,2,4)
x_position=[];
speed=[-221.881,-100.446;-100.446,20.989;20.989,142.424;142.424,263.859];
Y = [30.2,44.8,14.4,10.6];

for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;

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
legend({'-221.881,-100.446','-100.446,20.989','20.989,142.424','142.424,263.859'}, 'Location', 'NorthEast');

sgtitle('四个路段角度频数占比直方图', 'FontSize', 16, 'FontWeight', 'bold');