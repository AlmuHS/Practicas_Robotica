
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulación del movimiento de un robot móvil
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

j=1;

global l
global camino
global pose
global punto
%cargamos el camino

camino=load('camino.dat');
global l
l=1.5; %distancia entre rudas delanteras y traseras, tambien definido en modelo

%Estos son distintos ejemplos de Condiciones iniciales 

%pose0=[15; 15; -pi/2];

%pose0=[30; 30; 0];

pose0=[0; 0; pi/2];

%tiempo inicial
t0=0;

%final de la simulación
tf=100;
%tf=5;

%paso de integracion
h=0.1;
%vector tiempo
t=0:h:tf;
%indice de la matriz
k=0;

%inicialización valores iniciales
pose(:,k+1)=pose0;

t(k+1)=t0;

while (t0+h*k) < tf,
    %actualización
    k=k+1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %valores de los parámetros de control
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 distancia = 40;
 min_dist = minima_distancia_new(camino, pose(1:2,k));
 pos_dest=camino(mod(min_dist+distancia,1717),:);
 % estas son las variables de control    
 velocidad=5;
 volante = calculo_angulo_triciclo(l, pose(1:2,k), pos_dest, pose(3,k));
 
 %ambas se combinan en la variable conducción 
 conduccion=[velocidad volante];
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %para representar el punto onjetivo sobre la trayectoria
 
 punto=[pos_dest(1) pos_dest(2)];

    
%metodo de integración ruge-kuta y representación gráfica

pose(:,k+1)=kuta(t(k),pose(:,k),h,conduccion);

end




