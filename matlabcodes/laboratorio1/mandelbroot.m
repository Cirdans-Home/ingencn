%% Insieme di Mandelbroot

h = waitbar(0,'Calcolo in corso...');
n = 400;
it_max = 1000;
x = linspace(-2.1,0.6,n);
y = linspace(-1.1,1.1,n);
[X,Y] = meshgrid(x,y);
C = complex(X,Y);

Z_max = 1e6; 
Z = C;
for k = 1:it_max
   Z = Z.^2 + C;
    waitbar(k/it_max);
end
close(h)

contourf(x,y,double(abs(Z)<Z_max))
title('Insieme di Mandelbroot')