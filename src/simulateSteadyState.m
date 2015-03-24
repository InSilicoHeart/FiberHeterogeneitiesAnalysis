function simulateSteadyState(pathToSave, param, values,nNodes, CL, nCLs, dt,project)

initialPath=pwd();
sim_stat = load([pathToSave '/status.mat']);

if(isempty(dir([pathToSave '/SS' num2str(CL)])))
  mkdir([pathToSave '/SS' num2str(CL)])
  copyfile([pathToSave '/base'],[pathToSave '/SS' num2str(CL) '/base'])
  createFileStimulus([pathToSave '/SS' num2str(CL) '/base'],[0:CL:(nCLs-1)*CL],1,sim_stat.IStim);
end

pathSS  = [pathToSave '/SS' num2str(CL)];


if(isempty(dir([pathSS '/control'])))

    copyfile([pathSS '/base'],[pathSS '/control'])
    createMainFile([pathSS '/control'],'main_file_SS', project, ...
                 ['Calculation of Steady State for CL=' num2str(CL) 'ms in control conditions'] ,...
                 CL*nCLs,dt,[],[],0,0)

    cd([pathSS '/control']);
    ! ./runelv 1 data/main_file_SS.dat post/SS_
end

a=load([pathSS '/control/post/SS_prc0_00000151.var']);
dt_results = a(2,1)-a(1,1);
V=zeros(length(a(:,2)),5);
V(:,1)=a(:,2);
a=load([pathSS '/control/post/SS_prc0_00000176.var']);
V(:,2)=a(:,2);
a=load([pathSS '/control/post/SS_prc0_00000201.var']);
V(:,3)=a(:,2);
a=load([pathSS '/control/post/SS_prc0_00000226.var']);
V(:,4)=a(:,2);
a=load([pathSS '/control/post/SS_prc0_00000251.var']);
V(:,5)=a(:,2);
for i=1:5
    [APD90{i},APD_time{i}]= calculateAPD(V(:,i),dt_results,0.9);
    Trian{i} = APD90{i}-calculateAPD(V(:,i),dt_results,0.5);
end

sim_stat.(['SS' num2str(CL)]).control.APD90_v = APD90;
sim_stat.(['SS' num2str(CL)]).control.APD90 = mean(cell2mat(APD90'));
sim_stat.(['SS' num2str(CL)]).control.APD_time = APD_time;
sim_stat.(['SS' num2str(CL)]).control.Trian_v = Trian;
sim_stat.(['SS' num2str(CL)]).control.Trian = mean(cell2mat(Trian'));
save([pathToSave '/status.mat'],'-struct','sim_stat');
    
for i=1:length(param)

  pathParam = [pathSS '/P_' num2str(param(i))];

  if(isempty(dir(pathParam)))
    mkdir(pathParam)
    copyfile([pathSS '/base'],[pathParam '/base'])
  end

  parfor j=1:length(values)
    pathValue = [pathParam '/V_' num2str(values(j))];

    if(isempty(dir(pathValue)))
      copyfile([pathParam '/base'],pathValue)
      createMainFile([pathValue],'main_file_SS', project, ...
                 ['Calculation of Steady State for CL=' num2str(CL) 'ms and P_' num2str(i) '=' num2str(values(j))] ,...
                 CL*nCLs,dt,[],[],0,1);
      createFileParamNode(pathValue,values(j),param(i),nNodes);
      cd(pathValue);
      ! ./runelv 1 data/main_file_SS.dat post/SS_
    end 
  end
end

for i=1:length(param)

  pathParam = [pathSS '/P_' num2str(param(i))]

  for j=1:length(values)
    pathValue = [pathParam '/V_' num2str(values(j))] 
    a=load([pathValue '/post/SS_prc0_00000151.var']);
    dt_results = a(2,1)-a(1,1);
    V=zeros(length(a(:,2)),5);
    V(:,1)=a(:,2);
    a=load([pathValue '/post/SS_prc0_00000176.var']);
    V(:,2)=a(:,2);
    a=load([pathValue '/post/SS_prc0_00000201.var']);
    V(:,3)=a(:,2);
    a=load([pathValue '/post/SS_prc0_00000226.var']);
    V(:,4)=a(:,2);
    a=load([pathValue '/post/SS_prc0_00000251.var']);
    V(:,5)=a(:,2);
    APD90_j = cell(1,5);
    APD_time_j = cell(1,5);
    for k=1:5
        [APD90{k},APD_time{k}]= calculateAPD(V(:,k),dt_results,0.9);
        Trian{k}= APD90{k}-calculateAPD(V(:,k),dt_results,0.5);
    end

    sim_stat.(['SS' num2str(CL)]).variations.APD90_v{i,j} = APD90;
    sim_stat.(['SS' num2str(CL)]).variations.APD90{i,j} = mean(cell2mat(APD90'));
    sim_stat.(['SS' num2str(CL)]).variations.APD_time{i,j} = APD_time;
    sim_stat.(['SS' num2str(CL)]).variations.Trian_v{i,j} = Trian;
    sim_stat.(['SS' num2str(CL)]).variations.Trian{i,j} = mean(cell2mat(Trian'));
  end
end


save([pathToSave '/status.mat'],'-struct','sim_stat');

cd(initialPath)
