% ������״ͼ����ģ��
% By�������Ŀ����ճ�

%% ����׼��
% ��ȡ����
% �Ա���x
x = [1980 1990 2000];
% �����y
y = [50 63 52; 
     55 50 48; 
     30 20 44];

%% ��ɫ����
% addcolorplus������ȡ��ʽ��
% ���ںź�̨�ظ�����ɫǿ��
C1 = addcolorplus(193);
C2 = addcolorplus(194);
C3 = addcolorplus(195);

%% ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 8;

%% ��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]); % define the new figure dimensions
hold on

%% ������״ͼ����
% ԭʼ������״ͼ
GO = barh(x,y,0.8,'EdgeColor','k');
xlabel('Snowfall')
ylabel('Year')

% ��ɫ
GO(1).FaceColor = C1;
GO(2).FaceColor = C2;
GO(3).FaceColor = C3;

%% ϸ���Ż�
set(gca, 'Box', 'off', ...                                         % �߿�
         'XGrid', 'off', 'YGrid', 'off', ...                       % ����
         'TickDir', 'out', 'TickLength', [.01 .01], ...            % �̶�
         'XMinorTick', 'off', 'YMinorTick', 'off', ...             % С�̶�
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % ��������ɫ
         'YTick', 1980:10:2000,...                                 % �̶�λ�á����
         'Xticklabel',{0:10:70},...                                % X������̶ȱ�ǩ
         'Yticklabel',{[1980:10:2000]})                            % Y������̶ȱ�ǩ 

hLegend = legend([GO(1),GO(2),GO(3)], ...
                 'Springfield','Fairview','Bristol', ...
                 'Location', 'northeast');

% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 10)

% ������ɫ
set(gca,'Color',[1 1 1])

%% ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'test';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');