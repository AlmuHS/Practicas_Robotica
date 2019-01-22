%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para motores y cierra sensores
%-------------------------------


motor_cabeza.Stop('off'); %lo para
motor_derecho.Stop('off'); %lo para
motor_izquierdo.Stop('off'); %lo para

CloseSensor(SENSOR_1); %cierra el sensor
CloseSensor(SENSOR_2); %cierra el sensor
CloseSensor(SENSOR_4); %cierra el sensor