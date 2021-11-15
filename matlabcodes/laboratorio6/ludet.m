function res = ludet(A)
%%LUDET Calcola il determinante della matrice A sfruttando la sua fattorizzazione
%LU in forma di Doolittle e senza pivoting.
[~,U] = doolittlelu(A);

res = prod(diag(U));

end