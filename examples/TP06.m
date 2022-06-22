addpath([pwd() '/../src'])

pathToSave = '~/FiberHeterogeneitiesResults/TP06';
mainElvira = '~/Software/Elvira/ElviraFiberSensitivity20150728/bin/mainelv_infiniband_gcc';
project = 'Heterogeneities Analysis - TP06 Model';

params = 10:13;
range =ones(2,1) * [0.70 1.30];
numSim = 10;
cellType = 3;
cores=2;
dt = 0.02;
step_save=5;
%[s]=rmdir(Model,'s');
Imax = 500;
Istep = 1;
Idur = 1;
Cai_ind = 1;

sigma_L = 0.0012102;
Cm = 1;
L = 3;
dx = 0.01;
nOut = 5;
dxOut = 0.25;
nodes = [0:dx:L];

nPrev = round((nOut-1)/2);
mid = nodes((end+1)/2);
positions = [-nPrev:-nPrev+nOut-1]*dxOut + mid;
nodeOut = round(positions/dx)+1;

CL = 1000;
nCLs = 100;


SensitivityAnalysis(cores, pathToSave, mainElvira, project, cellType, params, range, numSim, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind, sigma_L, Cm, nodes,nodeOut)

plotIThresholdLimits(pathToSave)

exit
