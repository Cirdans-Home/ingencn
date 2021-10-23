%% Test del metodo di bisezione

clear; clc;

f = @(x) x.^3 -x -2;
a = 1;
b = 2;
maxit = 200;
tol = 1e-6;

[c,residuo] = bisezione(f,a,b,maxit,tol);

%% Convergenza
ctrue = 1.52137970680456757;
n = 1:length(residuo);
figure(1);
semilogy(n,residuo,'x--',...
    n,abs(c-ctrue),'ro--',...
    n,abs(b-a)./(2.^n),'k-','LineWidth',2)
xlabel('Iterazione n');
legend({'Residuo del metodo','Errore Assoluto c','Bound'},...
    'FontSize',16);
axis tight

%% Stima Numerica

f = @(x) x.^3 - 2*x - 5;
a = 1;
b = 3;
maxit = 200;
tol = 1e-6;

ctrue = 2.09455148154232659;
[c,residuo] = bisezione(f,a,b,maxit,tol);

figure(2)
n = 1:length(residuo);
semilogy(n,residuo,'x--',...
    n,abs(c-ctrue),'ro--',...
    n,abs(b-a)./(2.^n),'k-','LineWidth',2)
xlabel('Iterazione n');
legend('Residuo del metodo','Errore Assoluto c','Bound');
axis tight

x = linspace(a,b,200);
figure(3)
clf
hold on
plot(x,f(x),'b-','LineWidth',2);
for i=n
    plot(c(i),f(c(i)),'ro');
    pause()
end
hold off