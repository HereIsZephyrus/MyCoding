%% 蒙特卡洛模拟：内生性会造成回归系数的巨大误差
times = 300;  % 蒙特卡洛的次数
R = zeros(times,1);  % 用来储存扰动项u和x1的相关系数
K = zeros(times,1);  % 用来储存遗漏了x2之后，只用y对x1回归得到的回归系数
for i = 1: times
    n = 30;  % 样本数据量为n
    x1 = -10+rand(n,1)*20;   % x1在-10和10上均匀分布，大小为30*1
    u1 = normrnd(0,5,n,1) - rand(n,1);  % 随机生成一组随机数
    x2 = 0.3*x1 + u1;   % x2与x1的相关性不确定， 因为我们设定了x2要加上u1这个随机数
    % 这里的系数0.3我随便给的，没特殊的意义，你也可以改成其他的测试。
    u = normrnd(0,1,n,1);  % 扰动项u服从标准正态分布
    y = 0.5 + 2 * x1 + 5 * x2 + u ;  % 构造y
    k = (n*sum(x1.*y)-sum(x1)*sum(y))/(n*sum(x1.*x1)-sum(x1)*sum(x1)); % y = k*x1+b 回归估计出来的k
    K(i) = k;
    u = 5 * x2 + u;  % 因为我们回归中忽略了5*x2，所以扰动项要加上5*x2
    r = corrcoef(x1,u);  % 2*2的相关系数矩阵
    R(i) = r(2,1);
end
plot(R,K,'*')
xlabel("x_1和u'的相关系数")
ylabel("k的估计值")

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
% % 视频中提到的附件可在售后群（购买后收到的那个无忧自动发货的短信中有加入方式）的群文件中下载。包括讲义、代码、我视频中推荐的资料等。
% % 关注我的微信公众号《数学建模学习交流》，后台发送“软件”两个字，可获得常见的建模软件下载方法；发送“数据”两个字，可获得建模数据的获取方法；发送“画图”两个字，可获得数学建模中常见的画图方法。另外，也可以看看公众号的历史文章，里面发布的都是对大家有帮助的技巧。
% % 购买更多优质精选的数学建模资料，可关注我的微信公众号《数学建模学习交流》，在后台发送“买”这个字即可进入店铺(我的微店地址：https://weidian.com/?userid=1372657210)进行购买。
% % 视频价格不贵，但价值很高。单人购买观看只需要58元，三人购买人均仅需46元，视频本身也是下载到本地观看的，所以请大家不要侵犯知识产权，对视频或者资料进行二次销售。
% % 如何修改代码避免查重的方法：https://www.bilibili.com/video/av59423231（必看）