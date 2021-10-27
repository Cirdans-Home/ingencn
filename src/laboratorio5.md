# Laboratorio 5 : Soluzione di Sistemi Triangolari

I sistemi triangolari giocano un ruolo fondamentale nei calcoli matriciali.
Molti metodi sono costruiti sull'idea di ridurre un problema alla soluzione di uno o più sistemi triangolari, questo include praticamente tutti i **metodi diretti** per la risoluzione di sistemi lineari.

Sui **computer seriali** i sistemi triangolari sono universalmente risolti dagli algoritmi standard di sostituzione in avanti e all'indietro. Sulle **macchine
parallele** la situazione è sensibilmente più varia, ma questo trascende gli
obiettivi di questo corso.

Due funzioni utili per lavorare con i sisistemi triangolari sono le funzioni
`triu` e `tril`. Dal loro `help`:
```
tril Extract lower triangular part.
   tril(X) is the lower triangular part of X.
   tril(X,K) is the elements on and below the K-th diagonal
   of X .  K = 0 is the main diagonal, K > 0 is above the
   main diagonal and K < 0 is below the main diagonal.
```
ed analogamente per `triu`:
```
triu Extract upper triangular part.
   triu(X) is the upper triangular part of X.
   triu(X,K) is the elements on and above the K-th diagonal of
   X.  K = 0 is the main diagonal, K > 0 is above the main
   diagonal and K < 0 is below the main diagonal.
```
Possiamo usarle per costruire sistemi triangolari a partire da sistemi densi.

## Sostituzione in avanti e all'indietro

Chiamiamo di nuovo $L$ una matrice triangolare inferiore, vogliamo risolvere un sistema della forma:
```{math}
L \mathbf{x} = \mathbf{b},
```
che possiamo riscrivere in forma estesa come:
```{math}
\begin{bmatrix}
l_{1,1} & 0       & 0      & \cdots & 0 \\
l_{2,1} & l_{2,2} & 0      & \cdots & 0 \\
\vdots  & \ddots  & \ddots & \ddots & \vdots \\
l_{n-1,1} & l_{n-1,2} & \cdots & l_{n-1,n} & 0 \\
l_{n,1} & l_{n,2} & \cdots & \cdots & l_{n,n}  \\
\end{bmatrix} \begin{bmatrix}
x_1 \\
x_2 \\
\vdots \\
x_{n-1}\\
x_n
\end{bmatrix}
= \begin{bmatrix}
b_1 \\
b_2 \\
\vdots \\
b_{n-1} \\
b_n
\end{bmatrix}
```
Da cui è facile ricavare che la componente $i$ma della soluzione è
```{math}
x_i = \frac{1}{l_{i,i}} \left( b_i - \sum_{j=1}^{i-1} l_{i,j} x_j \right), \qquad i=1,\ldots,n.
```

:::{admonition} Esercizio 1
Si scriva una *function* che implementa il metodo di sostituzione in avanti con
il seguente prototipo.
```matlab
function [x] = forwardsolve(A,b)
%FORWARDSOLVE Se A è una matrice triangolare inferiore risolve sistema
%Ax=b tramite metodo di sostituzione in avanti.
%   Input:
%   A = matrice triangolare inferiore
%   b = vettore del termine note
%   Output:
%   x = vettore della soluzione

end
```
Si presti attenzione:
- Alla verifica degli *input*, il sistema **deve** essere triangolare basso e
quadrato;
- Ad utilizzare le **operazioni vettorizzate** di MATLAB, ovvero si ragioni su
come evitare di usare un ciclo `for` per effettuare la somma che compare
nella formula di soluzione.

Si può testare il codice con il seguente problema:
```matlab
%% Sostituzione in avanti
n = 10;
A = tril(ones(n,n));
b = (1:n).';
x = forwardsolve(A,b);

fprintf("Avanti: Errore sulla soluzione è: %1.2e\n",norm(A*x-b));
```
:::

