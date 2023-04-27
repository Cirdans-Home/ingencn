function [L,U] = doolittlelu(A)
%%DOOLITTLELU Calcola la fattorizzazione LU della matrice A con i vincolo di
%Doolittle.

[n,m] = size(A);
if n ~= m
    error("La matrice non è quadrata!");
end

% Versione 1:
L = eye(n,n);
U = zeros(n,n);

for i = 1:n
    for j = 1:(i - 1)
        L(i,j) = (A(i,j) - L(i,1:(j - 1))*U(1:(j - 1),j)) / U(j,j);
    end
    U(i,i:n) = A(i,i:n) - L(i,1:(i - 1))*U(1:(i - 1),i:n);
end

% % Versione 2:
% L = zeros(n);
% U = zeros(n);
% for k=1:n
%     % Dividiamo per il Pivot
%     L(k:n,k) = A(k:n,k) / A(k,k);
%     % Aggiorniamo le entrate della U
%     U(k,1:n) = A(k,1:n);
%     A(k+1:n,1:n) = A(k+1:n,1:n) - L(k+1:n,k)*A(k,1:n);
% end
% U(:,end) = A(:,end);
% U = triu(U);
% L = tril(L);

end