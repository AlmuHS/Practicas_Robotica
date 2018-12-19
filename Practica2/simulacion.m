
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulaci�n del movimiento de un robot m�vil
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
volante = 0;

%tiempo inicial
t0=0;

%final de la simulaci�n
tf=100;
tf=5;

%paso de integracion
h=0.1;
%vector tiempo
t=0:h:tf;
%indice de la matriz
k=0;

%inicializaci�n valores iniciales
pose(:,k+1)=pose0;

t(k+1)=t0;

i = 1;
pos_dest = camino(i,:);

while (t0+h*k) < tf,
    %actualizaci�n
    k=k+1;
    i = i+1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %valores de los par�metros de control
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
     % estas son las variables de control    
     velocidad=5;
     %volante=-0.1416;

     pos_actual = pos_dest;
     min_dist = minima_distancia_new(camino, pos_actual);
     i = i + min_dist;
     
     pos_dest = camino(i,:);
     
     
     volante = calculo_angulo_triciclo(l, pos_actual, pos_dest, volante);

     %ambas se combinan en la variable conducci�n 
     conduccion=[velocidad volante];

     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     %para representar el punto onjetivo sobre la trayectoria

     punto=[pos_dest(1) pos_dest(2)];


    %metodo de integraci�n ruge-kuta y representaci�n gr�fica

    pose(:,k+1)=kuta(t(k),pose(:,k),h,conduccion);

end



