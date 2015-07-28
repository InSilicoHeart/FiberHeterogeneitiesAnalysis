function SensitivityAnalysis(cores, pathToSave, mainElvira, project, cellType, param, values, dt, step_save,...
                       Imax, Istep, CL, nCLs, Cai_ind, sigma_L, Cm, nodes, nodeOut)

matlabpool(cores)

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

Param_str = cell(length(param));

[conduction, IThreshold, Istim] = calculateIThreshold(pathToSave, Imax, Istep, dt,project)

simulateSteadyState(pathToSave,param,values,length(nodes),CL,nCLs,Cai_ind,dt,project);

matlabpool close;
