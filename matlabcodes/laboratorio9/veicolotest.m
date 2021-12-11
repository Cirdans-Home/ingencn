%% Veicolo Spaziale

clear; clc; close all;

Re = 6378.4e3;
H = 772e3;
v0 = 6700;

% Fissiamo le condizioni iniziali
y0 = zeros(4,1);
y0(1) = Re + H;  % r(0)
y0(2) = 0;       % \dot{r}(0)
y0(3) = 0;       % \theta(0)
y0(4) = v0/y0(1); %

% Integriamo il sistema
a = 0;
b = 1200;
h = 0.05;

%[y,x] = expliciteuler(@(x,y) veicolo(x,y),y0,a,b,h);
[y,x] = impliciteuler(@(x,y) veicolo(x,y),y0,a,b,h);
%[x,y] = ode45(@(x,y) veicolo(x,y),[a,b],y0);
%y = y.';

figure(1)
subplot(1,2,1);
plot(x,y(1,:),'r-',x,Re*ones(size(x)),'k--','LineWidth',2);
xlabel('x')
ylabel('r')
axis tight
subplot(1,2,2);
plot(x,y(3,:),'r-','LineWidth',2);
xlabel('x')
ylabel('\theta')
axis tight