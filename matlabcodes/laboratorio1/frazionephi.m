function phi = frazionephi(n)
%%FRAZIONEPHI prende in input il numero di termini da utilizzare
%nell'approssimazione con frazione continua della sezione aurea e
%restituisce l'approssimazione.

phi = 2;
for i=1:n
   phi = 1 + 1/phi; 
end

end