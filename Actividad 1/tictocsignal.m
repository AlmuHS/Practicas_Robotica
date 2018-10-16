tstart = tic
i = 1;
tiempo(i) = 0;
tiempo(i) = toc(tstart);

while tiempo(i) < 6*pi
    i = i + 1;
    tiempo(i) = toc(tstart);
    y = signal(90,tiempo);
    plot(tiempo,y)
    drawnow;
end