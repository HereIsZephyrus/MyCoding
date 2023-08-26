clc;clear;
clear i

%确定图片的位置和大小，[x y width height]

figure('visible','on','position',[350,200,800,550]); 

subplot(2,2,1)
x_position=[];
speed=[-0.471,-0.208;-0.208,0.056;0.056,0.319;0.319,0.583];

for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [7.5,63.5, 21.6,7.4];

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
legend({'-0.471,-0.208','-0.208,0.056','0.056,0.319','0.319,0.583'}, 'Location', 'NorthEast');
clear
%%


subplot(2,2,2)
x_position=[];
speed=[-0.826,-0.376;-0.376,0.074;0.074,0.524;0.524,0.974];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [9.6,57.7,26,6.7];

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
legend({'-0.826,-0.376','-0.376,0.074','.074,0.524','0.524,0.974'}, 'Location', 'NorthEast');
clear 
%%
subplot(2,2,3)
x_position=[];
speed=[-0.167,-0.087;    -0.087,-0.007;    -0.007,0.072;    0.072,0.152];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [4.6,28.2,62.6,4.6];

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
legend({'-0.167,-0.087','-0.087,-0.007','-0.007,0.072','0.072,0.152'}, 'Location', 'NorthEast');

%%
subplot(2,2,4)
x_position=[];
speed=[-1.482,-0.648;-0.648,0.185;0.185,1.019;1.019,1.852];
for i = 1:length(speed)

    x_position(i) =((speed(i,2)-speed(i,1)) .\ 2)+speed(i,1);
end

clear i
%准备数据
X = x_position;
Y = [1.4,88.3,8.8,1.5];

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

sgtitle('四个路段横向加速度频数占比直方图', 'FontSize', 16, 'FontWeight', 'bold');
