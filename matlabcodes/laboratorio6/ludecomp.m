function [L,U,P] = ludecomp(A)
%%LUDECOMPP Fattorizzazione LU con pivoting parziale.

[n,m] = size(A);
if n ~= m
    error("La matrice deve essere quadrata!");
end

L = zeros(n);
U = zeros(n);
P = eye(n);

for k=1:n
    % Cerchiamo il pivot
    [~,r] = max(abs(A(k:end,k)));
    r = n-(n-k+1)+r; % Trasliamo l'indice in questione
    A([k r],:) = A([r k],:); % Scambiamo le righe di A
    P([k r],:) = P([r k],:); % Teniamone traccia nella matrice di permutazione
    L([k r],:) = L([r k],:); % Scambialo le righe di L
    % Dividiamo per il Pivot
    L(k:n,k) = A(k:n,k) / A(k,k);
    % Aggiorniamo le entrate della U
    U(k,1:n) = A(k,1:n);
    A(k+1:n,1:n) = A(k+1:n,1:n) - L(k+1:n,k)*A(k,1:n);
end
U(:,end) = A(:,end);

end
