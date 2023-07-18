%% demo8-图片主题色自动提取
% 选择图片，采用九宫格法提取包含8个颜色的主题色
C1 = TheColor('img2palette1',8,'seka',1);

% 选择图片，采用K-means提取包含8个颜色的主题色
% C2 = TheColor('img2palette2',8,'seka',1);