f = @(x) x.^3+3*x-4;
ctrue = 1;
g1 = @(x) 4./(x.^2+3);
g2 = @(x) (4-3*x)./x.^2;

tol = 1e-7;
maxit = 100;
x0 = ctrue + 1e-6;
[c1,res1] = puntofisso(g1,x0,maxit,tol);
[c2,res2] = puntofisso(g2,x0,maxit,tol);

n1 = 1:length(res1);
n2 = 1:length(res2);
semilogy(n1,abs(c1-ctrue),'ro-',...
    n2,abs(c2-ctrue),'bx-','LineWidth',2);
legend({'Metodo con g1','Metodo con g2'},'FontSize',14);
xlabel('Iterazione')

dg1 = @(x) -8*x./(x.^2+3).^2;
dg2 = @(x) (3*x+8)./(x.^3);