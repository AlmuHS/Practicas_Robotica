clear tcurrent

tstart = tic
i = 1;
tcurrent(i) = 0;
tcurrent(i) = toc(tstart);

x = 0;

while tcurrent(i) < 30
    i = i+1;
    cla
	tcurrent(i) = toc(tstart);
    x = x + 0.005;
    
    y = sin(tcurrent);
   
    plot(tcurrent, y, 'b');
    drawnow
    
    y = sin(x);
    
    hold on
    plot(x,y,'r:*');
        
	drawnow
    hold on
end

