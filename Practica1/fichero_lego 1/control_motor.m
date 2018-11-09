%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ejemplo de uso de comandos para generar movimiento 
% en lso motores del NXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%crea el objeto motor

motor_A = NXTMotor('A')
motor_C = NXTMotor('C')

%configura la velocidad

motor_A.Power = 50;  
motor_C.Power = 50;

% envía el comando a los motores

motor_A.SendToNXT(); % this is actually the moment we start the motor
motor_C.SendToNXT(); % this is actually the moment we start the motor

pause(2); % espera 2 segundos



%cambia la velocidad del motro A


motor_A.Power = 25;

motor_A.SendToNXT();


pause(1);%espera 1 segundo

%para los motores

motor_A.Stop('off');
motor_C.Stop('off');
