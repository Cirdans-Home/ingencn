# Laboratorio 10 : Metodi per la Soluzione di ODE

In questo laboratorio ci vogliamo occupare di alcuni metodi per la
soluzione di un'**equazione differenziale del primo ordine**, la cui forma
generale è
```{math}
y' = f(x,y)
```
dove $y' = {\rm d}y/{\rm d}x$ e $f(x,y)$ è una funzione data. Come avete
visto nei corsi di Analisi, la soluzione di questo tipo di equazioni
contiene una costante arbitraria (detta *costante di integrazione*). Per
trovare questa costante, e dunque determinare completamente una soluzione,
dobbiamo sapere un punto sulla curva della soluzione:
```{math}
y(a) = \alpha.
```

In modo **più formale**, un’**equazione differenziale ordinaria di ordine $n$**, in *forma
normale*, è un’equazione del tipo

```{math}
y^{(n)}=f(x,y,y',y'',\ldots,y^{(n-1)}),
```

che lega una funzione $y=y(x)$ e le sue derivate fino
all’ordine $n$.

Soluzione dell’equazione è una funzione $y(x)$, continua e
derivabile fino all’ordine $n$ in un intervallo opportuno, che
soddisfa l’equazione.

In generale, un’equazione differenziale ha infinite soluzioni.
Solitamente si impongono delle condizioni aggiuntive e si determinano
le soluzioni che soddisfano le condizioni assegnate.

## Problema ai valori iniziali

Nel problema ai valori iniziali, detto anche di Cauchy, all’equazione

```{math}
y^{(n)}=f(x,y,y',y'',\ldots,y^{(n-1)}),
```
si assegnano $n$ condizioni iniziali
```{math}
 y(x_0)=\eta_0,\quad y'(x_0)=\eta_1,\quad\ldots\quad,y^{(n-1)}(x_0)=\eta_{n-1}.
```
 Sotto **opportune condizioni**, si dimostrano l’esistenza e l’unicità
 della soluzione. In particolare, nel caso $n=1$
```{math}
    \left\{\begin{array}{l}
    y'=f(x,y)\quad\\y(x_0)=\eta
    \end{array}
    \right.
```
 valgono risultati di esistenza e unicità della soluzione nell’ipotesi
 che $f(x,y)$ sia continua rispetto a $x$ e *uniformemente
 lipschitziana* rispetto a $y$.

Più in generale, possiamo guardare ad un sistema $n$ equazioni differenziali del primo ordine
```{math}
  \left\{\begin{array}{l}
  y_1'=f_1(x,y_1,\ldots,y_n)\\
  y_2'=f_2(x,y_1,\ldots,y_n)\\
  \ldots\\
  y_n'=f_n(x,y_1,\ldots,y_n)\\
  \end{array}\right.
```
dove $f_1,\ldots,f_n$ sono $n$ funzioni di $n+1$
variabili e $y_1(x), y_2(x),\ldots,y_n(x)$ sono le $n$ incognite.

In **forma compatta**:
```{math}
{\bf y}'={\bf f}(x,{\bf y}),
```
dove ${\bf y}$, ${\bf y}'$ e ${\bf f}$ sono *vettori di funzioni*.

Se a questo sistema associamo le **condizioni iniziali**
```{math}
{\bf y}(x_0)=(\eta_0,\eta_1,\ldots,\eta_{n-1})^T,
```
otteniamo il corrispondente problema ai valori iniziali, che, sotto
ipotesi simili a quelle già viste, ammette una e una sola soluzione.

:::{admonition} Equazione differenziale $\leadsto$ sistema di ordine 1
:class: tip
Data
 un’equazione differenziale di ordine :math:`n`
```{math}
y^{(n)}=f(x,y,y',y'',\ldots,y^{(n-1)}),
```
 poniamo
```{math}
y_1(x)=y(x),\quad y_2(x)=y'(x),\quad\ldots\quad y_n(x)=y^{(n-1)}(x).
```
 Allora l’equazione si trasforma in un sistema di equazioni del primo
 ordine
