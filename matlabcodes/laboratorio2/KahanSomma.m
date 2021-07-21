function [somma] = KahanSomma(input)
%%KAHANSOMMA algoritmo delle somme compensate di Kahan
somma = 0.0;
c = 0.0;
for i=1:length(input)
    y = input(i) - c;
    t = somma + y;
    c = (t-somma)-y;
    somma = t;
end
end