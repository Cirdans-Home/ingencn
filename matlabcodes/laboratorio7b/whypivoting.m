%% Perché il pivoting

clear; clc; close all;

sizes = 100:100:1500;
N = length(sizes);
maxerr = zeros(N,1);
relerr = zeros(N,1);
for i = 1:N
   A = rand(sizes(i),sizes(i));
   [L,U] = doolittlelu(A);
   [Lm,Um] = lu(A);
   normA = norm(A,2);
   maxerr(i) = norm(A - L*U,2);
   relerr(i) = maxerr(i)/normA;
   fprintf("Dimensione %d\n\t || A - LU || = %1.2e\n",sizes(i),maxerr(i));
   fprintf("\t || A - LU ||/||A|| = %1.2e\n",relerr(i));
end

figure(1)
loglog(sizes,maxerr,'o-',sizes,relerr,'x-','LineWidth',2);
xlabel('Dimensione');
legend({'Errore Assoluto','Errore Relativo'},...
    'Location','best','FontSize',14);

%% Versione Codice MATLAB

sizes = 100:100:1500;
N = length(sizes);
maxerr = zeros(N,1);
relerr = zeros(N,1);
maxerrm = zeros(N,1);
relerrm = zeros(N,1);
for i = 1:N
   A = rand(sizes(i),sizes(i));
   [L,U] = doolittlelu(A);
   [Lm,Um,P] = ludecomp(A);
   normA = norm(A,2);
   maxerr(i) = norm(A - L*U,2);
   relerr(i) = maxerr(i)/normA;
   maxerrm(i) = norm(P*A - Lm*Um,2);
   relerrm(i) = maxerrm(i)/normA;
   fprintf("Dimensione %d\n \t || A - LU || = %1.2e\n",sizes(i),maxerr(i));
   fprintf("\t || A - LU ||/||A|| = %1.2e\n",relerr(i));
   fprintf("\t || P*A - LU ||/||A|| = %1.2e\n",maxerrm(i));
   fprintf("\t || P*A - LU ||/||A|| = %1.2e\n",relerrm(i));
end

figure(2)
loglog(sizes,maxerr,'o-',sizes,relerr,'x-',...
    sizes,maxerrm,'o-',sizes,relerrm,'x-','LineWidth',2);
xlabel('Dimensione');
legend({'Errore Assoluto','Errore Relativo',...
    'Errore Assoluto (Pivoting)','Errore Relativo (Pivoting)'},...
    'Location','best','FontSize',14);