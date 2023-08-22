function [weight,CR]=AHP(layer,matrixs)
    % 层次分析法，layer为层数(包括目标层)，matrixs为每层的矩阵
    %   layer: the number of layer,从高到低排列
    %   matrixs: the cell of matrixs
    %   judge: the matrixs of judgement 
    arguments 
        layer (1,1) int
        matrixs cell
    end
    layer=layer-1;%目标层没有转移
    CR=zeros(layer,1);
    judge=matrixs{1,1};
    [weight,CR(1),~]=CalcLayer(judge);
    transfer=cell(layer-1,1);    
    for lay=1:layer-1
        nUpper=length(matrixs{lay,1});
        nLower=length(matrixs{lay+1,1});
        transfer{lay}=zeros(nLower,nUpper);%transfer表示第i+1层的第goal个矩阵关于第i层的权重矩阵
        for goal=1:nUpper
            temp=0;
            [transfer{lay}(:,goal),temp,~]=CalcLayer(matrixs{lay+1,goal+1});%(i,j)表示第i个指标对第j个指标对贡献
            CR(lay+1)=CR(lay+1)+temp;
            clear temp
        end
        CR(lay+1)=CR(lay+1)/nUpper;
        weight=transfer{lay}*weight;
    end
end