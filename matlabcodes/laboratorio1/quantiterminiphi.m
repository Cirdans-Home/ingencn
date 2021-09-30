function [n,phi] = quantiterminiphi(tol)
%%QUANTITERMINIPHI data in input una tolleranza tol sulla distanza tra
%l'approssimazione della costante phi e il valore reale questa funzione
%ci restituisce il numero di termini necessari e il valore dell'approssimazione

phitrue = 1.6180339887498949;
phi = 2;
n = 0;
while( abs(phi-phitrue) > tol )
    n = n + 1;
    phi = 1 + 1/phi;
end


end