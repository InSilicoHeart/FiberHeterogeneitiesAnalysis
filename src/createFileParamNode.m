function createFileParamNode(pathToSave,params, type, sigma, nNodes)

f=fopen([pathToSave '/data/file_param_node.dat'],'w');


fprintf(f,[num2str(nNodes) '\n']);
for i=1:nNodes
    values = nan(1, length(params));
    for j=1:length(params)

	if(strcmp(type, 'UNIFORM'))
	    values(j) = (2*rand()-1)*sigma+1;
	else
	    values(j) = 1;
	end
    end
    fprintf(f,[' ' num2str(i) ' ' num2str(length(params)) ' ' num2str(params) ' ' num2str(values) '\n']);
end
fclose(f);

disp('File file_param_node.dat created')

