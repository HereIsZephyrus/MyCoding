clc;clear;close all
load regressData.mat
map = [0.4698    0.6071    0.9678
    0.4876    0.6281    0.9765
    0.5083    0.6474    0.9825
    0.5290    0.6663    0.9882
    0.5529    0.6874    0.9922
    0.5712    0.7045    0.9961
    0.5923    0.7217    0.9961
    0.6133    0.7388    0.9961
    0.6363    0.7549    0.9961
    0.6554    0.7691    0.9922
    0.6725    0.7823    0.9882
    0.6964    0.7955    0.9843
    0.7146    0.8087    0.9765
    0.7357    0.8196    0.9663
    0.7527    0.8275    0.9608
    0.7687    0.8366    0.9477
    0.7871    0.8431    0.9345
    0.8081    0.8510    0.9213
    0.8214    0.8549    0.9081
    0.8385    0.8588    0.8948
    0.8556    0.8627    0.8738
    0.8710    0.8606    0.8545
    0.8860    0.8513    0.8320
    0.8992    0.8459    0.8145
    0.9124    0.8327    0.7909
    0.9255    0.8196    0.7646
    0.9349    0.8102    0.7420
    0.9442    0.7970    0.7225
    0.9496    0.7832    0.7003
    0.9569    0.7646    0.6725
    0.9608    0.7500    0.6485
    0.9647    0.7324    0.6265
];
map = flipud(map);
coefName={'Liver','Red','White','Platelet','Lipid','Kidney'};
titleName={'liver function','red blood','white blood','blood platelet','blood lipid','kidney function'};
stringName={{'ALT','ACT','ALP','GGT','AG','TP'},
            {'RBC','RDW','HGB','HCT','MCHC','MCH'},
            {'PDW','PCT','PLT'},
            {'EBC','GRA','LYM'},
            {'LDL\_C','HDL\_C','TCHO','TG'},
            {'USG','CR'}};
for i=1:6
    subplot(2,3,i);
    xvalues = stringName{i};
    yvalues = stringName{i};
    h = heatmap(xvalues,yvalues, getfield(p,coefName{i}),'FontSize',16);
    h.Title =strcat(titleName{i}, ' Index p-value');
    colormap(map);
    set(gcf,'Color',[1 1 1]);
    h.CellLabelColor = 'none';
end
clear i xvalues yvalues