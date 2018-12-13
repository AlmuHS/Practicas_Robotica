function [v1 v2]=Vruedas(posicionIni, anguloIni, posicionFin, velocidad, radioRueda, l)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%esta funcion calculara el radio que debe seguir las ruedas y con ello la
%velocidad de giro de cada rueda
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%posicion es un vector de tamaño 2 que tiene en pos 1 la x y pos 2 la y

%Calculamos el radio de giro:
incremento=(posicionIni(1)-posicionFin(1))*sin(anguloIni)-(posicionIni(2)-posicionFin(2))*cos(anguloIni);
dist_euclidea=sqrt((posicionIni(1)-posicionFin(1))^2+(posicionIni(2)-posicionFin(2))^2);
radio=(dist_euclidea^2)/(incremento*2);

%Calculamos la velocidad de giro de cada rueda para que el robot describa
%tal angulo:

v1=(velocidad/radioRueda)*(1+l/radio);
v2=(velocidad/radioRueda)*(1-l/radio);