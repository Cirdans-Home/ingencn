function v = viswanath(n,v0,v1)
%VISWANATH Implementazione non ricorsiva della successione
% di Viswanath. Prende in input il numero n, i valori di v0 e v1 e
% restituisce un vettore che contiene tutti i numeri di Viswanath da v0 a vn.
switch n
    case 0
        v = v0;
    case 1
        v = [v0,v1];
    otherwise
        v = ones(n+1,1);
        for i=3:n+1
            v(i) = v(i-1) + sign(rand()-0.5)*v(i-2);
        end
end
end