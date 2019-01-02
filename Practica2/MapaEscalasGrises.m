%Creamos mapa de dimensiones 240x240
mapa2=uint8(255*ones(240,240,3));

%Creamos matriz de reescalado
%--Cada punto del mapa será 6x6--

NumPuntos=zeros(60,60);

%Leemos obstaculos y asignamos a cada punto del mapa reescalado el numero
%de obstaculos
x=-120;
for i=1:60
    filas=find( mapa(1,:,:)>x & mapa(1,:,:)<x+4 );
    y=-120;
    for j=1:60
        puntos=size ( find( mapa(2,filas,:)>y & mapa(2,filas,:)<y+4));
        y=y+4;
        NumPuntos(j,i)=puntos(2);
    end    
    x=x+4;
end

%Ponderamos los valores del mapa reescalado con 0P->blanco 7P->negro

for i=1:60
    for j=1:60
        mapa2((i*4-3):(i*4+1),(j*4-3):(j*4+1),:)=255-NumPuntos(i,j)*36;
    end
end

%Representamos el mapa

figure
image(mapa2)
axis xy
