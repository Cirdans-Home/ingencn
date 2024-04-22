function I = simpson(f,a,b,n)
%%SIMPSON calcolo dell'integrale della funzione f tra a e b mediante la
% formula di Simpson.
%   INPUT:  f = handle della funzione di integrare,
%           a,b = estremi di integrazione
%           n numero di intervalli

if mod(n+1,2) ~= 1
    error('n deve essere pari');
end

x = linspace(a,b,n+1);
h=(b-a)/n; 
fx = f(x);
I= h/3*(fx(1)+2*sum(fx(3:2:end-2))+4*sum(fx(2:2:end))+fx(end));

end