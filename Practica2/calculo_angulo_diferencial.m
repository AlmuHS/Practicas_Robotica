r = 1;
R = 5;
l = 0.5;

V0 = 4;

angle_1 = (V0/r) * (1+l/R)
angle_2 = (V0/r) * (1-l/R)

X0 = 5;
Y0 = 5;
Theta0 = 0;

XF = 10
YF = 15

inc = (X0 - XF) * sin(Theta0) - (Y0 - YF) * cos(Theta0)
LH = sqrt((X0 - XF)^2 + (Y0 - YF)^2))

angle = atan(p * l)