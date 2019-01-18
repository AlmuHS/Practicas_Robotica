%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de control del movimiento del robot
% estimando la posici�n mediante odometr�a
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

%Inicializaci�n de la odometr�a

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
%Configuraci�n inicial:
PosIni=[0 0];
AngIni=pi/4;
%Destino
PosFin=[-40 0];
%Constante
K=0.22

%while  error_distancia(i)>3
while t(i)<10
    i=i+1; %incremento del �ndice
    
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
    
    limite = 40;
    
    %limitamos que la potencia se mantega dentro de los l�mites.
    if power1(i)>30 | power1(i)<-30
        if power1(i)>30
            prop=(power1(i)-30)/power1(i);
            power1(i)=30;
            if power2(i)>0
                power2(i)=power2(i)-prop*power2(i);
            else
                power2(i)=power2(i)+prop*power2(i);
            end
        else
            prop=power1(i)+30/power(i);
            power1(i)=-30;
            if power2(i)>0
                power2(i)=power2(i)-prop*power2(i);
            else
                power2(i)=power2(i)+prop*power2(i);
            end
        end
    end
     if power2(i)>30 | power2(i)<-30
         
        if power2(i)>30
            prop=(power2(i)-30)/power2(i);
            power2(i)=30;
         
            if power2(i)>0
                power1(i)=power1(i)-prop*power1(i);
            else
                power1(i)=power1(i)+prop*power1(i);
            end
        else
            prop=power2(i)+30/power2(i);
            power2(i)=-30;
            if power2(i)>0
                power1(i)=power1(i)-prop*power1(2);
            else
                power1(i)=power1(i)+prop*power1(i);
        end
    end
     
    
    
    %power1=20;  
    %power2=20;
    
    motor_A.Power = round(power1(i));  
    motor_B.Power = round(power2(i));
  
  %Actuaci�n de los motores
     motor_A.SendToNXT(); % this is actually the moment we start the motor
     motor_B.SendToNXT(); % this is actually the moment we start the motor

     end
end


motor_A.Stop('off'); %lo para
motor_B.Stop('off');
