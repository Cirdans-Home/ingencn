function plotfunc(f,a,b)
%PLOTFUNC Stampa a schermo la funzione f

if ~isa(f,'function_handle')
    error("Wrong input, f has to be an handle");
end

xvec = linspace(a,b,100);
figure();
plot(xvec,f(xvec),'-',xvec,0*xvec,'--','LineWidth',2)

end

