clc;clear;

global dis;
%dis=CalcDistance(X,Y,length(X));
GenerationNum=50;
genes=cell(GenerationNum,1);
genes{1}=GenerateParental(50,5);
for k=2:GenerationNum
    Parent=genes{k-1};
    Child1=Mate(Parent,3);
    Child2=Variate(Parent,0.1);
    genes{k}=Choose(Parent,Child1,Child2);
end