function [scoreNode,scoreEdge]=Score(weightNode,weightEdge)
    evalNode(1,:)=[0.154,0.155,0.123,0.125,0.133,0.09,0.1,0.166,0.163];
    evalNode(2,:)=[-0.197,-0.201,-0.021,-0.042,-0.065,0.571,0.537,-0.046,-0.122];
    evalNode(3,:)=[-0.182,-0.153,0.571,0.561,-0.337,0.008,-0.136,-0.098,-0.091];
    evalPartN=[-0.65887,0.1548,0.1311];
    for i=1:81
        nodeY=zeros(1,3);
        for j=1:3
            nodeY(j)=evalNode(j).*weightNode(i);
        end
        scoreNode(i)=-sum(nodeY.*evalPartN);
    end
    evalEdge(1,:)=[0.225,0.219,0.257,0.217,0.261,0.138,0.019];
    evalEdge(2,:)=[0.409,0.432,-0.216,0.319,-0.280,0.13,0.381];
    evalEdge(3,:)=[0.064,0.077,-0.119,0.244,-0.161,0.584,0.745];
    evalPartE=[0.4775,0.1923,0.14185];
    for i=1:1049
        edgeY=zeros(1,3);
        for j=1:3
            edgeY(j)=evalEdge(j).*weightEdge(i);
        end
        scoreEdge(i)=-sum(edgeY.*evalPartE);
    end
end