```{math}
    \left\{\begin{array}{l}
    y_1'=y_2\\
    y_2'=y_3\\
    \ldots\\
    y_{n-1}'=y_n\\
    y_n'=f(x,y_1,y_2,\ldots,y_n)
    \end{array}\right.
```
:::

## Metodi numerici

Determinare la soluzione di un’equazione
differenziale per via analitica è generalmente difficile e spesso
impossibile. Per esempio, l’equazione
```{math}
y'=x^2+y^2,
```
nonostante l’aspetto apparentemente semplice, non è risolubile in
termini di funzioni elementari. Dobbiamo quindi cercare una soluzione
approssimata usando un metodo numerico.

La letteratura che tratta i metodi numerici per equazioni
differenziali con condizioni iniziali è molto vasta. Come primi
esempi studieremo

-  il metodo di Eulero esplicito,
-  il metodi di Eulero implicito,
-  il metodo di Runge-Kutta classico.

### Il metodo di Eulero esplicito

Il metodo di Eulero esplicito Consideriamo il problema di Cauchy
```{math}
  \left\{\begin{array}{l}
  y'=f(x,y)\\y(a)=\eta
  \end{array}
  \right.
```
che vogliamo risolvere numericamente nell’intervallo $[a,b]$
Discretizziamo la variabile $x$ fissando nell’intervallo
$[a,b]$ una **griglia di nodi** $\{x_i\}_{i=0,\ldots,N}$
**equidistanti** di passo $h>0$:
```{math}
 x_0=a,\quad x_i=x_{i-1}+h,\quad x_N=b.
```
Il comportamento della soluzione
$y(x)$ tra $x_{i-1}$ e $x_{i}$ può essere stimato come
```{math}
 y(x_{i})\sim y(x_{i-1})+hf(x_{i-1},y(x_{i-1})).
```
Per cui si
approssima la funzione $y(x)$ per mezzo dei suoi valori
$y_i$ nei nodi $x_i$, calcolati tramite la formula
```{math}
y_0=\eta,\quad y_i=y_{i-1}+hf(x_{i-1},y_{i-1}),\quad i=1,\ldots,N.
```
Abbiamo ora tutti gli strumenti necessari ad implementare il metodo di
Eulero esplicito.
:::{admonition} Esercizio
Si usi il seguente prototipo per implementare il **metodo di Eulero
esplicito** per un sistema di equazioni differenziali del primo ordine.
```matlab
function [y,x] = expliciteuler(f,y0,a,b,h)
%%EXPLICITEULER implementa il metodo di Eulero esplicito per la soluzione
% di un sistema di equazioni differenziali del primo ordine.
%   INPUT: f function handle della dinamica del sistema f(x,y)
%          y0 vettore delle condizioni iniziali
%          a,b estremi dell'intervallo di integrazione
%          h ampiezza del passo di integrazione
%   OUTPUT: y vettore (matrice) che contiene le soluzioni calcolate nei
%           punti x(i),
%           x vettore dei nodi

end
```
- Si verifichino gli *input*,
- Si minimizzi il numero di chiamate alla funzione $f$.

Per testare il codice si può usare il seguente **problema di test**
```{math}
  \left\{\begin{array}{l}
  y'=-\frac{2y+x^2y^2}{x}\\
  y(1)=1
  \end{array}\right.
```
per $x\in [1,2]$. In questo caso la **soluzione esatta** è nota e vale
```{math}
y=\frac{1}{x^2(\log x+1)}.
```
```matlab
%% Il metodo di Eulero esplicito
f = @(x,y) - (2*y + (x^2)*(y^2))/(x);
ytrue = @(x) 1./(x.^2.*(log(x)+1));

a = 1;
b = 2;
h  = 1e-2;
y0 = 1;
[y,x] = expliciteuler(f,y0,a,b,h);

figure(1)
plot(x,y,'r--',x,ytrue(x),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
figure(2)
semilogy(x,abs(y-ytrue(x)),'r-','LineWidth',2);
xlabel('x');
ylabel('Errore Assoluto');
```
:::

