%% Test dell'Algoritmo di Kahan

clear; clc;

input = [ 1e-16 +1 -1e-16];

somma1 = input(1)+input(2)+input(3);
somma2 = sum(input);
somma3 = KahanSomma(input);