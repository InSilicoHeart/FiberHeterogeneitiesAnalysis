function [Dia,Dia_time] = calculateDiastolic(Y,dt)
dY=diff(Y);
index =find(dY(1:end-1)<=0 & dY(2:end)>=0);
constant = find(diff(index)==1);
index(constant)=[];
Dia=Y(index);
Dia_time=(index-1)*dt;
