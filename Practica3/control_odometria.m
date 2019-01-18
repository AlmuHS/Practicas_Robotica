%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de control del movimiento del robot
% estimando la posición mediante odometría
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear t;
clear theta;
clear x;
clear y;
clear power1;
clear power2;

global radio_rueda
global l %distancia entre centro y ruedas

radio_rueda=3;%radio_ajustado r=3
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
power1(i)=0;
power2(i)=0;
error_distancia(i)=Inf;
%Configuración inicial:
PosIni=[0 0];
AngIni=pi/4;
%Destino
PosFin=[80 -40];
%Constante
K=0.22

while  error_distancia(i)>3
%while t(i)<3
    i=i+1; %incremento del índice
    
    %Error distancia
    %error_distancia=sqrt();
    
    %lectura de los encoder
    A=NXT_GetOutputState(0);
    B=NXT_GetOutputState(1);
    giro_A(i)=A.RotationCount*conversion;
    giro_B(i)=B.RotationCount*conversion;
    
    [x(i) y(i) theta(i)]=calculo_odometria(giro_A,giro_B,x,y,theta,i);
    
    
    
    %lectura del tiempo
    t(i)= toc(tstart);
    %Valores por defecto
    
    Pos=[x(i) y(i)];
    curvatura(i)=Calcula_curvatura(Pos,theta(i),PosFin);
    [power1(i) power2(i)]=Calculo_potencia(20,curvatura(i));
    
    %La velocidad que debe seguir el robot debe ser proporcional a la
    %distancia al punto destino
    error_distancia(i)=sqrt((x(i)-PosFin(1))^2+(y(i)-PosFin(2))^2);
    %Ajustamos potencia
    power1(i)=K*power1(i)*error_distancia(i);
    power2(i)=K*power2(i)*error_distancia(i);
    
    %limitamos que la potencia se mantega dentro de los límites.
    if power1(i)>30 | power1(i)<-30
        if power1(i)>30
            power1(i)=30;
        else
            power1(i)=-30;
        end
    end
    
    if power2(i)>30 | power2(i)<-30
        if power2(i)>30
            power2(i)=30;
        else
            power2(i)=-30;
        end
    end
    
    %power1=20;  
    %power2=20;
    
    motor_A.Power = int8(power1(i));  
    motor_B.Power = int8(power2(i));
  
  %Actuación de los motores
     motor_A.SendToNXT(); % this is actually the moment we start the motor
     motor_B.SendToNXT(); % this is actually the moment we start the motor

end


motor_A.Stop('off'); %lo para
motor_B.Stop('off');
