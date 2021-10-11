%% Esercizio Bernoulli

clear; clc; close all;

% Dati del problema:
Q = 1.2; %m^3/s
g = 9.81; % m/s^2
b = 1.9; %m
h0 = 0.6; %m
H = 0.075; %m

% Funzione di cui cerchiamo lo zero:
f = @(h) Q^2./(2*g*b^2*h0^2) + h0 - Q^2./(2*g*b^2*h.^2) -h -H;

% Vediamo di individuare lo zero graficmamente:
h = linspace(0.1,3,200);
figure(1)
plot(h,f(h),'-',h,0*h,'--','LineWidth',2);

a = 0;
b = 0.5;
maxit = 100;
tol = 1e-13;
[c,residuo] = bisezione(f,a,b,maxit,tol);

fprintf('Il valore di h = %1.2f\n',c(end));