tstart = tic
tcurrent = toc(tstart)

g = 0
s = 0:0.1:2*pi;
x = 0;
y = sin(x);

axis([0 2*pi -1.5 1.5])

while tcurrent < 10
    cla
	tcurrent = toc(tstart);
	x = x+pi/10;
    %x = x + 1;
    
    if x>=2*pi
        x = 0;
    end
    
    y = sin(s);
    
    plot(s, y, 'b');
    drawnow
    
    y = sin(x);
    
    axis manual
    hold on
    plot(x,y,'r:*'); %xlim([0 2*pi]); ylim([-1.5 1.5])
        
	drawnow
    hold on
    
    pause(0.05);
end