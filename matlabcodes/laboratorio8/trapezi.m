function I = trapezi(f,a,b,n)
%% TRAPEZI questa funzione implementa il metodo dei trapezi per la
% funzione f sull'intervallo a,b con n-1 intervalli.
%   INPUT: f function handle dell'integrando,
%          a,b estremi dell'intervallo di integrazione
%          n numero di intervalli + 1

x = linspace(a,b,n);
h = (b-a)/(n-1);
fx = f(x);
fx(2:end-1) = 2*fx(2:end-1);
I = h*sum(fx)/2;

end