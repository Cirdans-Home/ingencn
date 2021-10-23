
clear; clc; close all;

L = 1000; % m
s = 1100; % m
gamma = 77*1e3;
f = @(beta) s/L - sinh(beta)./beta;

figure(1)
betavec = linspace(0,2,100);
plot(betavec,f(betavec),'-',betavec,0*betavec,'--');

%% Applichiamo il metodo di bisezione:
a = 0.6;
b = 1.2;
maxit = 100;
tol = 1e-12;
[betastar,residuo] = bisezione(f,a,b,maxit,tol);

%% Calcoliamo sigma_max
sigma0 = (gamma*L)/(2*betastar);
smax = sigma0*cosh(betastar);

fprintf('sigma_{max} = %1.2e\n',smax);