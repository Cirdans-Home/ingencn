%% Hilbert Test

clear; clc; close all;

% Senza pivoting
err = 0;
n = 1;
while err <= 1e-6
    n = n+1;
    H = hilb(n);
    xtrue = ones(n,1);
    b = H*xtrue;
    [L,U] = doolittlelu(H);
    x = backwardsolve(U,forwardsolve(L,b));
    err = norm(x - xtrue);
    fprintf('Con dimensione %d abbiamo raggiunto un errore di %1.2e (no-pivoting)\n',n,err);
end


% Con pivoting
err = 0;
n = 1;
while err <= 1e-6
    n = n+1;
    H = hilb(n);
    xtrue = ones(n,1);
    b = H*xtrue;
    [L,U,P] = ludecomp(H);
    x = backwardsolve(U,forwardsolve(L,P*b));
    err = norm(x - xtrue);
    fprintf('Con dimensione %d abbiamo raggiunto un errore di %1.2e (pivoting)\n',n,err);
end
