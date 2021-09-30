%% Test della successione di Viswanath

n = 1000; % Numero di termini

% Calcoliamo la successione di Fibonacci
f = fibonaccinonrecursive(n);

% Calcoliamo la successione di Viswanath
v0 = 1;
v1 = 1;
v = viswanath(n,v0,v1);

% Valore asintotico
c = 1.13198824;
phi = (1+sqrt(5))/2;
figure(1)
semilogy(0:n,abs(v),'o',0:n,c.^(1:n+1),'-',0:n,f,'x',0:n,phi.^(1:n+1),'-');
legend({'Viswanath','Stima Asintotica','Fibonacci','Stima Asintotica'},...
    'Location','northwest')