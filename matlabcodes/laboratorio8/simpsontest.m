%% Test della formula di quadratura di Simpson

f = @(x) x.^2.*sin(x).^3;
a = 0;
b = 3;
Itrue = 3.615857833947287;

n = logspace(1,4,4)+1;
errore = [];

for nval = n
    I = simpson(f,a,b,nval);
    errore = [errore,abs(I-Itrue)/Itrue];
end

h = (b-a)./n;
err = 200*(b-a)*h.^4/180;

figure(1)
loglog(n,errore,'o-',n,err,'r--','LineWidth',2);
xlabel('n');
ylabel('Errore');
legend({'Errore Misurato','Stima'},'FontSize',14)

%% Confronto con i Trapezi

f = @(x) x.^2.*sin(x).^3;
a = 0;
b = 3;
Itrue = 3.615857833947287;

n = logspace(1,4,4)+1;
erroresimpson = [];
erroretrapezi = [];

for nval = n
    Is = simpson(f,a,b,nval);
    It = trapezi(f,a,b,nval);
    erroretrapezi = [erroretrapezi,abs(It-Itrue)/Itrue]; 
    erroresimpson = [erroresimpson,abs(Is-Itrue)/Itrue];
end

figure(2)
loglog(n,erroretrapezi,'o-',n,erroresimpson,'rx-','LineWidth',2);
xlabel('n');
ylabel('Errore');
legend({'Trapezi','Simpson'},'FontSize',14)