%% demo6-渐变色
% 选择sci配色中的1号配色，致密化为包含256种颜色的渐变色
C1 = TheColor('sci',1,'map',256,'seka',0);

% 选择gradient中的923号渐变色，稀疏化为包含10种颜色的配色
C2 = TheColor('gradient',923,'map',10,'seka',1);

% 选择图片中颜色，致密化为包含256种颜色的渐变色
C3 = TheColor('copy','map',256,'seka',0);