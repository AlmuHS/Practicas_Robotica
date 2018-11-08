tstart = tic;
tcurrent = toc(tstart);

s = 0:0.01:2*pi;
x = 0;
y = sin(x);

axis([0 2*pi -1.5 1.5]);

while tcurrent < 6*pi
    cla
	tcurrent = toc(tstart);
    x = x + 0.005;
    
    if x >= 2*pi
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
end