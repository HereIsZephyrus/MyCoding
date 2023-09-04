clc;clear;close all;
load normalizeCatedData.mat
liverFunction=[catedData.ALT,catedData.ACT,catedData.ALP,catedData.GGT,catedData.AG,catedData.TP];
redBlood=[catedData.RBC,catedData.RDW,catedData.HGB,catedData.HCT,catedData.MCHC,catedData.MCH];
whiteBlood=[catedData.EBC,catedData.GRA,catedData.LYM];
plateletBlood=[catedData.PDW,catedData.PCT,catedData.PLT];
lipidBlood=[catedData.LDL_C,catedData.HDL_C,catedData.TCHO,catedData.TG];
kidneyFunction=[catedData.USG,catedData.CR];
[coef.Liver,p.Liver]=corrcoef(liverFunction);
[coef.Red,p.Red]=corrcoef(redBlood);
[coef.White,p.White]=corrcoef(whiteBlood);
[coef.Lipid,p.Lipid]=corrcoef(lipidBlood);
[coef.Kidney,p.Kidney]=corrcoef(kidneyFunction);
[coef.Platelet,p.Platelet]=corrcoef(plateletBlood);

%选取ALT,GGT,GLB,RBC,EBC,PLT,LDL_C,HDL_C,CR
regressData=[catedData.ALT,catedData.GGT,catedData.AG,catedData.RBC,catedData.EBC,catedData.PLT,catedData.LDL_C,catedData.HDL_C,1-catedData.CR];
[Coef,P]=corrcoef(regressData);
save orthCheck.mat Coef P
clear Coef P
regressData=[glucose,regressData];
save regressData.mat regressData coef p
