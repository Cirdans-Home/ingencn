%% Test per il calcolo dei numeri di Bernoulli

clear; clc;

k = 12;
Bk = nbernoulli(k);
Btrue = bernoulli(0:2:2*k);

fprintf("L'errore in norma tra i numeri di Bernoulli è: %e\n",norm(Bk-Btrue.','inf'));

%% Verifichiamo lo svillupo della funzione
f = @(t) t./(exp(t) - 1);
fapprox = @(t) -0.5*t +  sum( (Bk./factorial(0:2:2*k).').*t.^((0:2:2*k).'),1);

t = linspace(0,1,100);
for i=1:length(t)
   fvalues(i) = fapprox(t(i)); 
end

figure(1)
subplot(1,2,1)
plot(t,f(t),'r-',t,fvalues,'b--','Linewidth',2)
xlabel('t')
legend({'Funzione','Approssimazione'},'FontSize',14);
subplot(1,2,2)
semilogy(t,abs(f(t)-fvalues),'ko-','Linewidth',2)
xlabel('t')
title('Errore Assoluto')