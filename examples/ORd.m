addpath([pwd() '/../src'])

pathToSave = '~/FiberSensitivityResults/ORd';
mainElvira = '~/Software/Elvira/ElviraFiberSensitivity20150728/bin/mainelv_openmpi_gcc';
project = 'Conductance Sensitivity - ORd Model';

param = [1:13];
values =[0.70 0.85 1.15 1.30];
cellType = 22;
cores=2;
dt = 0.002;
step_save=50;
%[s]=rmdir(Model,'s');
Imax = 1000;
Istep = 1;
Cai_ind = 5;

sigma_L = 0.003085;
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

SensitivityAnalysis(cores, pathToSave, mainElvira, project, cellType, param, values, dt,...
             step_save, Imax, Istep, CL, nCLs, Cai_ind, sigma_L, Cm, nodes,nodeOut)

plotIThresholdLimits(pathToSave)

exit
