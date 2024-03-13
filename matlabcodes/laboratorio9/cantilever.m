%% Esercizio sulle frequenze oscillatorie della trave

clear; clc; % Puliamo l'ambiente di lavoro

f = @(beta) cosh(beta).*cos(beta) + 1;

%% Facciamo un grafico della funzione per determinare la posizione degli 0
figure(1)
beta = linspace(0,8,100);
plot(beta,f(beta),'-',beta,0*beta,'--','LineWidth',2);

%% Selezioniamo il primo:
a = 1.5;
b = 2.5;
%a = 4.6;
%b = 4.7;
%a = 7;
%b = 8;
maxit = 100;
tol = 1e-13;
[c,residuo] = bisezione(f,a,b,maxit,tol);

%% Il valore di \beta cercato è:
betastar = c(end);

%% Inseriamo i dati relativi alla trave:
rho = 7850;   % kg/m^3
E = 200*1e+9; % Pascal a.k.a. N/m^2
L = 0.9;    % m
b = 25*1e-3; % 25 mm
h = 2.5*1e-3; % 2.5 mm
%I = (b*h/12)*(h^2*cos(pi/4)^2+b^2*sin(pi/4)^2);
I = (b*h^3)/12;
m = b*h*L*rho;

f = (betastar^2)*sqrt( (E*I)/(m*L^3) )/(2*pi);

fprintf("La frequenza è di %.2f Hz\n",f);