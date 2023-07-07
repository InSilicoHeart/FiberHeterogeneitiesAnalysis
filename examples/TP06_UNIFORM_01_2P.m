addpath([pwd() '/../src'])

type = 'UNIFORM';
sigma = 0.1;

pathToSave = ['~/FiberHeterogeneities/FiberHeterogeneitiesResults/TP06_' type '_' num2str(sigma) '_2P'];
mainElvira = '~/FiberHeterogeneities/elvira/bin/mainelv_infiniband_gcc';
project = ['Heterogeneities Analysis - TP06 Model - ' type ' ' num2str(sigma) ' 2 params'];

params = 3:13;
numSim = 100;
cellType = 3;
cores=6;
dt = 0.02;
step_save=5;
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
nCLs = 60;


SensitivityAnalysis2params(cores, pathToSave, mainElvira, project, cellType, params, type, sigma, numSim, dt,...
             step_save, Imax, Istep, Idur, CL, nCLs, Cai_ind, sigma_L, Cm, nodes,nodeOut)

plotIThresholdLimits(pathToSave)

exit
