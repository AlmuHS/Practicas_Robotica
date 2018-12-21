%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% controla el movimiento del robot mediante una m�qunia de estado.
% Utiliza los script: 
% Traction_motro_control.m; Signal_reading_odo.m;
% Para_Cierra.m.
% 29/11/2015. FGB.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear t
%variables control movimiento cabeza
clear giro_cabeza
clear referencia_cabeza
clear distancia;
clear error_sonar;

%variables control angulo del robot
clear ang_vel;
clear yaw
clear error_yaw
clear referencia_yaw
clear x y theta
clear giro_derecho giro_izquierdo

global radio_rueda
global l %distancia entre ruedas

l=7.5;%En nuestro robot en 5.75 %7.5
radio_rueda=4.46 ;%En nuestro robot 2.8
Kgiro = 0.2; %constante para el giro
ref_theta =   90; %angulo de giro deseado

% Declaraci�n de sensores
OpenSwitch(SENSOR_2); % definici�n del sensor de contacto detceta colii�n
OpenSwitch(SENSOR_1); % definici�n del sensor de contacto para start
OpenUltrasonic(SENSOR_4); %definici�n del sonar

% Declaraci�n de los motores
motor_derecho = NXTMotor('A') %Motor_derecho
motor_izquierdo = NXTMotor('B') %Motor izquierdo
motor_cabeza = NXTMotor('C') %motor del sonar


%reset del encoder de motores
NXT_ResetMotorPosition(0, false);
NXT_ResetMotorPosition(1, false);
NXT_ResetMotorPosition(2, false);

%indice inicial
i=1;

%referencia tiempo inicial
tstart = tic;

%posici�n inicial cabeza
cabeza=NXT_GetOutputState(2);
giro_cabeza(i)=cabeza.RotationCount;

%valores iniciales de los encoders
giro_derecho(i)=0;
giro_izquierdo(i)=0;

%posicion inicial
x(i) = 0;
y(i) =0;
theta(i) = 0;
giro_derecho(i)=0;
giro_izquierdo(i)=0;
mapa=[];%Mapa vacio para representar obstaculos

%medida incial
distancia(i) = GetUltrasonic(SENSOR_4);

%Inicio lectura obstaculos
Iobstaculos=0;



%--------------------
% Valores iniciales
%--------------------
%tiempo inicial
t(i)=0;

estado=1; %estado inicial
stop_distance=35; %distancia de para ante obst�culo
t_marcha_atras=1.5; %tiempo de marcha hacia atr�s.
t_giro=3;%tiempo de giro. New
transicion=1% inicializa la variable que marca el inicio el mov de la cabeza
T = 9 %periodo

%comienza el bucle
disp('pulsa el bumper para comenzar')

while(GetSwitch(SENSOR_1)==0)
end

while(GetSwitch(SENSOR_1)==1)
end

disp('comienza el bucle')
%Pulsador
pulsador = GetSwitch(SENSOR_1);