Possiamo studiare la convergenza del metodo guardando all'errore rispetto
alla soluzione esatta e sfruttando la *function* `convergenza2` che
abbiamo visto quando abbiamo discusso del metodo di Newton ({ref}`newt-convergenza`)
per stimare numericamente l'ordine di convergenza:
```matlab
function q = convergenza2(x)
%%CONVERGENZA produce una stima dell'ordine di convergenza della
%%successione x_n ad xtrue.
    q = zeros(length(x)-3,1);
    for n = 3:(length(x)-1)
        q(n-1) = real(log((x(n+1)-x(n))/(x(n)-x(n-1)))/log((x(n)-x(n-1))/(x(n-1)-x(n-2))));       
    end
end
```
Con questa osserviamo che:
```matlab
%% Convergenza
k = 9;
h = fliplr(logspace(-6,-1,k));
err = zeros(k,1);
for i=1:k
    [y,x] = expliciteuler(f,y0,a,b,h(i));
    yt = ytrue(x);
    err(i) = norm(y - yt)/norm(yt);
end

figure(3)
loglog(h,err,'o-');
xlabel('h')
ylabel('Errore Assoluto');

q = convergenza2(err);
```

```{figure} ./images/forward_euler_error.png

Errore del metodo di Eulero in avanti.
```
ed il valore di $q = [0.9784, 0.9972, 1.0000, 1.0001, 1.0000, 1.0000]$ ed
il previsto ordine di convergenza per questo metodo.

Infatti, se supponiamo che $f(x,y)$ abbia derivate continue rispetto a
$x$ e $y$. In questo caso si ha $y(x)\in\mathcal{C}^2([a,b])$. Possiamo
quindi applicare la formula di Taylor (con resto in forma di Lagrange):
```{math}
y(x_i)-y(x_{i-1})=hy'(x_{i-1})+\frac{h^2}{2}y''(\xi),\quad \xi\in (x_{i-1},x_i)
```
da cui si deduce
```{math}
|\tau_i|=\frac{h}{2}|y''(\xi)|.
```
Quindi in ogni intervallo $[x_{i-1},x_i]$ l’**errore locale** è
approssimativamente lineare in $h$. Poiché $|y''(\xi)|$ è
limitato in $[a,b]$, si ha che $\tau_i$ tende a zero con
$h$ e si scrive $\tau_i=\mathcal{O}(h)$.

Posto $\tau=\max_{i=1,\ldots,N}|\tau_i|$, esiste una costante
$M\neq 0$ per cui $\tau\leq Mh$, e quindi
```{math}
 \lim_{h\rightarrow 0}\tau=0,\qquad \tau=\mathcal{O}(h).
```
Si dice allora che il metodo di Eulero è consistente di ordine 1.

Si può dimostrare che, sotto le stesse ipotesi su $f$, anche
l’errore globale tende a zero con $h\rightarrow 0$. Concludiamo
quindi che il metodo di Eulero è convergente.

Proviamo ora a **cambiare le condizioni iniziali** per la nostra ODE.
```{math}
\left\{\begin{array}{l}
y'=-\frac{2y+x^2y^2}{x}\\
y(1)=10
\end{array}\right.,\quad x\in [1,2].
```
La soluzione generale è data da
```{math}
y(x) = \frac{1}{x^2 (c_1+\log (x))}
```
e sostituendo la condizione iniziale
```{math}
y(x) = \frac{10}{x^2 (10 \log (x)+1)}.
```
Tuttavia se ripetiamo l'analisi di convergenza
```matlab
%% Convergenza per diverse condizioni iniziali
a = 1;
b = 2;
y0 = 10;

ytrue = @(x) 10./(x.^2.*(10*log(x)+1));

k = 9;
h = fliplr(logspace(-6,-1,k));
err = zeros(k,1);
for i=1:k
    [y,x] = expliciteuler(f,y0,a,b,h(i));
    yt = ytrue(x);
    err(i) = norm(y - yt)/norm(yt);
end

figure(3)
loglog(h,err,'o-');
xlabel('h')
ylabel('Errore Assoluto');
```
Osserviamo:
```{figure} ./images/forward_euler_error2.png

Convergenza del metodo di Eulero per diverse condizioni iniziali.
```
Quello che vediamo è che per il valore di $h$ più grande, ovvero $h =
0.1$, l'errore relativo è maggiore di $1$, cioè **non abbiamo
convergenza**. Nell’esempio il metodo di Eulero ha quindi un
comportamento instabile.

