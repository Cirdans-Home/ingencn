function [c,residuo] = newton(f,fp,x0,maxit,tol)
%%NEWTON Implementazione del metodo di Newton
% Input:  f function handle della funzione di cui si cerca lo zero
%         fp function handle della derivata prima della funzione
%         x0 approssimazione iniziale
%         maxit numero massimo di iterazioni consentite
%         tol tolleranza sul residuo
% Output: c radici candidate prodotte dal metodo
%         residuo vettore dei residui prodotto dal metodo

c = zeros(maxit,1);
residuo = zeros(maxit,1);

c(1)        = x0;
fc          = f(c(1));
residuo(1)  = abs(fc);
fprintf('Iterata %d\tc = %f\tresiduo = %e\n',...
    1,c(1),residuo(1));
if residuo(1) < tol
    c       = c(1);
    residuo = residuo(1);
    return
end

for i=2:maxit
    c(i) = c(i-1) - fc/fp(c(i-1));
    fc = f(c(i));
    residuo(i) = abs(fc);
    fprintf('Iterata %d\tc = %f\tresiduo = %e\n',...
        i,c(i),residuo(i));
    if residuo(i) < tol
        c = c(1:i);
        residuo = residuo(1:i);
        fprintf('\tConvergenza raggiunta in %d iterazioni\n',i);
        return
    end
    
end
fprintf('\tRaggiunto il massimo numero di iterazioni');
end