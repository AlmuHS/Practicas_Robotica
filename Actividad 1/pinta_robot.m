function pinta_robot(x, y, theta, alfa)

    %Definicion del contorno del robot
    P1 = [4;3;0;1];
    P2 = [-4;3;0;1];
    P3 = [-4;-3;0;1];
    P4 = [4;-3;0;1];
    
    C1 = [0.5;1;0;1];
    C2 = [-0.5;1;0;1];
    C3 = [-0.5;-1;0;1];
    C4 = [0.5;-1;0;1];
    
    cuadrado = [P1 P2 P3 P4 P1];
    cabeza = [C1 C2 C3 C4 C1];
    
    Tl = transformacion(x, y,theta);
    cuadradoE0 = Tl * cuadrado;
  
    T2 = transformacion(2,0,0);
    cabeza_LR = T2 * cabeza;
    cabeza_G = Tl * cabeza_LR;
    
    %Borrar pantalla
    cla
    
    %pintar los elementos necesarios
    plot(cuadradoE0(1,:), cuadradoE0(2,:));
    
    hold on;
    
    plot(cabeza_G(1,:), cabeza_G(2,:));
    
    
    %Definir los ejes
    axis([-20 20 -20 20]);
    
    hold on;
       
    %pintar grafica
    drawnow
end
