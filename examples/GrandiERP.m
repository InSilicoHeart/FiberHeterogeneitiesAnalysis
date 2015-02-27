addpath('../src')

pathToSave = '~/FiberSensitivityResults/GrandiEstable0001';
mainElvira = '~/Software/Elvira/Elvira20150121/bin/mainelv_infiniband_gcc';
project = 'Conductance Sensitivity - Grandi Model';

param = [1 2];
values =[0.70:0.15:1.30];
cellType = 13;
cores=4;
dt = 0.002;
step_save=50;
%[s]=rmdir(Model,'s');
Imax = 500;
Istep = 1;

sigma_L = 0.0013;
Cm = 1;
L = 4;
dx = 0.01;
nOut = 5;
dxOut = 0.25;
nodes = [0:dx:L];

nPrev = round((nOut-1)/2);
mid = nodes((end+1)/2);
positions = [-nPrev:-nPrev+nOut-1]*dxOut + mid;
nodeOut = round(positions/dx)+1;

SensitivityAnalysis(cores, pathToSave, mainElvira, project, cellType, param, values, dt,...
             step_save, Imax, Istep, sigma_L, Cm, nodes,nodeOut)

exit
