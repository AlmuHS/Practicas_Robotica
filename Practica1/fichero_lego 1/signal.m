function out = signal(amplitud, tiempo, periodo, desfase)
        if (tiempo < desfase) | (tiempo >= periodo+desfase)
            out = 0:0;
        else
            out = amplitud*sin((2*pi/periodo)*(tiempo-desfase));
        end 
end