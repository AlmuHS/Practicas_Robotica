%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ejemplo de la llamada a la funci�n 
% funcion_spline_cubica_varios_puntos.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

%xc=[x0 Pdx x Pax xf]
%yc=[y0 Pdy y Pay yf]

xc=[0 10 40 80 80 80];
yc=[0 0 40 40 100 120];

ds=1; %distancia entre puntos en cm.
camino=funcion_spline_cubica_varios_puntos(xc,yc,ds)';

 plot(camino(:,1),camino(:,2),'or','LineWidth',3)
 hold on
 plot(xc,yc,'*g')