function Result=Markov(P)
%根据某些变量现在的情况及其变动趋向,来预测它在未来某特定区间可能的变动,作为提供某种决策的依据
    Result=sym(P');
    [x,y]=eig(Result);
    y=diag(y);  y=double(y);
    ind=find(y==max(y));
    Result=x(:,ind)/sum(x(:,ind));
end

%{
%直接推Markov矩阵解
initial_state_probs = [1, 0, 0];
num_steps = 20;
state_matrix = zeros(num_steps, length(initial_state_probs));
% Set the initial state probabilities
state_matrix(1, :) = initial_state_probs;
% Iterate through the time steps
for t = 2:num_steps
    % Update the state probabilities using the transition matrix
    state_matrix(t, :) = state_matrix(t-1, :) * P;
end
disp(state_matrix);
%}