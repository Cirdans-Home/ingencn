%% Il metodo di Eulero implicito
f = @(x,y) - (2*y + (x^2)*(y^2))/(x);
ytrue = @(x) 1./(x.^2.*(log(x)+1));

a = 1;
b = 2;
h  = 1e-2;
y0 = 1;
[y,x] = impliciteuler(f,y0,a,b,h);

figure(1)
plot(x,y,'r--',x,ytrue(x),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
figure(2)
semilogy(x,abs(y-ytrue(x)),'r-','LineWidth',2);
xlabel('x');
ylabel('Errore Assoluto');

%% Convergenza
k = 7;
h = fliplr(logspace(-4,-1,k));
err = zeros(k,1);
for i=1:k
    [y,x] = impliciteuler(f,y0,a,b,h(i));
    yt = ytrue(x);
    err(i) = norm(y - yt)/norm(yt);
end

figure(3)
loglog(h,err,'o-');
xlabel('h')
ylabel('Errore Assoluto');

q = convergenza2(err);

%% Errore di stabilità
a = 1;
b = 2;
h  = 1e-1;
y0 = 10;

ytrue = @(x) 10./(x.^2.*(10*log(x)+1));

[y,x] = impliciteuler(f,y0,a,b,h);
[yexp,xexp] = expliciteuler(f,y0,a,b,h);

figure(1)
subplot(1,2,1);
plot(x,y,'r--',x,ytrue(x),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
title('Eulero implicito');
subplot(1,2,2);
plot(xexp,yexp,'r--',xexp,ytrue(xexp),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
title('Eulero esplicito')