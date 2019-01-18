function [power1 power2]=Calculo_potencia(velocidad, curvatura)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%La curvatura es la inversa del radio que debe describir el robot
global radio_rueda
global l


    power1=(velocidad/radio_rueda)*(1+(l*curvatura))*1.7854;
    power2=(velocidad/radio_rueda)*(1-(l*curvatura))*1.7854;

    
end