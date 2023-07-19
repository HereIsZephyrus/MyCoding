function MonteCarlo(Space,num)
% ���ؿ���ģ�⣺ָ��ı�׼�����Ϣ�سɷ���
% Space��ʾ��������,num��ʾʵ�����
result = zeros(num,2);  % ��ʼ������������Ϣ�غͱ�׼��ľ��󣬺������ʾ��Ϣ�أ��������ʾ��׼��
for i = 1:num
    x = rand(Space,1);  % �������n��λ������[0,1]��������� (�������������Ƶ���Ľ�������)
    p = x / sum(x);
    e = -sum(p .* mylog(p)) / log(Space); % ������Ϣ��
    sd = std(x);  % �����׼��(������ͳ������Ƶ���彲������)
    result(i,1) = e;
    result(i,2) = sd;
end
xlabel('��Ϣ��')
ylabel('��׼��')
[r,p] = corrcoef(result(:,1),result(:,2)); % �������ϵ���Ͷ�Ӧ��pֵ(���ϵ������Ƶ���彲������)
end