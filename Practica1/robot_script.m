clear tstart
clear anguloCabeza

tstart = tic;

%Definir motores y sensores
motorCabeza = NXTMotor('C');
motorRuedaIzq = NXTMotor('B');
motorRuedaDer = NXTMotor('A');

i = 0;
tiempo(i) = 0;

A = 0;
B = 1;
C = 2;

tiempo(i) = toc(tstart);

while tiempo(i) < 2
    i = i+1;
    tiempo(i) = toc(tstart);
    
    %Leer encoder cabeza -> Angulo_Cabeza[i]
    anguloCabeza(i) = NXT_GetOutputState(B); 
    
    %Mandar orden motor cabeza -> POWER = 50
    motorCabeza.Power = 50;
    motorCabeza.SendToNXT();
    
    
    pinta_robot(0, 0, 0, anguloCabeza(i));
    
end

%Parar motor cabeza
motorCabeza.Stop('off'); 

plot(tiempo, AnguloCabeza);