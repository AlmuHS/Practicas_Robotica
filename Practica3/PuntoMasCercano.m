function orden_minimo= PuntoMasCercano (path, punto);

distancia=sqrt((punto(1)-path(:,1)).^2+(punto(2)-path(:,2)).^2);
%analizar posible fallo sqrt
[minimo orden_minimo]=min(sqrt(distancia));

end