%% ANALISI CONVERGENZA

clear; clc; close all;

A = gallery('poisson',10); % Matrice di prova
b = ones(10^2,1);           % rhs vettore di 1
x = zeros(10^2,1);          % Tentativo iniziale vettore di 0

tic;
[xjacobi,resjacobi,itjacobi] = jacobi(A,b,x,1000,1e-6);
timejacobi = toc;
tic;
[xforwardgs,resforwardgs,itforwardgs] = forwardgs(A,b,x,1000,1e-6);
timeforwardgs = toc;

figure(1)
semilogy(1:itjacobi,resjacobi,'o-',...
    1:itforwardgs,resforwardgs,'x-', 'LineWidth',2);
xlabel('Iterazione');
ylabel('Residuo');
legend({'Jacobi','Gauss-Seidel (Forward)'},...
    'Location','northeast',...
    'FontSize',14);

%% Paragone dei raggi spettrali

M = diag(diag(A)); % Jacobi
N = M - A;
rhojacobi = eigs(N,M,1,'largestabs');

M = tril(A); % Gauss-Seidel (forward)
N = M - A;
rhoforwardgs = eigs(N,M,1,'largestabs');

fprintf('Il raggio spettrale per Jacobi è %f\n',abs(rhojacobi));
fprintf('Il raggio spettrale per Gauss-Seidel è %f\n',abs(rhoforwardgs));

%% Informazioni sui tempi di esecuzione
fprintf('Il tempo per Jacobi è %f s\n',timejacobi);
fprintf('Il tempo per Gauss-Seidel è %f s\n',timeforwardgs);
