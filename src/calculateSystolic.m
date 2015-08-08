function [Sys,Sys_time] = calculateSystolic(Y,dt)
dY=diff(Y);
index =find(dY(1:end-1)>=0 & dY(2:end)<=0);
constant = find(diff(index)==1);
index(constant)=[];
Sys=Y(index);
Sys_time=(index-1)*dt;
