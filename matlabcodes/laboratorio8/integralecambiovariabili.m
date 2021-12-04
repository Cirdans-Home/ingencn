%% Integrale con cambio di variabili

clear; clc; close all;

Itrue = (pi - 2*acoth(sqrt(2)))/(4*sqrt(2));

f = @(t) 1./(3+3*t.^(4/3));

I = trapezi(f,0,1,2000000);

fprintf("(Trapezi) Il valore dell'integrale è %1.2f con un errore di %e.\n",...
    I,abs(I-Itrue)/abs(Itrue));

I = integral(f,0,1);

fprintf("(Matlab) Il valore dell'integrale è %1.2f con un errore di %e.\n",...
    I,abs(I-Itrue)/abs(Itrue));