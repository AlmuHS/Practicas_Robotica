clear all

tstart = tic;
i = 1;
tcurrent (i)= toc(tstart);
periodo=5;
desfase=2;
t = 0:0.1:periodo+desfase;;

y =  signal(10, t, periodo, desfase);

while tcurrent(i) < periodo+desfase;
    cla
    i = i+1;
    tcurrent (i)= toc(tstart);
    valor(i)= signal(10, tcurrent(i), periodo, desfase);
    
    axis([0 6*pi -10 10]);
    axis manual;
    
    plot(t, y);
    
    hold on;
  
    plot(tcurrent,valor,'g');
    
    plot(tcurrent(i),valor(i),'r:*');
        
	drawnow
    
   
end

