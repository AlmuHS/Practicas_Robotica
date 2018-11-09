function out=signal(Amplitud,periodo, tiempo, desfase)
out=Amplitud*sin((tiempo-desfase)*(2*pi/periodo))
end
