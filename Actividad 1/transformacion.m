function T=transformacion(x0, y0, theta)
    T = [cos(theta), -sin(theta), 0, x0; sin(theta), cos(theta), 0, y0; 0,0,1,0; 0 0 0 1];
end