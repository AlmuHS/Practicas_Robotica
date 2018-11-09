tstart=tic
i=1
tiempo(i)=0
while tiempo(i)<10
	theta(i)=signal(90,5,tiempo(i),0)
    theta_r(i)=(theta(i)/180)*pi
	i=i+1
	tiempo(i)=toc(tstart)
    cla
    pinta_robot(10,5,0,theta_r(i-1))
    hold on
    axis([-20,20,-20,20])
    drawnow
end
