clc;clear
load HostedState.mat
% 评价出每一届奥运会的优势度
%% 用topsis得出该届该因素在历史上的得分,函数位于函数库中
%{
n=7;
E_weight = Entropy_Method(E_vary_std);
L_weight=Entropy_Method(L_vary_std);
S_weight=Entropy_Method(S_vary_std);
T_weight=Entropy_Method(T_vary_std);
D_weight=Entropy_Method(D_vary_std);
B_weight=Entropy_Method(B_vary_std);

E_distance_P = sum(((E_weight - repmat(max(E_weight),n,1)) .^ 2 ) .* repmat(E_weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
E_distance_N = sum(((E_weight - repmat(min(E_weight),n,1)) .^ 2 ) .* repmat(E_weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
E_score = E_distance_N ./ (E_distance_P+E_distance_N);    % 未归一化的得分
E_score_std = E_score / sum(E_score);
[E_sorted,E_index] = sort(E_score_std ,'descend');
for i=1:n
    E_score_sum(i)=sum(E_score_std(i,:));
end

L_distance_P = sum(((L_weight - repmat(max(L_weight),n,1)) .^ 2 ) .* repmat(L_weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
L_distance_N = sum(((L_weight - repmat(min(L_weight),n,1)) .^ 2 ) .* repmat(L_weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
L_score = L_distance_N ./ (L_distance_P+L_distance_N);    % 未归一化的得分
L_score_std = L_score / sum(L_score);
[L_sorted,L_index] = sort(L_score_std ,'descend');
for i=1:n
    L_score_sum(i)=sum(L_score_std(i,:));
end

S_distance_P = sum(((S_weight - repmat(max(S_weight),n,1)) .^ 2 ) .* repmat(S_weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
S_distance_N = sum(((S_weight - repmat(min(S_weight),n,1)) .^ 2 ) .* repmat(S_weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S_score = S_distance_N ./ (S_distance_P+S_distance_N);    % 未归一化的得分
S_score_std = S_score / sum(S_score);
[S_sorted,S_index] = sort(S_score_std ,'descend');
for i=1:n
    S_score_sum(i)=sum(S_score_std(i,:));
end

T_distance_P = sum(((T_weight - repmat(max(T_weight),n,1)) .^ 2 ) .* repmat(T_weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
T_distance_N = sum(((T_weight - repmat(min(T_weight),n,1)) .^ 2 ) .* repmat(T_weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
T_score = T_distance_N ./ (T_distance_P+T_distance_N);    % 未归一化的得分
T_score_std = T_score / sum(T_score);
[T_sorted,T_index] = sort(T_score_std ,'descend');
for i=1:n
    T_score_sum(i)=sum(T_score_std(i,:));
end

D_distance_P = sum(((D_weight - repmat(max(D_weight),n,1)) .^ 2 ) .* repmat(D_weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_distance_N = sum(((D_weight - repmat(min(D_weight),n,1)) .^ 2 ) .* repmat(D_weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
D_score = D_distance_N ./ (D_distance_P+D_distance_N);    % 未归一化的得分
D_score_std = D_score / sum(D_score);
[D_sorted,D_index] = sort(D_score_std ,'descend');
for i=1:n
    D_score_sum(i)=sum(D_score_std(i,:));
end

B_distance_P = sum(((B_weight - repmat(max(B_weight),n,1)) .^ 2 ) .* repmat(B_weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
B_distance_N = sum(((B_weight - repmat(min(B_weight),n,1)) .^ 2 ) .* repmat(B_weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
B_score = B_distance_N ./ (B_distance_P+B_distance_N);    % 未归一化的得分
B_score_std = B_score / sum(B_score);
[B_sorted,B_index] = sort(B_score_std ,'descend');
for i=1:n
    B_score_sum(i)=sum(B_score_std(i,:));
end

%% 主观评价
Weight=[0.3,0.2,0.2,0.1,0.1,0.1];
%}

resultSummer=[ecoSummer',tourSummer',satSummer',landSummer'];
[numSummer,dim]=size(resultSummer);
weightSummer=Entropy_Method(resultSummer);
%trick
distance_P = sum(((resultSummer - repmat(max(resultSummer),numSummer,1)) .^ 2 ) .* repmat(weightSummer,numSummer,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
distance_N = sum(((resultSummer - repmat(min(resultSummer),numSummer,1)) .^ 2 ) .* repmat(weightSummer,numSummer,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
scoreSummer = distance_N ./ (distance_P+distance_N);    % 未归一化的得分
scoreSummer_std = scoreSummer / sum(scoreSummer);
[sortedSummer,indexSummer] = sort(scoreSummer_std ,'descend');

filename = 'score.xlsx';
writematrix(scoreSummer_std,filename,'Sheet',1,'Range','A1:A16');
writematrix(sortedSummer,filename,'Sheet',1,'Range','C1:C16');
writematrix(indexSummer,filename,'Sheet',1,'Range','D1:D16');

%%
resultWinter=[ecoWinter',tourWinter',satWinter',landWinter'];
[numWinter,dim]=size(resultWinter);
weightWinter=Entropy_Method(resultWinter);
%trick
distance_P = sum(((resultWinter - repmat(max(resultWinter),numWinter,1)) .^ 2 ) .* repmat(weightWinter,numWinter,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
distance_N = sum(((resultWinter - repmat(min(resultWinter),numWinter,1)) .^ 2 ) .* repmat(weightWinter,numWinter,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
scoreWinter = distance_N ./ (distance_P+distance_N);    % 未归一化的得分
scoreWinter_std = scoreWinter / sum(scoreWinter);
[sortedWinter,indexWinter] = sort(scoreWinter_std ,'descend');

filename = 'score.xlsx';
writematrix(scoreWinter_std,filename,'Sheet',2,'Range','A1:A17');
writematrix(sortedWinter,filename,'Sheet',2,'Range','C1:C17');
writematrix(indexWinter,filename,'Sheet',2,'Range','D1:D17');

