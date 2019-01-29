function [power1 power2] = limita_potencia( power1, power2, limite )
%global limite
%limitamos que la potencia se mantega dentro de los l?mites.
    if power1>limite | power1<-limite
        if power1>limite
            prop=(power1-limite)/power1;
            power1=limite;

            if power2>0
                power2=power2-prop*power2;
            else
                power2=power2+prop*power2;
            end
        else
            prop=(power1+limite)/power1;
            power1=-limite;

            if power2>0
                power2=power2-prop*power2;
            else
                power2=power2+prop*power2;
            end
        end
    end

     if power2>limite | power2<-limite
         
        if power2>limite
            prop=(power2-limite)/power2;
            power2=limite;
         
            if power2>0
                power1=power1-prop*power1;
            else
                power1=power1+prop*power1;
            end
        else
            %comprueba=power2;
            prop=(power2+limite)/power2;
            power2=-limite;
            if power1>0
                power1=power1-prop*power1;
            else
                power1=power1+prop*power1;
            end
        end
     end


end

