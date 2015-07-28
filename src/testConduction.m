function [conduction, CV, APD90] = testConduction(V,dt,numStim)

CV = cell(length(V(1,:)),1);

APD90_c = cell(length(V(1,:)),1);
APD_time = cell(length(V(1,:)),1);
maxV = cell(length(V(1,:)),1);
minV = cell(length(V(1,:)),1);

n_cells = length(V(1,:));
conduction = false;

for i=1:n_cells
    [APD90_c{i},APD_time{i}]= calculateAPD(V(:,i),dt,0.9);
end

for i=1:n_cells
    if(numStim~=length(APD90_c{i}))
        conduction=false;
        CV=[];
        APD90=[];
        return;
    end
end

conduction_v = true(1,numStim);

APD90_v = cell2mat(APD90_c)
for i=1:numStim
  if(~isempty(find(APD90_v(:,i)<150)))
    conduction_v(i)=false;
  end  
end

APD90 = mean(APD90_v);
times = cell2mat(APD_time);
CV = 1000./(times(:,end)-times(:,1));

APD90(~conduction_v)=[];
CV(~conduction_v)=[];

if(numStim==length(APD90))
    conduction = true;
end
