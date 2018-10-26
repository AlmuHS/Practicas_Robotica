clear all

tstart = tic;

P1 = [1;1;0;1];
P2 = [-1;1;0;1];
P3 = [-1;-1;0;1];
P4 = [1;-1;0;1];

cuadrado = [P1 P2 P3 P4 P1]
i = 1;
tiempo(i) = 0;
theta(i) = 0;

desfase = 3;
periodo = 15;
amplitud = 360;  

while tiempo(i) < periodo + desfase;
    cla
    i = i+1;
    tiempo(i) = toc(tstart);
    theta(i) = signal(amplitud, tiempo(i), periodo, desfase) *(pi/180);
    Tl = transformacion(25,20,theta(i));
    cuadradoE0 = Tl * cuadrado;
        
    pinta_robot(10, 5, pi/4, theta(i));
end

