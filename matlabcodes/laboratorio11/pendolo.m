%% Pendolo

clear; clc; close all;

L = 1; %m
g = 9.81; %m/s^2

f = @(theta,theta0) 1./sqrt(1-(sind(theta0/2).^2).*(sin(theta).^2));

h15 = simpson(@(theta) f(theta,15),0,pi/2,1001); 
h30 = simpson(@(theta) f(theta,30),0,pi/2,1001);
h45 = simpson(@(theta) f(theta,45),0,pi/2,1001);
%h15 = integral(@(theta) f(theta,15),0,pi/2); 
%h30 = integral(@(theta) f(theta,30),0,pi/2);
%h45 = integral(@(theta) f(theta,45),0,pi/2);
hsmall = pi/2;

tau = @(h) 4*sqrt(L/g)*h;

fprintf('tau(15°) = %1.16f tau(small) = %1.16f Errore = %e\n',tau(h15),tau(hsmall),abs(tau(h15)-tau(hsmall))/tau(h15));
fprintf('tau(30°) = %1.16f tau(small) = %1.16f Errore = %e\n',tau(h30),tau(hsmall),abs(tau(h30)-tau(hsmall))/tau(h30));
fprintf('tau(45°) = %1.16f tau(small) = %1.16f Errore = %e\n',tau(h45),tau(hsmall),abs(tau(h45)-tau(hsmall))/tau(h45));