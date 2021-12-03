%% Test della funzione ricorsiva dei trapezi

clear; clc; close all;

f = @(x) x.^2.*sin(x).^3;
a = 0;
b = 3;
Itrue = 3.615857833947287;
tol = 1e-9;
kmax = 20;

I = trapeziricorsiva(f,a,b,kmax,tol);
fprintf("\n\tL'errore è %e\n",abs(I - Itrue)/Itrue);