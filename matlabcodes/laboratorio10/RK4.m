function [y,x] = RK4(f,y0,a,b,h)
%RK4 Implementazone del metodo di Runge-Kutta esplicito del quarto ordine.
% INPUT:
%        f   = handle della funzione che specifica l'equazione
%            differenziale f(x,y) = [dy1/dx dy2/dx dy3/dx ...].
%        y0  = vettore dei valori iniziali
%        a,b = estremi dell'intervallo di integrazione
%        h   = passo di integrazione
% OUTPUT:
%        y = valori calcolati della soluzione nei corrispondenti valori
%            della x
%        x = valori della x nei quali è stata calcolata la soluzione


x = a:h:b; 
N = length(x);
y = zeros(length(y0),N);
y(:,1) = y0;
for i=1:N-1
    K1 = h*f(x(i),y(:,i));
    K2 = h*f(x(i) + h/2,y(:,i) + K1/2);
    K3 = h*f(x(i) + h/2,y(:,i) + K2/2);
    K4 = h*f(x(i)+h,y(:,i) + K3);
    y(:,i+1) = y(:,i) + (K1 + 2*K2 + 2*K3 + K4)/6;
end

end