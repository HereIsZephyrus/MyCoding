clc;clear;
clear i

%确定图片的位置和大小，[x y width height]

figure('visible','on','position',[350,200,800,550]); 
subplot(2,2,1)
x_position=[];
speed=[-0.894,-0.535;-0.535,-0.176;-0.176,0.184;0.184,0.543];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [1.7,8.0,78.5,11.8];

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
legend({'-0.894,-0.535','-0.535,-0.176','-0.176,0.184','0.184,0.543'}, 'Location', 'NorthEast');
clear
%%


subplot(2,2,2)
x_position=[];
speed=[-1.016,-0.567;-0.567,-0.118;-0.118,0.331;0.331,0.78];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [1.3,27.8,61.8,9.1];

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
legend({'-1.016,-0.567','-0.567,-0.118','-0.118,0.331','0.331,0.78'}, 'Location', 'NorthEast');
clear 
%%
subplot(2,2,3)
x_position=[];
speed=[-0.148,-0.068;-0.068,0.012;0.012,0.092;0.092,0.172];
Y = [10.3,64.6,23.7,1.4];

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
legend({'-0.148,-0.068','-0.068,0.012','0.012,0.092','0.092,0.172'}, 'Location', 'NorthEast');

%%
subplot(2,2,4)
x_position=[];
speed=[-2.243,-0.984;-0.984,0.275;0.275,1.534;1.534,2.794];
Y = [4.8,82.6,10.9,1.7];

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
legend({'-2.243,-0.984','-0.984,0.275','0.275,1.534','1.534,2.794'}, 'Location', 'NorthEast');

sgtitle('四个路段纵向加速度频数占比直方图', 'FontSize', 16, 'FontWeight', 'bold');