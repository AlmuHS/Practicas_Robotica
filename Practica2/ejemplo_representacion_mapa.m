%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejemplo de visualizaci�n de un mapa bmp colocando correctamente el origen
% de coordenadas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
%Carga el fichero  BMP

MAPA = imread('cuadro4.bmp');

%Transformaci�n para colocar correctamente el origen del Sistema de
%Referencia
MAPA(1:end,:,:)=MAPA(end:-1:1,:,:);
image(MAPA);
axis xy

%modificaci�n del MAPA Original para pintar un cuadrado gris de dimensiones
%50x50 en el origen
% MAPA(1:50,1:50,:)=125;
% figure
% image(MAPA);
% axis xy


%Creaci�n de un mapa
% mapa2=uint8(255*ones(100,100,3));
% mapa2(1:50,1:50,:)=125;
% figure
% image(mapa2)
% axis xy




