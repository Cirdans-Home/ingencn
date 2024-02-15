# Laboratorio 5 : Il Problema Lineare dei Minimi Quadrati

Siamo interessati a risolvere sistemi lineari **sovradeterminati**, ossia della forma

```{math}
A \mathbf{x} = \mathbf{b}, \qquad A \in \mathbb{R}^{m \times n},\; \mathbf{x},\mathbf{b} \in \mathbb{R}^n,\;m> n.
```

Se il problema non ha soluzione si cercano i vettori $\mathbf{x}\in \mathbb{R}^{n}$ che soddisfano

```{math}
:label: leastsq
\lVert A\mathbf{x}-\mathbf{b}\rVert_2 = \min_{\mathbf{y}\in\mathbb{R}^n}\lVert A\mathbf{y}-\mathbf{b}\rVert_2.
```

Tale problema viene detto **problema dei minimi quadrati**.

In questo laboratorio vogliamo concentrarci su metodi numerici di risoluzione del problema dei minimi quadrati e vedere un'applicazione al *fitting* di dati.

La determinazione di un punto di minimo di $\Psi(\mathbf{x})=\lVert A\mathbf{x}-\mathbf{b}\rVert_2$ si riconduce alla ricerca dei punti che annullano tutte le derivate parziali prime di $\Psi$ e questo porta alle **equazioni normali**

```{math}
:label: eqnorm
A^{\top}A\mathbf{x}=A^{\top}\mathbf{b}.
```

Se la matrice $A$ ha rango massimo, allora la soluzione del problema dei minimi quadrati {eq}`leastsq` è unica e può essere ottenuta risolvendo il sistema {eq}`eqnorm`.

In tal caso, si può utilizzare la fattorizzazione $LU$ della matrice $A^{\top}A$. Poiché la matrice $A^{\top}A$ è simmetrica definita positiva, puo essere fattorizzata come

```{math}
A^{\top} A = LL^{\top},
```

detta **fattorizzazione di Cholesky**, dove $L\in\mathbb{R}^n$ è una matrice triangolare inferiore con elementi principali positivi.
La soluzione del sistema delle equazioni normali {eq}`eqnorm` viene calcolata risolvendo successivamente i due sistemi
di ordine $n$ con matrice dei coefficienti triangolare

```{math}
\begin{align}
    & L\mathbf{y} = A^{\top}\mathbf{b}\\[1ex]
    & L^{\top}\mathbf{x} = \mathbf{y}.
\end{align}
```

In alternativa, abbiamo discusso a lezione il metodo basato sulla fattorizzazione $QR$ della matrice $A$ per il calcolo della soluzione del problema dei minimi quadrati {eq}`leastsq`.

:::{admonition} Esercizio 1
Si scriva una *function* che risolve il problema dei minimi quadrati sfruttando il seguente prototipo:

```matlab
function [x,min_res] = minquad(A,b,flag)
%%MINQUAD risolve il problem ai minimi quadrati associato
% al sistema Ax=b con il metodo specificato in flag
%    INPUT:
%     A matrice del sistema
%     b termine noto del sistema
%     flag stringa che specifica il metodo di risoluzione
%    OUTPUT:
%     x soluzione del problema ai minimi quadrati, punto di minimo
%     min_res valore del minimo
end
```

- `flag` è una stringa che può assumere il valore `'EqNormali'` oppure `'MetodoQR'` e determina il metodo numerico con cui il problema dei minimi quadrati viene risolto all'interno della *function*.
- Si calcoli la fattorizzazione $LU$ di $A^{\top}A$ usando l'algoritmo di Doolittle visto nel Laboratorio 7.
- Si usi il comando MATLAB `qr` per calcolare la fattorizzazione $QR$ della matrice $A$.
- Si usino le funzioni `backwardsolve` e `forwardsolve`, implementate nel Laboratorio 6, per risolvere i sistemi lineari triangolari risultanti.
:::

Una tipica situazione in cui è necessario risolvere un problema dei minimi quadrati si presenta quando si vuole costruire una funzione che "si avvicini il più possibile" ad un insieme di dati.

:::{admonition} Esercizio 2

Vogliamo trovare i coefficienti $a_1$ e $a_2$ della funzione $f(t) = t(a_1+a_2 e^{-t})$ in modo che $f$ approssi i dati $(t_i,f_i)$, $i=0,1,2,3,4$, di Tabella 1 nel senso dei minimi quadrati

```{math}
\begin{aligned}
&\text{Tabella 1}\\
&\begin{array}{c|ccccc}
t_i & 0.2 & 0.4 & 0.6 & 0.8 & 1.0\\
\hline f_i & 2.3 & 3.0 & 2.9 & 2.0 & 1.1
\end{array}
\end{aligned}
```

Per risolvere il problema del *fitting* di dati, si derivino la matrice $A$ ed il vettore $\mathbf{b}$ del problema dei minimi quadrati corrispondente. Si utilizzi la *function* `minquad` implementata nell'Esercizio 1 per risolvere il problema.

Si completi il seguente programma usando i dati forniti

```matlab
% Soluzione del problema di fitting di dati

% Dati
t = ...
f = ...
% Definizione della matrice e del termine noto del sistema
A = ...
b = ...

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
fa = ...
fc = ...
% Plot delle funzioni approssimanti sulla griglia tfine
plot(tfine, fa, '-b'); hold on
plot(tfine, fc, '--r','LineWidth',1);
xlabel('t'); legend('Dati','Soluzione delle equazioni normali','Soluzione del metodo QR','Location','best')
```

Il grafico risultante è mostrato qui sotto.

```{figure} ./images/datafitting.png
---
width: 90%
---
```

:::

Quando la funzione approssimante cercata è un polinomio esistono le seguenti routine di MATLAB:

- `a = polyfit(xData,yData,m)` restituisce il vettore `a` di coefficienti del polinomio di grado $m$ che approssima i dati `(xData,yData)` nel senso dei minimi quadrati.
- `y = polyval(a,x)` valuta nel punto `x` il polinomio definito dai coefficienti `a`.
