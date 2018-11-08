tstart = tic
tcurrent = toc(tstart)

x = 0;

%Definimos los vertices

%Cara inferior
P1 = [1 1 0];
P2 = [1 -1 0];
P3 = [-1 -1 0];
P4 = [-1 1 0];

%Cara superior
P5 = [1 1 3];
P6 = [1 -1 3];
P7 = [-1 -1 3];
P8 = [-1 1 3];

%Creamos la matriz de vertices
V = [P1; P2; P3; P4; P5; P6; P7; P8];

%Creamos la matriz de caras
F = [3 7 6 2; 3 4 8 7; 4 8 5 1; 2 1 5 6; 2 3 4 1; 6 7 8 5];


axis([0 40*pi -1.5 100]);
axis manual  

while tcurrent < 20
    cla
	tcurrent = toc(tstart);
	x = x + pi/100;
	
	V = V + cos(x);

    hold on
	P = patch('Vertices', V, 'Faces', F, 'FaceColor', 'g'); %xlim([-40 40]); ylim([-40 40]); zlim([-40 40])
	view(3)
	drawnow
	%delete(P);
end
