%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controla la tracci�n del motor de la cabeza
%---------------------------------------------
                 if Power>100
                    Power=100;
                 else
                    if  Power<-100
                        Power=-100;
                    end
                 end
                motor_cabeza.Power =Power;
                %Actuaci�n del motor de la cabeza
                motor_cabeza.SendToNXT(); % actuaci�n motor A