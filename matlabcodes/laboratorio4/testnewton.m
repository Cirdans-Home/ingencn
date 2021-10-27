%% Script di test per il metodo di Newton

clear; clc;

f = @(x) x.^3 - 2*x - 5;
fp = @(x) 3*x.^2 -2;
maxit = 200;
tol = 1e-6;

ctrue = 2.09455148154232659;

x0 = 3;
tic;
[c,residuo] = newton(f,fp,x0,maxit,tol);
tnewton = toc;
%% Paragone con il metodo di bisezione
a = 1;
b = 3;
maxit = 200;
tol = 1e-6;
tic;
[c2,residuo2] = bisezione(f,a,b,maxit,tol);
tbisezione = toc;

fprintf('T Newton %e (s) T Bisezione %e (s)\n',tnewton,tbisezione);

n = 1:length(residuo);
n2 = 1:length(residuo2);
semilogy(n,abs(c-ctrue),'ro-',...
    n2,abs(c2-ctrue),'bx-','LineWidth',2);
legend({'Metodo di Newton','Metodo di Bisezione'},'FontSize',14);
xlabel('Iterazione')

q = convergenza(c,ctrue);

%% Approssimazione della derivata

f = @(x) x.^3 - 2*x - 5;
fp = @(x) (f(x+sqrt(eps))-f(x))/sqrt(eps);
maxit = 200;
tol = 1e-6;

ctrue = 2.09455148154232659;

x0 = 3;
[c3,residuo3] = newton(f,fp,x0,maxit,tol);

figure(2)
semilogy(1:length(residuo),residuo,'r-',...
    1:length(residuo3),residuo3,'b--','LineWidth',2)
xlabel('Iterazione');
ylabel('Residui');
legend({'Derivata esatta','Derivata approssimata'},...
    'Location','southwest','FontSize',14);

