%borrar variables
clear tiempo(i)
clear giro_C(i)
clear motor_A
clear motor_B
clear motor_C
clear angulo_rad
%declaramos motores
motor_A=NXTMotor('A')
motor_B=NXTMotor('B')
motor_C=NXTMotor('C')

%reseteamos encoders
NXT_ResetMotorPosition(0, false);
NXT_ResetMotorPosition(1, false);
NXT_ResetMotorPosition(2, false);
%iniciamos tiempo
i=1;
tstart=tic;
tiempo(i)=toc(tstart);

%Angulo deseado
angulo_ref=90;

while tiempo(i)<3
    i=i+1;
    tiempo(i)=toc(tstart);
    C=NXT_GetOutputState(2);
    giro_C(i)=C.RotationCount;
    Error(i)=angulo_ref-giro_C;
    motor_C.Power=int8(0.2*Error(i));
    motor_C.SendToNXT();  
    angulo_rad(i)=(giro_C(i)/180)*pi
    pinta_robot(0,0,0,angulo_rad(i));
end
motor_C.Stop('off');
%plot (tiempo(1,:),giro_C(1,:));

%Error(i)=angulo_ref-angulo
%Power=K*Error
%Convertir a int
%La k sera 0.5

%Leemos encoder, calculamos el error y mandamos la orden con una potencia
%proporcional.