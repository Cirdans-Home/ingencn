# Laboratorio 6 : Soluzione dei Sistemi Lineari

<!---
In questo e nel prossimo laboratorio ci focalizzeremo sul problema di risolvere
un sistema lineare compatibile. Partiremo dal caso dei sistemi triangolari per
poi occuparci del caso generale tramite la fattorizzazione $PA = LU$ della
matrice dei coefficienti.

(condizionamento-spettrale)=
## Condizionamento di un sistema lineare

Ricordiamo che il **numero di condizionamento** associato all'equazione lineare
$A \mathbf{x} = \mathbf{b}$ fornisce un limite sulla precisione della soluzione
$\mathbf{x}$ dopo che un qualunque algoritmo sarà stato applicato per la
sua approssimazione ed in maniera indipendente dalla precisione *floating point*
usata.

:::{margin} Norma di una matrice
Ricordiamo che una norma sullo spazio vettoriale $K^{m\times n}$ delle matrici
a elementi nel campo $K$ è una funzione
```{math}
\| \cdot \|:K^{m \times n} \mapsto \mathbb{R}^{+}
```
tale che per ogni coppia di matrici $A$ e $B$ e per ogni scalare $\lambda \in K$ si verifica:

- ${\displaystyle \|A\|=0}$ se e solo se ${\displaystyle A=0}$,
- ${\displaystyle \|\lambda A\|=|\lambda |\|A\|}$.
- ${\displaystyle \|A+B\|\leq \|A\|+\|B\|}$.

Se è data una norma sullo spazio vettoriale $K^n$, si può costruire una **norma indotta**
sullo spazio delle matrici in $K^{n \times n}$ considerando
```{math}
\|A\| = \sup_{x \neq \mathbf{0}} \frac{\| A \mathbf{x} \|}{\|\mathbf{x}\|},
```
ovvero
```{math}
\|A\| = \sup_{\|x\|  = 1} \| A \mathbf{x} \|.
```
Nei casi speciali in cui la norma vettoriale sia la norma  ${\displaystyle p=1,2,\infty ,}$
la norma matriciale indotta può essere calcolata come
```{math}
{\displaystyle \|A\|_{1}=\max _{1\leq j\leq n}\sum _{i=1}^{m}|a_{ij}|,}
```
che è il massimo della somma dei valori assoluti delle colonne di $A$;
```{math}
{\displaystyle \|A\|_{\infty }=\max _{1\leq i\leq m}\sum _{j=1}^{n}|a_{ij}|,}
```
che è il massimo della somma dei valori assoluti delle righe di $A$;
```{math}
{\displaystyle \|A\|_{2}={\sqrt {\lambda _{\max }\left(A^{*}A\right)}}.}
```
che è detta **norma spettrale** della matrice ${\displaystyle A}$, ovver la
radice quadrata the più grande autovalore di ${\displaystyle A^{* }A}$,
dove $A^{* }$ denota la coniugata trasposta di $A$.
:::

