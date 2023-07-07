function SensitivityAnalysis2params(cores, pathToSave, mainElvira, project, cellType, ...
    params, type, sigma, numSim, dt, step_save,Imax, Istep, Idur, CL, nCLs, ...
    Cai_ind, sigma_L, Cm, nodes, nodeOut)

parpool(cores)

[SUCCESS,MESSAGE] = mkdir(pathToSave);

if(SUCCESS==0)
    error([pathToSave ' directory can''t be created: ' MESSAGE])
end

if(isempty(dir([pathToSave '/base'])))
    mkdir([pathToSave '/base'])
    mkdir([pathToSave '/base/data'])
    mkdir([pathToSave '/base/post'])
    createRunElv([pathToSave '/base'],mainElvira)
    createFileMaterial([pathToSave '/base'],sigma_L,1,Cm);
    createFilePropNod([pathToSave '/base'], cellType);
    createFilePropElement([pathToSave '/base']);
    createFileNodes([pathToSave '/base'],nodes);
    createFileElements([pathToSave '/base'],length(nodes));
    createFileNodeOutput([pathToSave '/base'], step_save, nodeOut,true);
    createFileNodeOutput([pathToSave '/base'], step_save, nodeOut,false);
end


[conduction, IThreshold, Istim] = calculateIThreshold(pathToSave, Imax, Istep, Idur, dt,project)

params_long = [];
for i=1:length(params)
	for j=(i+1):length(params)
		params_long=[params_long params([i,j])'];
	end
end

simulateSteadyState2params(pathToSave,params_long,type,sigma,numSim,length(nodes),CL,nCLs,Cai_ind,Idur,dt,project);

delete(gcp('nocreate'))
