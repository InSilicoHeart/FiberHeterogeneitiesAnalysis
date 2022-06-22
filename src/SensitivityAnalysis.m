function SensitivityAnalysis(cores, pathToSave, mainElvira, project, cellType, ...
    params, range, numSim, dt, step_save,Imax, Istep, Idur, CL, nCLs, ...
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

Param_str = cell(length(params));

[conduction, IThreshold, Istim] = calculateIThreshold(pathToSave, Imax, Istep, Idur, dt,project)

simulateSteadyState(pathToSave,params,range,numSim,length(nodes),CL,nCLs,Cai_ind,Idur,dt,project);

parpool close;