Chiamiamo di nuovo $U$ una matrice triangolare superiore, vogliamo risolvere un sistema della forma:
```{math}
U \mathbf{x} = \mathbf{b},
```
che possiamo riscrivere in forma estesa come:
```{math}
\begin{bmatrix}
u_{1,1} & u_{1,2} & \cdots & \cdots & u_{1,n}  \\
0 & u_{2,2} & u_{2,3} & \cdots & u_{2,n} \\
\vdots  & \ddots  & \ddots & \ddots & \vdots \\
0      & \cdots & 0 & u_{n-1,n-1} & u_{n-1,n}  \\
0       & 0      & \cdots & 0 & u_{n,n} \\
\end{bmatrix} \begin{bmatrix}
x_1 \\
x_2 \\
\vdots \\
x_{n-1}\\
x_n
\end{bmatrix}
= \begin{bmatrix}
b_1 \\
b_2 \\
\vdots \\
b_{n-1} \\
b_n
\end{bmatrix}
```
Da cui di nuovo ricaviamo facilmente la componente $i$ma della soluzione come:
```{math}
x_i = \frac{1}{u_{i,i}} \left( b_i - \sum_{j=i+1}^{n} u_{i,j} x_j \right), \qquad i=n,n-1,\ldots,1.
```

:::{admonition} Esercizio 2
Si scriva una *function* che implementa il metodo di sostituzione all'indietro con
il seguente prototipo.
```matlab
function [x] = backwardsolve(A,b)
%BACKWARDSOLVE Se A è una matrice triangolare superiore risolve sistema
%Ax=b tramite metodo di sostituzione all'indietro.
%   Input:
%   A = matrice triangolare inferiore
%   b = vettore del termine note
%   Output:
%   x = vettore della soluzione

end
```
Si presti attenzione:
- Alla verifica degli *input*, il sistema **deve** essere triangolare alto e
quadrato;
- Ad utilizzare le **operazioni vettorizzate** di MATLAB, ovvero si ragioni su
come evitare di usare un ciclo `for` per effettuare la somma che compare
nella formula di soluzione.

Si può testare il codice con il seguente problema:
```matlab
%% Sostituzione all'indietro
n = 10;
A = triu(ones(n,n));
b = (1:n).';
x = backwardsolve(A,b);

fprintf("Indietro: Errore sulla soluzione è: %1.2e\n",norm(A*x-b));
```
:::

## Tempo di calcolo

Avete mostrato a lezione che il numero di operazioni necessario a risolvere un
sistema triangolare con l'algoritmo di sostituzione è un $O(n^2)$ per $n$ la
dimensione del sistema. Proviamo ad indagare come si comporta a questo riguardo
la nostra implementazione. Per farlo sfruttiamo i codici che abbiamo appena
scritto per la sostituzione _forward_ o _backward_ e le funzioni `tic` e `toc`
che abbiamo menzionato nel {ref}`laboratorio3`.
```matlab
sizes = floor(logspace(1,4,10));
times = zeros(size(sizes));
h = waitbar(0,"Calcolo in corso...");
for i=1:length(sizes)
    n = sizes(i);
    A = triu(ones(n,n));
    b = (1:n).';
    tic;
    x = backwardsolve(A,b); % Allo stesso modo con forwardsolve
    times(i) = toc;
    waitbar(i/length(sizes));
end
```
Ora che abbiamo i tempi possiamo visualizzare quello che abbiamo ottenuto
sfruttando alcune funzioni di MATLAB. Poiché sappiamo che il numero di
operazioni è una funzione che scala come un $O(n^2)$ possiamo assumere in
prima approssimazione che anche il tempo si comporti allo stesso modo.
Cerchiamo dunque di *fittare* un polinomio di secondo grado ai nostri dati:
```matlab
[P,S] = polyfit(sizes,times,2);
```
Con la mia macchina, questa procedure mi restituisce il polinomio:
```{math}
p(x) = 0.000005682501880 x^2  -0.015569138451058 x + 3.230452264767748
```
insieme ad una struttura $S$ che contiene informazioni relative all'algoritmo
con cui questa procedura è stata eseguita. Possiamo usare tutto questo per
confrontare i valori del *fit* con quelli dei dati
```matlab
[y_fit,delta] = polyval(P,sizes,S);
plot(sizes,times,'o-',...
    sizes,y_fit,'--',...
    sizes,y_fit+2*delta,'m--',sizes,y_fit-2*delta,'m--',...
    'Linewidth',2);
xlabel('Dimensione del sistema')
ylabel('Tempo di calcolo (s)')
legend({'Tempo misurato','Stima asintotica','Intervallo di Confidenza'},...
    'FontSize',14,'Location','northwest');
```
dove abbiamo stampato sia il tempo misurato, sia il *fit* con il suo
*intervallo di confidenza* entro il 95%. Dalla {numref}`triangularsolvetime`
vediamo che la predizione quadratica è piuttosto efficace.
```{figure} ./images/triangulartime.png
:name: triangularsolvetime

Tempo di calcolo come un $O(n^2)$ della dimensione.
```
