% Soluzione del problema di fitting di dati

% Dati
t = (0.2:0.2:1).';
f = [2.3; 3.0; 2.9; 2.0; 1.1];
% Definizione della matrice e del termine noto del sistema
A = [t t.*exp(-t)];
b = f;

% Soluzione usando le equazioni normali
flag = 'EqNormali';
[a,min_a] = minquad(A,b,flag);
fprintf("Il minimo dato dalla soluzione del sistema delle equazioni normali e' %1.2e\n",...
        min_a);
% Soluzione usando il metodo QR
flag = 'MetodoQR';
[c,min_c] = minquad(A,b,flag);
fprintf("Il minimo dato dal metodo QR e' %1.2e\n", min_c);

% Plot dei dati
plot(t,f,'sk','LineWidth',1)
hold on;
% Valutazione della funzione approssimante nei punti dati in tfine 
tfine = 0:0.02:1;
fa = a.'*[tfine; tfine.*exp(-tfine)];
fc = c.'*[tfine; tfine.*exp(-tfine)];
% Plot delle funzioni approssimanti sulla griglia tfine
plot(tfine, fa, '-b'); hold on
plot(tfine, fc, '--r','LineWidth',1);
xlabel('t'); legend('Dati','Soluzione delle equazioni normali','Soluzione del metodo QR','Location','best')
