function [power1 power2]=Calculo_potencia(velocidad, curvatura)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%La curvatura es la inversa del radio que debe describir el robot
global radio_rueda
global l
    power1=int8((velocidad/radio_rueda)*(1+(l*curvatura))*1.7854);
    power2=int8((velocidad/radio_rueda)*(1-(l*curvatura))*1.7854);
    
    if power1>100 | power1<-100
        if power1>100
            power1=100;
        else
            power1=-100
        end
    end
    
    if power2>100 | power2<-100
        if power2>100
            power2=100;
        else
            power2=-100;
        end
    end
    
end