Sia $\mathbf{e}$ l'errore commesso rispetto a $\mathbf{b}$, assumiamo che $A$ sia
non singolare, allora l'errore sulla soluzione $A^{-1} \mathbf{b}$ è dato da
$A^{-1} \mathbf{e}$. Allora il rapporto tra gli errori relativi è dato da
```{math}
\frac{\| A^{-1} \mathbf{e} \|}{\| A^{-1} \mathbf{b} \|} / \frac{\|\mathbf{e}\|}{\|\mathbf{b}\|} = \frac{\| A^{-1}\mathbf{e}\|}{\|\mathbf{e}\|} \frac{\|\mathbf{b}\|}{\|A^{-1}\mathbf{b}\|},
```
per cui possiamo esibire la limitazione per il termine destro come
```{math}
:label: bound
\frac{\| A^{-1}\mathbf{e}\|}{\|\mathbf{e}\|} \frac{\|\mathbf{b}\|}{\|A^{-1}\mathbf{b}\|} \leq & \max_{\mathbf{e},\mathbf{b} \neq 0} \left\lbrace \frac{\| A^{-1}\mathbf{e}\|}{\|\mathbf{e}\|}, \frac{\|\mathbf{b}\|}{\|A^{-1}\mathbf{b}\|} \right\rbrace \\ = & \max_{\mathbf{e}\neq 0} \frac{\| A^{-1}\mathbf{e}\|}{\|\mathbf{e}\|} \max_{\mathbf{b}\neq 0} \frac{\|\mathbf{b}\|}{\|A^{-1}\mathbf{b}\|} \\
= & \max_{\mathbf{e}\neq 0} \frac{\| A^{-1}\mathbf{e}\|}{\|\mathbf{e}\|} \max_{\mathbf{b}\neq 0} \frac{\|A\mathbf{x}\|}{\|\mathbf{x}\|} \\
= & \| A^{-1} \| \|A \| \equiv \kappa(A) \geq \| A^{-1} A \| = 1.
```
Consideriamo ora il seguente esempio artificiale
```{math}
A \mathbf{x} = \begin{bmatrix}
4.1 & 2.8 \\
9.7 & 6.6
\end{bmatrix}  \begin{bmatrix}
x_1 \\ x_2
\end{bmatrix} = \begin{bmatrix}
4.1 \\ 9.7
\end{bmatrix}
```
Proviamo a risolvere direttamente con MATLAB il sistema lineare
```matlab
A = [4.1 2.8; 9.7 6.6];
b = A(:,1);
x = A\b
```
da cui otteniamo come risposta:
```
x =

   1.000000000000002
  -0.000000000000003
```
Ritracciamo i passi del bound sul termine noto, per cui introduciamo una
perturbazione di $0.01$ sulla prima componente di $\mathbf{b}$ e paragoniamo le
due soluzioni
```matlab
b2 = [4.11; 9.7];
x2 = A\b2
```
da cui otteniamo
```
x2 =

   0.339999999999957
   0.970000000000064
```

Andiamo ora a verificare la limitazione che abbiamo mostrato in termini del
numero di condizionamento. A questo scopo facciamo uso del comando `cond`
```
cond   Condition number with respect to inversion.
   cond(X) returns the 2-norm condition number (the ratio of the
   largest singular value of X to the smallest).  Large condition
   numbers indicate a nearly singular matrix.

   cond(X,P) returns the condition number of X in P-norm:

      NORM(X,P) * NORM(INV(X),P).

   where P = 1, 2, inf, or 'fro'.
```
:::{danger}
Il calcolo del numero di condizionamento per una matrice è bene che sia eseguito
tramite la funzione `cond`, la forma `NORM(X,P) * NORM(INV(X),P)` nella
documentazione è identificativa di ciò che stiamo calcolando, ma *non* è
rappresentativo del modo in cui è realmente calcolato.
:::

Calcoliamo quindi
```matlab
kappa = cond(A);
bound = kappa*norm(b-b2)/norm(b);
errore_relativo = norm(x-x2)/norm(x);
```
e osserviamo che
```
bound =

   1.54117722269025
errore_relativo =

  1.173243367763135
```
che quindi ci mostra che l'errore che abbiamo commesso è abbastanza vicino
alla limitazione data dalla {eq}`bound`.

:::{warning}
Per matrici di grandi dimensioni la funzione `cond` può risultare estremamente
lenta o andare **out of memory**. Per questo motivo sono disponibili altre
due funzioni chiamate `rcond` e `condest`.

