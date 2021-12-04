%% Accelerazione macchina

clear; clc; close all;

m = 2000; % kg

TAB = [ 0 0
        1.0 4.7
        1.8 12.2
        2.4 19.0
        3.5 31.8
        4.4 40.1
        5.1 43.8
        6.0 43.2];
    
v = TAB(2:end,1);           % m/w
P = TAB(2:end,2)*1000;      % kW --> W

figure(1)
plot(TAB(:,1),TAB(:,2),'o-','LineWidth',2)
xlabel('v (m/s)')
ylabel('P (kW)');

dt = m*trapz(v,v./P);

fprintf("Ci impiega %1.2f s\n",dt);