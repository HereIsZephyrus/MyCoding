function topsis_score=Topsis(rawData,weight)
    [n,m]=size(rawData);
    if m~=length(weight)
        error('the length of weight must be equal to the number of columns of data');
    end
    weight=reshape(weight,1,m);
    normData=normalize(data);
    stdData=normData.*weight;
    pos=max(stdData,[],1);
    neg=min(stdData,[],1);
    disPos=sqrt(sum((stdData-pos).^2,2));
    disNeg=sqrt(sum((stdData-neg).^2,2));
    score=disNeg./(disPos+disNeg);
    topsis_score=score/sum(score);
end