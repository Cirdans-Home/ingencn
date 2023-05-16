% Interpolazione di Lagrange dati i punti (x,y)
clear; close all; clc

x = [-5,-4,0,5];
y = [-1,-2,-16,0];
np = length(x);

m = 100;
z = linspace(-5,5,m);

P3 = zeros(1,m);
for j = 1:np
    lj = LagrangePoly(x,z,j);
    P3 = P3 + lj*y(j);
end
figure;
plot(z,P3,'-r')
hold on
plot(x,y,'sk')
xlabel('x');