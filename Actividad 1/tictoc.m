tstart = tic
tcurrent = toc(tstart)
%x = 0:0.1:0;
x = 0;
p = 0;
y = sin(x);

axis([0 2*pi -1.5 1.5])

while tcurrent < 20
	tcurrent = toc(tstart);
	x = x+pi/10;
	%p = p+pi/10;
    %x = 0:0.1:p+pi/10;
    y = sin(x);
    axis manual  
    plot(x,y,'r:+'); xlim([0 2*pi]); ylim([-1.5 1.5])
    pause(1)
end
