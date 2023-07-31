function evaluation=DynamicIndexEval(rawData,reference,weight)
% rawData: the data to be evaluated
% reference: the reference data
% weight: the weight of each dimension
% evalution: the evaluation result
    [n,m]=size(rawData);
    if (length(reference)~=m)
        error('The length of reference must be the same as the dimension of rawData');
    end
    if (length(weight)~=m)
        error('The length of weight must be the same as the dimension of rawData');
    end
    evaluation=zeros(n,1);
    for i=1:n
        evaluation(i)=sum(rawData(i,:)./reference.*weight)/sum(weight);
    end
    clear i;
end