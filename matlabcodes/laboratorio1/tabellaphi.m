%% Stampa tabella

clear; clc;

tol = logspace(-1,-10,10);
phitrue = 1.6180339887498949;

fprintf("Tolleranza\tTermini\tValore\n");
for i=1:length(tol)
    [n,phi] = quantiterminiphi(tol(i));
    fprintf("%e\t%-d\t%1.11f\n",tol(i),n,phi); 
    fprintf("\t\t\t%1.11f\n",phitrue);
end