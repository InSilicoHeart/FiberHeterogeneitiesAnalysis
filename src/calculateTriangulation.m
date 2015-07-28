function Triangulation = calculateTriangulation(V,dt)

APD90 = calculateAPD(V,dt,0.9);
APD50 = calculateAPD(V,dt,0.5);
Triangulation=APD90-APD50;

