%% Test della versione di Doolittle dell'algoritmo LU  

clear; clc;

A = [ 3 -1  4;
     -2  0  5;
      7  2 -2 ];
[L,U] = doolittlelu(A);
fprintf("|| A - LU || = %1.2e\n",norm(A - L*U,2));

% Vediamone gli ingressi:
format rat
disp(A)
disp(L)
disp(U)
disp(L*U)
format short