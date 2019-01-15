%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de control del movimiento del robot
% estimando la posición mediante odometría
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear t;
clear theta;
clear x;
clear y;

global radio_rueda
global l %distancia entre centro y ruedas

radio_rueda=2.8;%radio_ajustado r=3
l=5.75; %distancia entre entre centro y ruedas l_ajustado=6.2
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

%Inicialización de la odometría

A=NXT_GetOutputState(0);
B=NXT_GetOutputState(1);
giro_A(i)=A.RotationCount*conversion;
giro_B(i)=B.RotationCount*conversion;
x(i)=0;
y(i)=0;
theta(i)=0;
t(i)=0;

%Configuración inicial:
PosIni=[0 0];
AngIni=pi/4;
%Destino
PosFin=[5 5];

while  t(i)<15
    i=i+1; %incremento del índice
    
    %Error distancia
    %error_distancia=sqrt();
    
    %lectura de los encoder
    A=NXT_GetOutputState(0);
    B=NXT_GetOutputState(2);
    giro_A(i)=A.RotationCount*conversion;
    giro_B(i)=B.RotationCount*conversion;
    
    [x(i) y(i) theta(i)]=calculo_odometria(giro_A,giro_B,x,y,theta,i);
    
    
    
    %lectura del tiempo
    t(i)= toc(tstart);
    %Valores por defecto
    %power1=30;  
    %power2=10;
    curvatura=Calcula_curvatura(PosIni,AngIni,PosFin);
    [power1 power2]=Calculo_potencia(20,curvatura);
    
    %Ajustamos potencia
    %power1=K*power1*error_distancia;
    %power2=K*power2*error_distancia;

    
    motor_A.Power = power1;  
    motor_B.Power = power2;
  
  %Actuación de los motores
     motor_A.SendToNXT(); % this is actually the moment we start the motor
     motor_B.SendToNXT(); % this is actually the moment we start the motor

end


motor_A.Stop('off'); %lo para
motor_B.Stop('off');