La funzione `rcond(A)` calcola il reciproco di `cond(A,1)`, per cui più questo è
vicino a $0$ più la matrice è *malcondizionata*, più questo è vicino a $1$ più
la matrice è *ben condizionata*. Questa funzione si basa sulla libreria [LAPACK](http://www.netlib.org/lapack/).
Questa è una libreria di software in Fortran 90 che produce le implementazioni
standard delle operazioni dell'algebra lineare per matrici dense.

La funzione `condest` calcola un limite inferiore per il numero di condizionamento
in norma $1$ di una matrice quadrata $A$. Informazioni sull'algoritmo applicato
per ottenere questa approssimazione si trovano in {cite:p}`MR740850` e {cite:p}`MR1780268`.
:::

## Soluzione dei sistemi triangolari

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

(forwardandbacwardsolve)=
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

## Esercizi

:::{admonition} Esercizio 3: Numeri di Bernoulli

Consideriamo le condizioni
```{math}
B(x+1) - B(x) = n x^{n-1}, \quad \int_{0}^{1} B(x)\,{\rm d}x, \quad B(x)\, \text{polinomio}.
```
Queste definiscono in maniera unica la funzione $B(x)$. Se assumiamo che il grado
del polinomio monico $B(x)$ sia $n$ abbiamo così costruito i **polinomi di Bernoulli**. Si possono calcolare esattamente i primi polinomi come:
```{math}
B_0(x) = 1, \quad B_1(x) = x - \frac{1}{2}, \quad B_2(x) = x(x-1)+\frac{1}{6}, \quad B_3(x) = x(x-\frac{1}{2})(x-1), \ldots
```
Si può dimostrare che i polinomi di Bernoulli definiscono i coefficienti della rappresentazione in serie di potenze di diverse funzioni, ad esepio:
```{math}
\frac{t e^{xt}}{e^t - 1} = \sum_{k=0}^{+\infty} \frac{B_n(x)}{n!}t^n.
```
In particolare, se scegliamo $x = 0$, abbiamo che
```{math}
:label: bernoulliexpansion
\frac{t}{e^t - 1} = -\frac{1}{2}t + \sum_{k=0}^{+\infty} \frac{B_{2k}(0)}{(2k)!}t^{2k}.
```
Facciamo ora la seguente manipolazione algebrica, moltiplichiamo l'equazione
a sinistra e a destra per $e^{t} - 1$, espandiamo $e^{t}$ con la sua serie
di potenze, e poniamo uguale a zero i coefficienti di $t^i$ sul lato destro.
Così otteniamo il seguente sistema di equazioni:
```{math}
- \frac{1}{2} j + \sum_{k=0}^{[\frac{j-1}{2}]} \binom{j}{2k} B_{2k}(0), \qquad j=2,3,4,\ldots
```
Da cui otteniamo, per gli $j$ pari, il seguente sistema di equazioni lineari
```{math}
\begin{bmatrix}
\binom{2}{0} \\
\binom{4}{0} & \binom{4}{2} \\
\binom{6}{0} & \binom{6}{2} & \binom{6}{4} \\
\binom{8}{0} & \binom{8}{2} & \binom{8}{4} & \binom{8}{6} \\
\vdots & \vdots & \vdots & \vdots & \ddots \\
\end{bmatrix}
\begin{bmatrix}
B_0(0)\\
B_2(0)\\
B_4(0)\\
B_6(0)\\
\vdots
\end{bmatrix}
= \begin{bmatrix}
1\\
2\\
3\\
4\\
\vdots
\end{bmatrix}.
```
1. Si implementi una funzione che dato un intero $k$ restituisca i numeri di
Bernoulli $\{B_{2j}(0)\}_{j=0}^{k}$ risolvendo questo sistema lineare.
2. Si usino i numeri così ottenuti per determinare lo sviluppo in {eq}`bernoulliexpansion` e disegnare
- le due funzioni una accanto all'altra,
- l'errore di approssimazione commesso in scala logaritmica.

Un prototipo della funzione è:
```matlab
function [Bk] = nbernoulli(k)
%BERNOULLI Produce i numeri di Bernoulli B_{2j}(0) per j=0,...,k risolvendo
%un sistema triangolare inferiore.
%   INPUT:
%   k =  Numero di termini (-1) da calcolare
%   OUTPUT:
%   Bk = Vettore di lunghezza k+1 che contiene i numeri richiesti
end
```

```{tip}
La funzione binomiale in MATLAB è implementata come `nchoosek`. Potete inoltre
confrontare i risultati ottenuti con la funzione nativa di MATLAB che calcola
i numeri di Bernoulli dal medesimo nome (`help bernoulli` per le informazioni).
```
:::
-->
