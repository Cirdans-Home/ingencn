function ydot = veicolo(x,y)
%VEICOLO Dinamica per il veicolo in coordinate polari.
%   INPUT:  x variabile muta
%           y vettore delle variabili y = [r rdot theta thetadot]
%   OUTPUT: dinamica del sistema

ydot = zeros(4,1);
ydot(1) = y(2);
ydot(2) = y(1)*y(4)^2 - 3.9860e14/y(1)^2;
ydot(3) = y(4);
ydot(4) = -2*y(2)*y(4)/y(1);

end