function out=signal(Amplitud,periodo, tiempo, desfase)
    if tiempo < desfase | tiempo >=periodo+desfase
        out=0:0;
    else    
        out=Amplitud*sin((tiempo-desfase)*(2*pi/periodo))
    end;
end
