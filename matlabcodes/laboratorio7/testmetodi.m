%% TEST DEI METODI DI PUNTO FISSO

clear; clc; close all;

A = gallery('poisson',10); % Matrice di prova
b = ones(10^2,1);           % rhs vettore di 1
x = zeros(10^2,1);          % Tentativo iniziale vettore di 0
[x,res,it] = jacobi(A,b,x,1000,1e-6);

figure(1)
semilogy(1:it,res,'o-','LineWidth',2);
xlabel('Iterazione');
ylabel('Residuo');

%% FORWARDGS

A = gallery('poisson',10); % Matrice di prova
b = ones(10^2,1);           % rhs vettore di 1
x = zeros(10^2,1);          % Tentativo iniziale vettore di 0
[x,res,it] = forwardgs(A,b,x,1000,1e-6);

figure(1)
semilogy(1:it,res,'o-','LineWidth',2);
xlabel('Iterazione');
ylabel('Residuo');