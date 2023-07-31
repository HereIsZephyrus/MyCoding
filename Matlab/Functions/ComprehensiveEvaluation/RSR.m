function RSR_score=RSR(rawData,cateIdx,weight)
% RSR_score=RSR(rawData,cateIdx)
    [n,m]=size(rawData);
    rank=zeros(n,m);
    if m~=length(weight)
        error('the length of weight must be equal to the number of columns of data');
    end
    for i=1:m
        switch cateIdx(i)
            case 1%高优指标
                %[~,rank(:,i)]=sort(rawData(:,i),'ascend');
                rank(:,i)=1+(n-1)*(rawData(:,i)-min(rawData(:,i)))/(max(rawData(:,i))-min(rawData(:,i)));
            case 0%频数指标
                [~,rank(:,i)]=m_Count(rawData(:,i)); 
            case -1%低优指标
                %[~,rank(:,i)]=sort(rawData(:,i),'descend');                
                rank(:,i)=1+(n-1)*(max(rawData(:,i))-rawData(:,i))/(max(rawData(:,i))-min(rawData(:,i)));
        end
    end
    clear i;
    RSR_score=zero(n,1);
    for i=1:n
        RSR_score(i)=(rank(i,:).*weight)/n;
    end
    meanRSR=mean(RSR_score);
    stdRSR=std(RSR_score);
    Y_score=(RSR_score-meanRSR)/stdRSR+5;
end

function rank=m_Count(data)
    n=length(data);
    counting=tabulate(data);
    rank=zeros(n,1);
    for i=1:n
        rank(i)=(1+counting(data(i),2))/2;
    end
    clear i;
end