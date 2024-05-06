function [c,residuo] = bisezione_classe(f,a,b,maxit,tol)
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

if abs(fa)<eps || abs(fb)<eps
    disp('Raggiunta convergenza')
    return
end

if fa*fb>0
    error("Le condizioni del teorema di Bolzano non sono verificate")
end

c = zeros(maxit,1);
residuo = zeros(maxit,1);

c(1) = (a+b)/2;
residuo(1) = abs(f(c(1)));
if residuo(1) < tol
    c = c(1);
    residuo = residuo(1);
    return
end

fc = f(c(1));
for it=2:maxit
    if fa*fc < 0
        b = c(it-1);
        fb = f(b);
    elseif fb*fc <0
        a = c(it-1);
        fa = f(a);
    end
    c(it) = (a+b)/2;
    fc = f(c(it));
    residuo(it) = abs(fc);
    if residuo(it)<tol
        c = c(1:it);
        residuo = residuo(1:it);
        return
    end
end
disp('Raggiunto numero massimo di iterazioni')







end