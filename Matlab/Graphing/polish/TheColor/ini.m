path1 = cd;
path2 = matlabroot;
inv = filesep;
path2 = strcat(path2,inv,'TheColor');
copyfile(strcat(path1,inv,'TheColor'),path2)

addpath(path2);  
savepath(strcat(matlabroot,inv,'toolbox',inv,'local',inv,'pathdef.m'))