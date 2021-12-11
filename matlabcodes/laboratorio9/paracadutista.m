%% Paracadutista

clear; clc; close all;

g  = 9.80665; % m/s^2
cD = 0.2028; % kg/m
m  = 80; % kg

y0 = [500;0];
F = @(x,y) [-y(2);g - (cD/m)*y(2)^2];

a = 0;
b = 14;
h = 1e-1;

[y,x] = expliciteuler(@(x,y) F(x,y),y0,a,b,h);

figure(1);
subplot(1,2,1);
plot(x,y(1,:),'r-',x,zeros(size(x)),'k-','LineWidth',2)
xlabel('t');
ylabel('y');
axis tight;
subplot(1,2,2);
plot(x,y(2,:),'r-','LineWidth',2)
xlabel('t');
ylabel('$\dot{y}$','Interpreter','LaTeX');
axis tight;