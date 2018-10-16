tstart = tic
tcurrent = toc(tstart)

g = 0

%x = 0:0.1:0;
x = 0;
p = 0;
y = sin(x);

axis([0 2*pi -1.5 1.5])

while tcurrent < 10
    cla
	tcurrent = toc(tstart);
	x = x+2*pi/10;
   
    if x==2*pi
        x = 0;
    end
    
    
    %p = p+2*pi/10;
    
    %if p == 2*pi
    %    p = 0;
    %end
    
    %x = 0:0.1:p;
    
    y = sin(x);
    
    axis manual
    hold on
    plot(x,y,'r:*'); %xlim([0 2*pi]); ylim([-1.5 1.5])
        
	drawnow
    hold on
end