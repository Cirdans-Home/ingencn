%% Valutazione del polinomio con Roundoff

x = 0.988:.0001:1.012;
y = x.^7 - 7*x.^6 + 21*x.^5 - 35*x.^4 + 35*x.^3 -21*x.^2 + 7*x - 1 ;
figure(1)
subplot(1,2,1)
plot(x,y)

%% Roundoff
y = (x-1).^7;
figure(1)
subplot(1,2,2)
plot(x,y)