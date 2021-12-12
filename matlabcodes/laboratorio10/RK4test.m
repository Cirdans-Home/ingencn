%% Il metodo di RK4

clear; clc; close all;

f = @(x,y) - (2*y + (x^2)*(y^2))/(x);
ytrue = @(x) 1./(x.^2.*(log(x)+1));

a = 1;
b = 2;
h  = 1e-2;
y0 = 1;
[y,x] = RK4(f,y0,a,b,h);

figure(1)
plot(x,y,'r--',x,ytrue(x),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
figure(2)
semilogy(x,abs(y-ytrue(x)),'r-','LineWidth',2);
xlabel('x');
ylabel('Errore Assoluto');

%% Convergenza
k = 9;
h = fliplr(logspace(-6,-1,k));
err = zeros(k,1);
errRK = zeros(k,1);
for i=1:k
    [y,x] = expliciteuler(f,y0,a,b,h(i));
    [yrk,xrk] = RK4(f,y0,a,b,h(i));
    yt = ytrue(x);
    err(i) = norm(y - yt)/norm(yt);
    errRK(i) = norm(yrk - yt)/norm(yt);
end

figure(3)
loglog(h,err,'o-',h,errRK,'x-','LineWidth',2);
xlabel('h')
ylabel('Errore Relativo');