%% Tempo di calcolo
sizes = floor(logspace(1,4,10));
times = zeros(size(sizes));
h = waitbar(0,"Calcolo in corso...");
for i=1:length(sizes)
    n = sizes(i);
    A = triu(ones(n,n));
    b = (1:n).';
    tic;
    x = backwardsolve(A,b);
    times(i) = toc;
    waitbar(i/length(sizes));
end

%% Figura
[P,S] = polyfit(sizes,times,2);
[y_fit,delta] = polyval(P,sizes,S);
plot(sizes,times,'o-',...
    sizes,y_fit,'--',...
    sizes,y_fit+2*delta,'m--',sizes,y_fit-2*delta,'m--',...
    'Linewidth',2);
xlabel('Dimensione del sistema')
ylabel('Tempo di calcolo (s)')
legend({'Tempo misurato','Stima asintotica','Intervallo di Confidenza'},...
    'FontSize',14,'Location','northwest');
