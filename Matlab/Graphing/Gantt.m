function ganttHdl=Gantt(sT,dT,id,varargin)
% sT | 任务开始时间
% dT | 任务持续时间
% id | 任务所属类型

% @author : slandarer
% 公众号  : slandarer随笔
ax=gca;hold on;
ax.YTick=1:max(id);
ax.YLim=[0,max(id)+1];
sT=sT(:);dT=dT(:);id=id(:);

% 基本配色表
this.colorList=[118 160 173;89 124 139;212 185 130;
    217 189 195;165 108 127;188 176 210]./255;
this.colorList=[this.colorList;rand(max(id),3).*.6+.4];

% 获取其他属性
this.String='';
arginList={'String','ColorList'};
for i=(length(varargin)-1):-2:1
    tid=ismember(arginList,varargin{i});
    if any(tid)
        this.(arginList{tid})=varargin{i+1};
        varargin(i:i+1)=[];
    end
end


% 循环绘图
for i=unique(id)'
    t_sT=sT(id==i);
    t_dT=dT(id==i);
    [t_sT,t_ind]=sort(t_sT);
    t_dT=t_dT(t_ind);
    if ~isempty(this.String)
        t_Str=this.String(id==i);
        t_Str=t_Str(t_ind);
    end
    for j=1:length(t_sT)
        ganttHdl.(['p',num2str(i)])(j)=rectangle('Position',[t_sT(j),i-.4,t_dT(j),.8],...
            'LineWidth',.8,'EdgeColor',[.2,.2,.2],...
            'FaceColor',this.colorList(i,:),'AlignVertexCenters','on',varargin{:});
    end
    for j=1:length(t_sT)
        if ~isempty(this.String)
            ganttHdl.(['t',num2str(i)])(j)=text(t_sT(j),i,t_Str{j});
        else
            ganttHdl.(['t',num2str(i)])(j)=text(t_sT(j),i,'');
        end
    end
end
end

%{
添加每个任务上的文本信息
调用工具函数的时候设置String属性即可，例如：

startT=[0 3 5 12 16,1.5 6 8 15 18,3 10 11 16 19,2 4 11 13 15,1 3 7 16 18,5 11 14 16 20];
durationT=[3 2 5 4 4,4 1 7 2 5,6 1 4 3 2,1 6 2 2 9,2 3 4 2 5,5 3 1 2 8];
jobId=[1 1 1 1 1,2 2 2 2 2,3 3 3 3 3,4 4 4 4 4,5 5 5 5 5,6 6 6 6 6];

pName{length(jobId)}='';
for i=1:length(jobId)
    pName(i)={num2str(i)};
end

GTC=ganttChart(startT,durationT,jobId,'String',pName);

当然可以更复杂些，包含一下每个任务的信息：

pName{length(jobId)}='';
for i=1:length(jobId)
    pName(i)={['[',num2str(startT(i)),',',num2str(startT(i)+durationT(i)),']']};
end
%}
