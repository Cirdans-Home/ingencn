function Ih = trapezir(f,a,b,I2h,k)
%%TRAPEZIR implementa l'algoritmo ricorsivo della regola dei
%trapezi.
%   INPUT:  f = handle della funzione da integrare,
%           a,b = limiti di integrazione
%           I2h = integrale su 2^{k-1} intervalli
%           Ih = integralae calcolo su 2^k intervalli
%           k  = livello di ricorsione

if k == 1
    Ih = (f(a) + f(b))*(b - a)/2.0;
else
    n = 2^(k -2);  % Numero dei nuovi punti:
    h = (b - a)/n ; % Spaziatura
    x = a + h/2.0;  % Coordinata del primo dei nuovi punti
%     sum = 0.0;
%     for i = 1:n
%         fx = f(x);
%         sum = sum + fx;
%         x = x + h;
%     end
    % Versione senza ciclo for:
    x = x + (0:(n-1))*h;
    fx = f(x);
    Inew = sum(fx);
    Ih = (I2h + h*Inew)/2.0;
    % Ih = (I2h + h*sum)/2.0; % Version con ciclo for
end

end