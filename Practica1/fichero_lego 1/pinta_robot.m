%la primera fila tendra las coordenadas x

function pinta_robot(x,y,theta,alfa)
    %robot
    P1=[3.5 2.5 0 1]'
    P2=[-3.5 2.5 0 1]'
    P3=[-3.5 -2.5 0 1]'
    P4=[3.5 -2.5 0 1]'
    rob=[P1 P2 P3 P4 P1]
    %cabeza
    P5=[0.5 1 0 1]'
    P6=[-0.5 1 0 1]'
    P7=[-0.5 -1 0 1]'
    P8=[0.5 -1 0 1]'
    cab=[P5 P6 P7 P8 P5]
    cla
    T=transformacion(2,0,alfa)
    cab_l=T*cab
    cab_g=transformacion(x,y,theta)*cab_l
    
    rob_g=transformacion(x,y,theta)*rob
    
    plot(rob_g(1,:), rob_g(2,:),'R')
    hold on
    plot(cab_g(1,:), cab_g(2,:),'B')
    axis([-20,20,-20,20])
    drawnow
    
    
end
