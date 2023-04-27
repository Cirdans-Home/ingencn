%% Test per la soluzione di sistemi triangolari

clear; clc; close all;

%% Sostituzione in avanti
n = 10;
A = tril(ones(n,n));
b = (1:n).';
x = forwardsolve(A,b);

fprintf("Avanti: Errore sulla soluzione è: %1.2e\n",norm(A*x-b));

%% Sostituzione all'indietro
n = 10;
A = triu(ones(n,n));
b = (1:n).';
x = backwardsolve(A,b);

fprintf("Indietro: Errore sulla soluzione è: %1.2e\n",norm(A*x-b));