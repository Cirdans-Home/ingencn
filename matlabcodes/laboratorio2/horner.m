function y = horner(a,x)
%% HORNER Applica la regola di Horner per valutare un polinomio
n = length(a);
m = length(x);
result = a(1)*ones(1,m);
for j = 2:n
    result = result.*x + a(j);
end
y = result;
end