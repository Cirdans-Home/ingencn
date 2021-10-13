%% Valutazione del polinomio con Roundoff

x = 0.988:.0001:1.012;
y1 = x.^7 - 7*x.^6 + 21*x.^5 - 35*x.^4 + 35*x.^3 -21*x.^2 + 7*x - 1 ;
figure(1)
subplot(1,2,1)
plot(x,y1)

%% Roundoff
y2 = (x-1).^7;
figure(1)
subplot(1,2,2)
plot(x,y2)

%% Paragone
figure(2)
plot(x,y1,'-',x,y2,'--','LineWidth',2);
legend({'Polinomio Esteso','Polinomio Raccolto'},...
    'Location','best','FontSize',18);