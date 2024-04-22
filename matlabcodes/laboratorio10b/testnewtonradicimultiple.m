%% Script di test per il metodo di Newton modificato

clear; clc;

f = @(x) x.^3 + 2*x.^2 -7*x + 4;
fp = @(x) 3*x.^2 +4*x -7;
maxit = 200;
tol = 1e-6;

ctrue = 1;

x0 = 2;
[c,residuo] = newton(f,fp,x0,maxit,tol);

x0 = 2;
q = 2;
[cm,residuom] = mnewton(f,fp,x0,q,maxit,tol);

q = convergenza(c,ctrue);
qm = convergenza(cm,ctrue);

figure(1)
subplot(1,2,1)
semilogy(1:length(residuo),residuo,'o-',...
    1:length(residuom),residuom,'x-','LineWidth',2);
xlabel('Iterazione')
ylabel('Errore Assoluto')
legend({'Newton','Newton Modificato'},'FontSize',16,...
    'Location','southeast');
subplot(1,2,2)
semilogy(3:length(residuo),q,'o-',...
    3:length(residuom),qm,'x-',...
    1:14,ones(14,1),'k--',...
    1:14,2*ones(14,1),'k--','LineWidth',2);
xlabel('Iterazione')
ylabel('Ordine di Convergenza Stimato')
legend({'Newton','Newton Modificato'},'FontSize',16,...
    'Location','southeast');
axis([1 14 0.8 2.2])
