%% Esercizio 5: Molle Ammortizzatore

clear; clc; close all;

csum = 12;   % s^-1
ksum = 1500; % s^-2

f = @(omega) omega.^4 + 2*csum*omega.^3 + 3.*ksum.*omega.^2 + ...
    csum*ksum.*omega + ksum^2;
fp = @(omega) 4*omega.^3 + 6*csum*omega.^2 + 6.*ksum.*omega + ...
    csum*ksum;
oscillatore = @(w,t) exp(real(w).*t).*cos(imag(w).*t);


%% Visualiziamo la mappa
newtonfractal(f,fp,[-100 100 -100 100],600,600)

%% Applichiamo il metodo di Newton
%x0    = -11 +60i;
%x0 = - 1i;
%x0 = + 1i;
x0    = -11 -60i;
maxit = 200;
tol   = 1e-6;
[c,residuo] = newton(f,fp,x0,maxit,tol);
fprintf("La radice trovate è %f + %f i\n",real(c(end)),imag(c(end)));

figure(2)
t = linspace(0,2*pi,200);
plot(t,oscillatore(c(end),t),'-','LineWidth',2);
axis([min(t) max(t) -1 1]);

figure(1)
hold on
plot(real(c(end)),imag(c(end)),'w+','MarkerSize',14);
hold off

%% Usiamo il comando roots per trovare tutte le radici

coeff = [1 2*csum 3*ksum csum*ksum ksum^2];
r = roots(coeff);

