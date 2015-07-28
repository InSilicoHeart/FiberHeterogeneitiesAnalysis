function [APD90,APD_time,maxV_v,minV_v] = calculateAPD90(V,dt)

[APD90,APD_time,maxV_v,minV_v] = calculateAPD(V,dt,0.9);
