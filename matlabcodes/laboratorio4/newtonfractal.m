function newtonfractal(f,fp,range,WIDTH,HEIGHT)

nIteration = 200;
tolerance = 1e-9;
% Generiamo la griglia sull'asse delle x
x = linspace(range(1), range(2), WIDTH);
% Generiamo la griglia sull'asse delle y
y = linspace(range(3), range(4), HEIGHT);
% Creiamo una griglia 2D
[X,Y] = meshgrid(x, y);
% Allochiamo spazio per gli output
img = zeros(HEIGHT, WIDTH);
nPoint = HEIGHT * WIDTH;
tic
for n = 1 : nPoint
    k = 1;
    z0 = X(n) + 1i*Y(n);
    zn = z0 - f(z0)/fp(z0);
    while k < nIteration-1
        zn = zn - f(zn)/fp(zn);
        if abs(zn - z0) < tolerance
            break;
        end
        z0 = zn;
        k = k+1;
    end
    img(n) = k+1;
end
toc
imgMin = min(img(:));
imgMax = max(img(:));
colors = hot(imgMax);
colormap(colors);
imagesc(img);
colorbar;
axis tight equal
end