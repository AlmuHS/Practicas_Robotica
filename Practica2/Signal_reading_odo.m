    %---------------------
    %lectura señales y calculo del heading
    %-------------------------------
    % Para evitar oscilaciones en los procesos de control del giro del
    % de la cabeza, las consultas al estado de los  motores de tracción,
    %  solo se hacen en los estados necesarios.
    %----------------------------------------------------------------------
    
    %lectura del sonar
    distancia(i) = GetUltrasonic(SENSOR_4); %Lectura sonar
    
    %lectura de encoders y del sonar
    
    if (estado==3) %cuando giro la cabeza no leo encoders de las ruedas
        cabeza=NXT_GetOutputState(2);
        giro_cabeza(i)=-cabeza.RotationCount;  
        giro_derecho(i)=giro_derecho(i-1);
        giro_izquierdo(i)=giro_izquierdo(i-1);
        
    else %cuando leo encoders de las ruedas no leo el giro de la cabeza       
        giro_cabeza(i)=giro_cabeza(i-1);
        encoder_derecho=NXT_GetOutputState(0);
        encoder_izquierdo=NXT_GetOutputState(1);
        giro_derecho(i)=encoder_derecho.RotationCount*pi/180;
        giro_izquierdo(i)=encoder_izquierdo.RotationCount*pi/180;
    end
    
        