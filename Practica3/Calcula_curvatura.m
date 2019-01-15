function curvatura=Calcula_curvatura(posicionIni, anguloIni, posicionFin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%esta funcion calculara la curvatura que debe seguir el robot para alcanzar
%un punto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%La curvatura es la inversa del radio que debe describir el robot

%posicion es un vector de tamaño 2 que tiene en pos 1 la x y pos 2 la y

%Calculamos el radio de giro:
incremento=(posicionIni(1)-posicionFin(1))*sin(anguloIni)-(posicionIni(2)-posicionFin(2))*cos(anguloIni);
dist_euclidea=sqrt((posicionIni(1)-posicionFin(1))^2+(posicionIni(2)-posicionFin(2))^2);
%radio=(dist_euclidea^2)/(incremento*2);
curvatura=(incremento*2)/(dist_euclidea^2);

end

