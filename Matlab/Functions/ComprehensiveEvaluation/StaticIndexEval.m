function evaluation=StaticIndexEval(rawData,weight)
    % rawData: the data to be evaluated,deminision*time
    % weight: the weight of each dimension
    % evalution: the evaluation result
    [dim,time]=size(rawData);
    if (length(weight)~=dim)
        error('The length of weight must be the same as the dimension of rawData');
    end
    evaluation=zeros(time,1);
    for i=1:time
        evaluation(i)=sum(rawData(:,i).*weight)/mean(rawData)/sum(weight);
    end
    clear i
end