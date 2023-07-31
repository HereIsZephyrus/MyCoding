function res=AHP(layer,matrixs)
    % 层次分析法，layer为层数，matrixs为每层的矩阵，每层的第一个cell存储该层矩阵数量
    %   layer: the number of layer,从低到高排列
    %   matrixs: the cell of matrixs
    arguments 
        layer (1,1) int
        matrixs cell
    end
    m=size(matrixs);
    weight=cell(layer-1,m-1);
    transfer=cell(layer-1,m-1);
    for i=1:layer-1
        nUpper=matrixs{i+1,1};
        nLower=matrixs{i,1};
        for goal=1:nUpper
            [n,m]=size(matrixs{i+1,goal+1});
            transfer{i,goal}=zeros(n,m);%transfer表示第i+1层的第goal个矩阵关于第i层的权重矩阵
            weight{i,goal}=CalcLayer(matrixs{i+1,goal+1});
            for j=1:nLower
                transfer{i,goal}(j,:)=reshape(CalcLayer(matrixs{i,j+1}),1,m);%(i,j)表示第i个指标对第j个指标对贡献
            end
        end
    end
    clear i goal j
    clear nUpper nLower n m
    for i=1:layer-1
        
    end
end