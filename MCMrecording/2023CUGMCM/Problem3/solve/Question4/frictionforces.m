clc;close all;clear
% 提供的数据（假设存储在名为 data 的矩阵中，每列对应不同的参数）
data = xlsread('路段1.xlsx');

% 自己设定的摩擦因数和总质量
friction_coeff = 0.7; % 设定摩擦因数
total_mass = 5000;   % 设定总质量（单位：kg）


% 重力加速度（单位：m/s²）
g = 9.81;
downF = total_mass * g;

% 初始化一个数组来存储计算的摩擦力
 ff= zeros(size(data, 1), 1);
 fc = zeros(size(data, 1), 1);
%%
% 计算每个时间点的摩擦力

for i = 2:size(data, 1)

    % 获取相关的数据
    longitudinal_acc = data(i, 4);  % 加速度大小
    
    %阻力和
    normal_force =  longitudinal_acc * total_mass;
    
    % 计算摩擦因子
    friction_coeff = normal_force  .\ downF ;
    
    % 将摩擦力存储在数组中
    ff(i) = normal_force;
    fc(i) =  friction_coeff;
end
friction_coeff =  friction_coeff';
% 在 MATLAB 命令窗口中显示计算得到的摩擦力
% disp('计算得到的摩擦力：');
% disp(friction_forces);
%%
ff = abs(ff);
%%
subplot(2,1,2)
plot(ff)
subplot(2,2,2)
plot(fc)