while  (pulsador==0)
    
    pulsador = GetSwitch(SENSOR_1);
    i=i+1; %indice global
    t(i)= toc(tstart); %tiempo global del bucle
    
    
    %---------------------
    %lectura se�ales y calculo del heading
    %-------------------------------
    signal_reading_odo;

    [x(i) y(i) theta(i)] = calculo_odometria(giro_derecho,giro_izquierdo, x ,y,theta,i);%Calcula la nueva posicion del robot [x y theta]
    yaw(i) = theta(i)*180/pi
    giro_cabeza_radianes(i)=giro_cabeza(i)/180*pi;
    mapa=pinta_robot(x(i),y(i),distancia(i),theta(i),giro_cabeza_radianes(i), mapa);


    estado %muestra el estado del sistema
 
   
    
    %--------------------------------------------------------
    % TRANSICIONES DE ESTADO
    %1-> marchando para adelante
    %2-> parando
    %3-> girando cabeza con sonar
    %4-> girando sobre si mismo
    %5-> Marcha atr�s

        switch estado
            
            case 1 %andando hacia delante
                 if (GetUltrasonic(SENSOR_4)<stop_distance) %si la distancia es menor que 35 para
                     estado=2; %transici�n de estado de paro
                     transicion=i; %indice que marca el inicio del estado 2
                 end
                if (GetSwitch(SENSOR_2)==1)
                   estado=5;
                   transicion=i;
                end
                
            
            case 2 %parando
                if (vel==0)
                    if distancia(i)>stop_distance
                        estado=1; %la transici�n a estado marcha hacia delante
                        transicion=i; %indice que marca el inicio del estado 1
                    else       
                        estado=3; %transici�n a estado girando cabeza
                        transicion=i; %indice que marca el inicio del estado 3
                        Iobstaculos=i;%indice que marca el inicio de la recogida de puntos
                    end
                end
             
            case 3 %girando cabeza
                inc = t(i) - t(transicion);
                
                if (inc >= T+1)
                    %Hacer aqui el calculo del angulo de referencia al que
                    %debemos dirigirnos.
                    ref_theta=calculo_referencia(distancia,giro_cabeza,transicion);
                    estado=4; %la transici�n a estado girando robot
                    transicion=i; %indice que marca el inicio del estado
                    motor_cabeza.Stop('off'); %Para la cabeza si no ha terminado completamente

                end
                    
            case 4 %girando robot
                if (t(i)-t(transicion)>t_giro) 
                    estado=2; %la transici�n a estado marcha atr�s
                    transicion=i; %indice que marca el inicio del estado 5
                    vel=0;
                Power1=vel;
                Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               Traction_motor_control;
                end
                
           case 5 %marcha atr�s
                if (t(i)-t(transicion)>t_marcha_atras)                  
                    estado=3; %transici�n a estado girando cabeza
                    transicion=i; %indice que marca el inicio del estado 2 
                     %establece los valores de control 
                vel=0;
                Power1=vel;
                Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               Traction_motor_control;
                end
            
        end %del siwtch
    
   %-----------------------
          
    
    %-------------------------------------------------
    %SALIDAS ASOCIADAS A LOS ESTADOS
    
        switch estado
        
            case 1 %andando hacia delante
            %establece los valores de control 
                vel=20;
                Power1=vel;
                Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
                Traction_motor_control;

            case 2 %parando
              %establece los valores de control 
                vel=0;
                Power1=vel;
                Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               Traction_motor_control;
        
            case 3 %girando cabeza
                
                    %Calcular referencia
                    referencia_cabeza(i) = signal(90, t(i), T, t(transicion)); %Sera cambiado por signal
                    
                    %Calcular error
                    error_sonar(i) = referencia_cabeza(i) - giro_cabeza(i);

                    %Calcular potencia
                    Power =-int8(0.22*error_sonar(i));
                    
                    %Mandar comando a motor
                    Head_motor_control;
            
            case 4 %girando sobre si mismo
               %El giro deber� depender de los obstaculos detectados desde la lectura de la cabeza.
               %Podemos obtenerlos del mapa de puntos o asociando el vector
               %distancia con el angulo de la cabeza en ese momento.
               %numObstaculos=transicion-Iobstaculos;
               
               %Giro=0;%Dependiendo de su signo se gira a un lado u a otro.
               %for j = Iobstaculos:transicion
                %    Giro=Giro+(distancia(j)*giro_cabeza(j));
              % end
               %if(Giro>0)%Giro derecha
                   Power = int8(Kgiro *[ref_theta + yaw(transicion) - yaw(i)]);

                   Power1=Power;
                   Power2=-Power;

              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               Traction_motor_control;   
                   
            case 5 %andando hacia atr�s
                %establece los valores de control 
               vel=-20;
               Power1=vel;
               Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               Traction_motor_control;      
          
        end %del siwtch
    
end %del while

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para motores y cierra sensores
%-------------------------------
 Para_Cierra;
