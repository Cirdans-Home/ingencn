%% Test del metodo dei Trapezi

clear; clc; close all;

f = @(x) 4*sqrt(1-x.^2);
a = 0;
b = 1;

n = 10;
I = trapezi(f,a,b,n);

fprintf('Errore: %e\n',abs(pi-I)/pi);

%% Convergenza : versione 1

n = logspace(1,4,4);
errore = [];

for nval = n
    I = trapezi(f,a,b,nval);
    errore = [errore,abs(I-pi)/pi];
end

h = (b-a)./n;
err = (b-a)*h.^2/12;

figure(1)
loglog(n,errore,'o-',n,err/errore(1),'r--','LineWidth',2);
xlabel('n');
ylabel('Errore');
legend({'Errore Misurato','Stima'},'FontSize',14)

%% Convergenza : versione 2

f = @(x) x.^2.*sin(x).^3;
a = 0;
b = 3;
Itrue = 3.615857833947287;

n = logspace(1,4,4);
errore = [];

for nval = n
    I = trapezi(f,a,b,nval);
    errore = [errore,abs(I-Itrue)/Itrue];
end

h = (b-a)./n;
err = 10*(b-a)*h.^2/12;

figure(2)
loglog(n,errore,'o-',n,err,'r--','LineWidth',2);
xlabel('n');
ylabel('Errore');
legend({'Errore Misurato','Stima'},'FontSize',14)