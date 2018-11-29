%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controla la tracción del motor de la cabeza
%---------------------------------------------
                 if Power>100
                    Power=100;
                 else
                    if  Power<-100
                        Power=-100;
                    end
                 end
                motor_cabeza.Power =Power;
                %Actuación del motor de la cabeza
                motor_cabeza.SendToNXT(); % actuación motor A