%% demo7-图片中Colorbar渐变色均匀提取
% 选择图片colorbar首尾两点，按回车键，均匀提取colorbar上10个点
C1 = TheColor('copymap',10,'seka',1);

% 选择图片colorbar首尾两点，按回车键，均匀提取colorbar上10个点,
% 进一步致密化为包含256种颜色的渐变色
C2 = TheColor('copymap',10,'map',256,'seka',0);