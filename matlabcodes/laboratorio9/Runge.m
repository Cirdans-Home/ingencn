clear

a = -5;
b = 5;
m = 500;
z = linspace(a,b,m);
f = @(w) 1./(1+w.^2);
d = [5,10,19];
P = zeros(length(d),m);
err = zeros(size(d));
for k = 1:length(d)
    n = d(k);
    % Nodi di interpolazione equidistanti
    %x = linspace(a,b,n+1);
    % Nodi di interpolazione di Chebyshev
    x = cos(((1:(n+1))-0.5).*pi./(n+1)) .* (b-a)/2 + (a+b)/2;
    y = f(x);

    for j = 1:length(x)
        lj = LagrangePoly(x,z,j);
        P(k,:) = P(k,:) + lj*y(j);
    end
    err(k) = max(abs(f(z) - P(k,:)));
end
figure;
plot(z,f(z),'-k',z,P);
xlabel('x');
legend('Exact','n = 5','n = 10','n = 19','Location','best');
figure; semilogy(d,err,'-o')
