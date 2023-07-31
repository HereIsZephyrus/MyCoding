function  [fScore,evaluation]=EfficacyEval(rawData,satisfaction,unacceptable,passing,weight)
% This function calculates the efficacy coefficient of a given data set
% satisfaction and unacceptable are the high and low limits of the acceptable data set,the passing is the bias,ranging from 0 to 100
% The function can be called in three ways:
% 1. [fScore,efficacy]=EfficacyCoef(rawData)
% 2. [fScore,efficacy]=EfficacyCoef(rawData,satisfaction,unacceptable)
% 3. [fScore,efficacy]=EfficacyCoef(rawData,satisfaction,unacceptable,passing,weight)

    [n,m]=size(rawData);
    if (nargin>=3)
        if (length(satisfaction)~=m || length(unacceptable)~=m)
            error('The length of satisfaction and unacceptable must be equal to the number of columns of rawData');
        end
        if (narigin==5)
            weight=weight/sum(weight);
        end
    else
        if (nargin==1)
            satisfaction=max(rawData,[],1);
            unacceptable=min(rawData,[],1);
        else
            if (narigin==2)
                error('The number of arguments must be 1 or 3');
            end
        end
    end
    fScore=zeros(n,m);
    evaluation=zeros(n,1);
    for i=1:n
        fScore(i,:)=(rawData(i,:)-unacceptable)./(satisfaction-unacceptable);%每一个指标的功效值
        if (nargin==5)
            evaluation(i)=fScore(i,:).*weight*(1-passing)+passing;%加权
        else
            evaluation(i)=sum(fScore(i,:))/m;%不加权
        end
    end
    clear i
end