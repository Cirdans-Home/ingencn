function I = trapeziricorsiva(f,a,b,kmax,tol)
%% TRAPEZIRICORSIVA calcola l'integrale di f tra a e b in modo
% ricorsivo. L'integrazione si ferma quando la differenza tra due
% ricorsioni successive è minore della tolleranza richiesta.
%   INPUT:  f = handle della funzione di integrare,
%           a,b = estremi di integrazione
%           kmax = massimo numero di livello di ricorsione
%           tol = tolleranza tra due livelli di ricorsione successivi

I2h = 0; k = 1;

Ih = trapezir(f,a,b,I2h,k);
fprintf('k = 1 Ih = %1.16f\n',Ih);

for k = 2:kmax
   I2h = Ih;
   Ih = trapezir(f,a,b,I2h,k);
   fprintf('k = %d Ih = %1.16f\n',k,Ih);
   if abs(Ih - I2h) < tol
       I = Ih;
       return
   end
end
warning("Non abbiamo raggiunto la tolleranza richiesta!");
I = Ih;


end