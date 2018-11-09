%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Configuración del sensor de ultrasonido
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Declara el sensor sonar

OpenUltrasonic(SENSOR_4);

clear t; % limpia la variable que se utilizará para el tiempo
clear distancia; % limpia la variable que se utilizará para la distancia
i=1;
tstart = tic; %arranca el crono
distancia(i) = GetUltrasonic(SENSOR_4); %medida en el instante inicial
t(i)=0; %instante inicial

while  t(i)<10
    i=i+1;
    distancia(i) = GetUltrasonic(SENSOR_4);
    t(i)= toc(tstart);
end

plot(t,distancia(1,:),'r')

CloseSensor(SENSOR_4); %cierra el sensor