La stabilità di un metodo numerico per problemi differenziali viene
valutata applicando il metodo ad un particolare problema test ed
esaminando se l’errore, introdotto ad un passo per effetto del
calcolo, aumenta o diminuisce quando viene propagato al passo
successivo.

Nel caso generale del problema
```{math}
  \left\{\begin{array}{l}
  y'=f(x,y)\\y(a)=\eta
  \end{array}
  \right.
```
la limitazione sul passo $h$ diventa
```{math}
0<h<\frac{2}{|f_y(x,y)|}
```
e quindi cambia punto per punto. Nell’esempio con $f(x,y)=-\frac{2y+x^2y^2}{x}$ e condizione iniziale $y(1)=1$ si ha
```{math}
f_y(x,y)=-2\,\frac{1+x^2y}{x},\quad f_y(x_0,y_0)=f_y(1,1)=-4.
```
Perciò al primo passo il metodo di Eulero è stabile per
$0<h<1/2$; questa proprietà vale anche ai passi successivi
perché si ha $|f_y(x_i,y_i)|<|f_y(x_0,y_0)|$ e $i>1$.

Quando invece si modifica la condizione iniziale si ha
```{math}
f_y(x_0,u_0)=f_y(1,10)=-22,
```
quindi per avere stabilità si richiede $0<h<1/11$ al primo
passo. Ai passi successivi, vista la decrescenza della soluzione,
questa limitazione risulta indebolita e si può scegliere un valore di
$h$ un più grande e questo è ben descritto dalla figura.

### Il metodo di Eulero implicito

Da quanto detto finora sembra
che scelte piccole del passo $h$ siano indispensabili per
assicurare convergenza e stabilità. Tuttavia, a un $h$ piccolo
corrisponde un numero elevato di nodi di integrazione, e
quindi un notevole volume di calcolo per approssimare la soluzione in
tutto l’intervallo richiesto, con un conseguente elevato accumulo
dell’errore di arrotondamento.

La scelta di $h$ deve quindi trovare un **compromesso** tra due
esigenze: passo sufficientemente piccolo per ragioni di convergenza e
stabilità, ma al contempo non troppo piccolo per non rendere
eccessivo l’errore di arrotondamento.

Per ridurre le richieste su $h$, introduciamo quindi i metodi impliciti.


:::{admonition} Esercizio
Si implementi il metodo di Eulero implicito.
```matlab
function [y,x] = impliciteuler(f,y0,a,b,h)
%%IMPLICITEULER implementa il metodo di Eulero implicito per la soluzione
% di un sistema di equazioni differenziali del primo ordine.
%   INPUT: f function handle della dinamica del sistema f(x,y)
%          y0 vettore delle condizioni iniziali
%          a,b estremi dell'intervallo di integrazione
%          h ampiezza del passo di integrazione
%   OUTPUT: y vettore (matrice) che contiene le soluzioni calcolate nei
%           punti x(i),
%           x vettore dei nodi

end
```
- Si usi il comando `fsolve` per risolvere il sistema (possibilmente) non
lineare, per sopprimere le stampe di controllo di `fsolve` si possono
usare le opzioni generate con `optimoptions('fsolve','Display','none')`.

