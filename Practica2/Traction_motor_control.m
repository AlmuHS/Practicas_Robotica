 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Manda las señales de control a los motores de tracción:
 % motor_derecho y motro izquierdo
 %------------------------------------
 
 %Limita el valor de velocidad que se manda a los motores
        
       if Power1>25
                Power1=25;
        else
           if  Power1<-25
                    Power1=-25;
           end
        end
    
        if Power2>25
                Power2=25;
        else
            if  Power2<-25
                    Power2=-25;
            end
        end
       
     % Actualiza el valor de la estructura vinculada a cada motor   
            motor_derecho.Power =Power1;
            motor_izquierdo.Power =Power2;
        
     %Manda el valor a los motores.
            motor_derecho.SendToNXT(); % actuación motor derecho
            motor_izquierdo.SendToNXT(); % actuación motor izquierdo