function tribubbleheatmap(data,minsz,maxsz,xlb,ylb,type)
% data - m*n matrix
% minsz   - size of the min bubble
% maxsz   - size of the max bubble
% xlb     - xticklabels
% ylb     - yticklabels
% type    - 'trid' lower triangle bubble heatmap
%         - 'triu' upper triangle bubble heatmap

% 构造气泡位置数据
x = 1:size(data,2);
y = 1:size(data,1);
[X,Y] = meshgrid(x,y);

% 构造网格数据
w = x(2)-x(1);
Xt = (x(1)-w/2):w:(x(end)+w/2);
Yt = (y(1)-y/2):w:(y(end)+y/2);
[Xmesh,Ymesh] = meshgrid(Xt,Yt);

% 构造方块尺寸数据
minz = min(data(:));
maxz = max(data(:));
S = minsz+(data(:)-minz)./(maxz-minz).*(maxsz-minsz);

% 三角
switch type
    case 'trid'
        % 三角气泡数据构造
        temp = triu(ones(size(data)),1);
        idx = find(temp==1);
        data(idx) = NaN;
        Z = data;
        % 三角网格数据构造
        Zmesh = zeros(size(Xmesh));
        temp = triu(ones(size(Zmesh)),2);
        idx2 = find(temp==1);
        Zmesh(idx2) = NaN;
        % 绘制下三角气泡热图
        mesh(Xmesh,Ymesh,Zmesh,'EdgeColor',[0.2 0.2 0.2],'LineWidth',1)
        hold on
        scatter(X(:),Y(:),S,Z(:),'filled')
        set(gca,'ydir','reverse')
        view(0,90)
        axis equal tight off
        set(gca,'xticklabels',[])
        for i = 1:size(Z,1)
            text(0.3,Y(i,1),xlb{i},'HorizontalAlignment','right','VerticalAlignment','middle','FontSize',11,'FontName','arial','color','k')
            text(X(1,i),Y(i,1)-0.6,ylb{i},'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',11,'FontName','arial','color','k')
        end
        colorbar('southoutside')

    case 'triu'
        % 三角气泡数据构造
        temp = triu(ones(size(data)));
        idx = find(temp==0);
        data(idx) = NaN;
        Z = data;
        % 三角网格数据构造
        Zmesh = zeros(size(Xmesh));
        temp = triu(ones(size(Zmesh)),-1);
        idx2 = find(temp==0);
        Zmesh(idx2) = NaN;   
        % 绘制上三角气泡热图
        mesh(Xmesh,Ymesh,Zmesh,'EdgeColor',[0.2 0.2 0.2],'LineWidth',1)
        hold on
        scatter(X(:),Y(:),S,Z(:),'filled')
        set(gca,'ydir','reverse')
        view(0,90)
        axis equal tight off
        set(gca,'yticklabels',[])
        for i = 1:size(Z,1)
            text(X(1,i),0.4,xlb{i},'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',11,'FontName','arial','color','k')
            text(X(1,i)-0.6,Y(i,1),ylb{i},'HorizontalAlignment','right','VerticalAlignment','middle','FontSize',11,'FontName','arial','color','k')
        end
        colorbar('eastoutside')
end

end