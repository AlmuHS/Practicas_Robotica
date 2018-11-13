%borrar variables
clear tiempo
clear giro_C
clear motor_A
clear motor_B
clear motor_C
clear angulo_rad
clear angulo_ref

%declaramos motores
motor_A=NXTMotor('A')
motor_B=NXTMotor('B')
motor_C=NXTMotor('C')

%Declaramos sensor
OpenUltrasonic(SENSOR_4);

%reseteamos encoders
NXT_ResetMotorPosition(0, false);
NXT_ResetMotorPosition(1, false);
NXT_ResetMotorPosition(2, false);

%Inicializamos variables
i=1;
angulo_ref(i)=0;
C=NXT_GetOutputState(2);
giro_C(i)=C.RotationCount;
Error(i)=angulo_ref(i)-giro_C(i);
distancia(i)=0;

%iniciamos tiempo
tstart=tic;
tiempo(i)=toc(tstart);

%Angulo deseado
%angulo_ref=90;

%bucle
while tiempo(i)<12
    i=i+1;
    tiempo(i)=toc(tstart);
    %comprobar sino quitar Error en while y if
    angulo_ref(i)=signal(90,9,tiempo(i),1); %Sera cambiado por signal
    C=NXT_GetOutputState(2);
    giro_C(i)=C.RotationCount;
    Error(i)=angulo_ref(i)-giro_C(i);
    motor_C.Power=int8(0.22*Error(i));
    motor_C.SendToNXT();
    distancia(i)=GetUltrasonic(SENSOR_4);
    angulo_rad(i)=(giro_C(i)/180)*pi
    pinta_robot(0,0,0,angulo_rad(i));
end
motor_C.Stop('off');
figure
plot (tiempo,angulo_ref(1,:),tiempo,giro_C(1,:));
figure
plot(tiempo,distancia(1,:));
drawnow

%Desactivamos sensor
CloseSensor(SENSOR_4);