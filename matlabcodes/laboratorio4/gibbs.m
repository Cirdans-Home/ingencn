%% Esercizio 4: Energia libera di Gibbs


R  = 8.31441; % J/K
T0 = 4.44418; % K
G  = -1e5;    % J
f = @(T) G + R.*T.*log((T./T0).^(5/2));
fp = @(T) R.*log((T./T0).^(5/2)) + 5*R/2;

%% Visualiziamo la funzione
T = linspace(0,1000,100);
plot(T,f(T),'LineWidth',2);

%% Applichiamo il metodo di Newton
x0    = 500;
maxit = 200;
tol   = 1e-6;
[c,residuo] = newton(f,fp,x0,maxit,tol);