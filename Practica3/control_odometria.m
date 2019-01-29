%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de control del movimiento del robot
% estimando la posiciï¿½n mediante odometrï¿½a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear t;
clear theta;
clear x;
clear y;
clear power1;
clear power2;

global radio_rueda
global l %distancia entre centro y ruedas

radio_rueda=2.8;%radio_ajustado r=3
l=5.60; %distancia entre entre centro y ruedas l_ajustado=6.2 5.75!
conversion=pi/180;
%crea el objeto motor

motor_A = NXTMotor('A')
motor_B = NXTMotor('B')

%reset del encoder del motor
 NXT_ResetMotorPosition(0, false);
 NXT_ResetMotorPosition(1, false);


clear t;

i=1;
tstart = tic;

%Inicializaciï¿½n de la odometrï¿½a

A=NXT_GetOutputState(0);
B=NXT_GetOutputState(1);
giro_A(i)=A.RotationCount*conversion;
giro_B(i)=B.RotationCount*conversion;
x(i)=0;
y(i)=0;
theta(i)=0;
t(i)=0;
power1(i)=0;
power2(i)=0;
error_distancia(i)=Inf;

%Configuraciï¿½n inicial:
PosIni=[0 0];
AngIni=pi/4;
%Destino
%PosD(i,:)=[10 0];

%Constante
K=0.22;
limite=10;
ahead=6;%punto al que se dirige por delante de el.

%Carga camino
%camino=load('camino3.dat');
%tamC=size(camino);
%Para generar camino con spline: Mirar script ejemplo_llamada
%xc=[0 20 40 80 120 160 160 120 80 120 200];
%yc=[0 0 -40 0 40 0 -80 -120 -160 -200 -120];
%xc=[0 40 80 120 200 120 80 160];
%yc=[0 0 60 0 160 200 160 80];
%xc=[0 40 80 160 200 240 200 120 40 0];
%yc=[0 -40 -80 0 40 80 120 80 40 40];
yc=[0 0 40 80 80 120 160 120 40];
xc=[0 10 40 70 80 120 80 0 -40];
ds=1; %distancia entre puntos en cm.
camino=funcion_spline_cubica_varios_puntos(xc,yc,ds)';
tamC=size(camino);

while  error_distancia(i)>1
%while t(i)<15
    i=i+1; %incremento del índice
    
    %lectura de los encoder
    A=NXT_GetOutputState(0);
    B=NXT_GetOutputState(1);
    giro_A(i)=A.RotationCount*conversion;
    giro_B(i)=B.RotationCount*conversion;
    
    %Posicion actual
    [x(i) y(i) theta(i)]=calculo_odometria(giro_A,giro_B,x,y,theta,i);
    Pos=[x(i) y(i)];   
    
    %lectura del tiempo
    t(i)= toc(tstart);
    
    %Calculamos el punto al que debemos ir
    indice=PuntoMasCercano(camino, Pos);
    if (indice+ahead)<= tamC(1)
        indice=indice+ahead;
    else
        indice=tamC(1);
    end
    PosD(i,:)=[camino(indice,1) camino(indice,2)]
    %PosD(i,:)=[40 -40]
    curvatura(i)=Calcula_curvatura(Pos,theta(i),PosD(i,:));
    [power1(i) power2(i)]=Calculo_potencia(20,curvatura(i));
    
    %La velocidad que debe seguir el robot debe ser proporcional a la
    %distancia al punto destino
    error_distancia(i)=sqrt((x(i)-PosD(i,1))^2+(y(i)-PosD(i,2))^2);
    %Ajustamos potencia
    power1(i)=K*power1(i)*error_distancia(i);
    power2(i)=K*power2(i)*error_distancia(i);
    
    [power1(i) power2(i)]=limita_potencia(power1(i),power2(i), limite); %cambiar para pasar un solo valor
    
    
    %power1=20;  
    %power2=20;
    
    motor_A.Power = round(power1(i));  
    motor_B.Power = round(power2(i));
  
  %Actuaciï¿½n de los motores
     motor_A.SendToNXT(); % this is actually the moment we start the motor
     motor_B.SendToNXT(); % this is actually the moment we start the motor

     
end


motor_A.Stop('off'); %lo para
motor_B.Stop('off');
