%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ejemplo de uso de comandos para leer de los encoder 
% de los motores del NXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear t;
i=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%definición de los objetos motor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
motor_A = NXTMotor('A')
motor_C = NXTMotor('C')


%reset del encoder del motor
NXT_ResetMotorPosition(0, false);
NXT_ResetMotorPosition(2, false);

%Lectura de los encoder despues del reset
A=NXT_GetOutputState(0);
C=NXT_GetOutputState(2);

giro_A(i)=A.RotationCount;
giro_C(i)=C.RotationCount;

%Ponemos en marcha los motores

motor_A.Power = int8(0.25*50);  
motor_C.Power = int8(0.25*50);

motor_A.SendToNXT(); 
motor_C.SendToNXT(); 

pause(3);

%Lectura de los encoder despues del reset
A=NXT_GetOutputState(0);
C=NXT_GetOutputState(2);

giro_A(i+1)=A.RotationCount;
giro_C(i+1)=C.RotationCount;

motor_A.Stop('off'); %los para
motor_C.Stop('off');