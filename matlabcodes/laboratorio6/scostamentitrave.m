%% Scostamenti trave:

clear; clc; close all;

K = [27.58  7.004 -7.004 0 0
     7.004 29.57  -5.253 0 -24.32
    -7.004 -5.253 29.57  0 0
    0 0 0 27.58 -7.004
    0 -24.32 0 -7.004 29.57];
p = [0 0 0 0 -45]'; % kN

[L,U,P] = ludecomp(K);

u = backwardsolve(U,forwardsolve(L,P*p));

figure(1)
bar(u)
xlabel('$u_i$','Interpreter','latex');