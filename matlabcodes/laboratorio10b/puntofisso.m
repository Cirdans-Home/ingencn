function [c,residuo] = puntofisso(g,x0,maxit,tol)
%%Implementazione del metodo di punto fisso con funzione g
% Input:  g function handle della funzione di cui si cerca il punto fisso
%         x0 approssimazione iniziale
%         maxit numero massimo di iterazioni consentite
%         tol tolleranza sul residuo
% Output: c radici candidate prodotte dal metodo
%         residuo vettore dei residui prodotto dal metodo

c = zeros(maxit,1);
residuo = zeros(maxit,1);

c(1) = x0;
residuo(1)  = abs(g(c(1))-c(1));
fprintf('Iterata %d\tc = %f\tresiduo = %e\n',1,c(1),residuo(1));
if residuo(1) < tol
    c = c(1);
    residuo = residuo(1);
    return
end

for i=2:maxit
    c(i) = g(c(i-1));
    residuo(i) = abs(g(c(i))-c(i));
    if residuo(i) < tol
        c = c(1:i);
        residuo = residuo(1:i);
        fprintf('\tConvergenza raggiunta in %d iterazioni\n',i);
        return
    end
    
end
fprintf('\tRaggiunto il massimo numero di iterazioni\n');
end