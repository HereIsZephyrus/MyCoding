function slopeheatmap(data,sz)
% data - m*n matrix
% sz   - size of the squares

% 构造方块位置数据
x = 1:size(data,2);
y = 1:size(data,1);
[X,Y] = meshgrid(x,y);
Z = data;

% 构造网格数据
w = x(2)-x(1);
Xt = (x(1)-w/2):w:(x(end)+w/2);
Yt = (y(1)-y/2):w:(y(end)+y/2);
[Xmesh,Ymesh] = meshgrid(Xt,Yt);
Zmesh = zeros(size(Xmesh));

% 绘制方块热图
mesh(Xmesh,Ymesh,Zmesh,'EdgeColor','k','LineWidth',1)
hold on
scatter(X(:),Y(:),Z(:)*sz,Z(:),'s','filled')
view(0,90)

end