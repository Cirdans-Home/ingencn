function [c,residuo] = bisezione(f,a,b,maxit,tol)
%%BISEZIONE applica il metodo di bisezione per il calcolo di f(x) = 0
% Input:  f function handle della funzione di cui si cerca lo zero
%         a estremo sinistro dell'intervallo
%         b estremo destro dell'intervallo
%         maxit numero massimo di iterazioni
%         tol tolleranza richiesta su abs(f(c))
% Output: c vettore dei valori trovato dall'algoritmo
%         residuo vettore che contiene tutti i residui abs(f(c))

fa = f(a);
fb = f(b);
if fa*fb > 0
    error("La funzione non rispetta la condizione agli estremi");
end

c       = zeros(maxit,1);
residuo = zeros(maxit,1);

c(1)        = (a+b)/2;
fc          = f(c(1));
residuo(1)  = abs(fc);
fprintf('Iterata %d\ta = %f\tb = %f\tc = %f\tresiduo = %f\n',...
    1,a,b,c(1),residuo(1));

if  residuo(1) < tol
    c = c(1);
    residuo = residuo(1);
    return
end

for i=2:maxit
    if fc*fa < 0
        b  = c(i-1);
%        fb = fc;
    else
        a = c(i-1);
        fa = fc;
    end
    c(i) = (a+b)/2;
    fc          = f(c(i));
    residuo(i)  = abs(fc);
    fprintf('Iterata %d\ta = %f\tb = %f\tc = %f\tresiduo = %e\n',...
        i,a,b,c(i),residuo(i));
    if  residuo(i) < tol
        c = c(1:i);
        residuo = residuo(1:i);
        fprintf('\tConvergenza raggiunta in %d iterazioni\n',i);
        return
    end
end
fprintf('\tRaggiunto il massimo numero di iterazioni');
end