Per verificare l'implementazione possiamo usare lo stesso problema test
```matlab
%% Il metodo di Eulero implicito
f = @(x,y) - (2*y + (x^2)*(y^2))/(x);
ytrue = @(x) 1./(x.^2.*(log(x)+1));

a = 1;
b = 2;
h  = 1e-2;
y0 = 1;
[y,x] = impliciteuler(f,y0,a,b,h);

figure(1)
plot(x,y,'r--',x,ytrue(x),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
figure(2)
semilogy(x,abs(y-ytrue(x)),'r-','LineWidth',2);
xlabel('x');
ylabel('Errore Assoluto');
```
:::

Controlliamo ora che succede nel caso che prima ci restituiva dei
problemi confrontando la soluzione con il metodo di Eulero esplicito
ed implicito.
```matlab
%% Errore di stabilità
a = 1;
b = 2;
h  = 1e-1;
y0 = 10;

ytrue = @(x) 10./(x.^2.*(10*log(x)+1));

[y,x] = impliciteuler(f,y0,a,b,h);
[yexp,xexp] = expliciteuler(f,y0,a,b,h);

figure(1)
subplot(1,2,1);
plot(x,y,'r--',x,ytrue(x),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
title('Eulero implicito');
subplot(1,2,2);
plot(xexp,yexp,'r--',xexp,ytrue(xexp),'b-','LineWidth',2);
xlabel('x');
legend({'Computed Solution','True Solution'},'FontSize',14);
title('Eulero esplicito')
```
```{figure} ./images/implicit_euler_error.png

Differenza in stabilità tra il metodo di Eulero implicito ed esplicito.
```

## Esercizi

:::{margin} Condizione iniziale
```{figure} ./images/spacecraft.png
:name: fig:spacecraft

Condizioni iniziali
:::
:::::{admonition} Esercizio
Un veicolo spaziale è lanciato ad una altitudine di $H = 772 \text{ km}$
sul livello del mare con velocità iniziale $v_0 = 6700\,\text{m/s}$ nella
direzione illustrata in {numref}`fig:spacecraft`. Le equazioni differenziali che descrivono
il moto dell'oggetto in coordinate polari sono
```{math}
\ddot{r} = r \dot{\theta}^2 - \frac{G M_e}{r^2}, \quad \ddot{\theta} = - 2 \frac{\dot{r}\dot{\theta}}{r}.
```
Rispetto alle costanti
- $G = 6.672 \times 10^{-11}$ $\text{m}^3\text{kg}^{-1}\text{s}^{-2}$ per la costante di gravitazione universale,
- $M_e = 5.9742 \times 10^{24} \text{ kg}$, per la massa della terra,
- $R_e = 6378.14 \text{ km}$ per il raggio della terra a livello del mare,

Si ottengano le equazioni differenziali del **primo ordine** per questo
sistema e si integri numericamente fino a che il veicolo non tocca terra.
Si determini il valore di $\theta$ del sito di impatto.

:::{admonition} Suggerimento
:class: tip, dropdown

Si può usare il seguente prototipo per implementare la dinamica. In questa
implementazione assumiamo di aver ordinato le variabili $\mathbf{y}$ del sistema riscritto al primo ordine come $\mathbf{y} = [y_1,y_2,y_3,y_4]^T = [r,\dot{r},\theta,\dot{\theta}]^T$.
```matlab
function ydot = veicolo(x,y)
%VEICOLO Dinamica per il veicolo in coordinate polari.
%   INPUT:  x variabile muta
%           y vettore delle variabili y = [r rdot theta thetadot]
%   OUTPUT: dinamica del sistema

end
```
:::

:::::

:::{admonition} Esercizio

Un paracadutista di massa $m$ in caduta libera verticale subisce una
resistenza aerodinamica $F_D = c_D \dot{y}^2$, dove $y$ è misurata
verso il basso dall'inizio della caduta. L'equazione differenziale che descrive la caduta è
```{math}
\ddot{y} = g - \frac{c_D}{m} \dot{y}^2.
```
Si determnini il tempo di una caduta di $500 \text{ m}$ utilizzando
$g = 9.80665 \text{ m/}\text{s}^2$, $c_D = 0.2028 \text{ kg/m}$ e
$m = 80 \,\text{kg}$.
:::
