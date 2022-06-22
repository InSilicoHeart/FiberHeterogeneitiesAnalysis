function createFileParamNode(pathToSave,params, range, nNodes)

f=fopen([pathToSave '/data/file_param_node.dat'],'w');

fprintf(f,[num2str(nNodes) '\n']);
for i=1:nNodes
    values = nan(1, length(params));
    for j=1:length(params)
        values(j) = rand()*(range(j,2)-range(j,1))+range(j,1);
    end
    fprintf(f,[' ' num2str(i) ' ' num2str(length(params)) ' ' num2str(params) ' ' num2str(values) '\n']);
end
fclose(f);

disp('File file_param_node.dat created')

