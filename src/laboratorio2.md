# Laboratorio 2 : L'Aritmetica di Precisione Finita

Ricordiamo che l'artimetica **floating point** (floating-point arithmetic) è
l'artimetica che fornisce una rappresentazione approssimata dei numeri reali
per supportare un compromesso tra l'intervallo dei numeri rappresentati e la
precisione ottenibile nei calcoli. Per questo motivo, il calcolo in virgola
mobile viene spesso utilizzato in sistemi in cui si deve coniugare la
rappresentazione di numeri in un ampio range richiedendo tuttavia tempi di
elaborazione rapidi.

Un numero in virgola mobile è rappresentato approssimativamente da un numero
fisso di cifre significative (il significando) e scalato usando un esponente
in una qualche base fissata. Tale base è normalmente due, dieci o sedici.
Un numero che può essere rappresentato esattamente è della forma seguente:
```{math}
:label: eq-numeromacchina
 \text{significando} \times \text{base}^{\text{esponente}}.
```
Di tutte le possibili costruzioni di questo tipo, noi adoperiamo quella
codificata nello standard IEEE-754 {cite}`IEEE-754:2019:ISF`, in cui
(la maggior parte dei) i numeri *floating point* sono
normalizzati, cioè possono essere espressi come
```{math}
x = \pm (1+f) 2^e, \qquad 0 \leq f < 1, \qquad -1022 \leq e \leq 1023,
```
dove $f$ è detta la **mantissa**, e deve essere rappresentabile con al più 52 bits,
cioè $2^{52}f$ è un intero nell'intervallo $0 \leq 2^{52} f < 2^{53}$, abbiamo
fissato la base a $2$ e chiamato l'esponente $e$.

Il testo di riferimento per questi argomenti è {cite:p}`MR1927606`.

## Rappresentazione dei numeri di macchina

In generale non tutti i numeri potranno essere espressi nella forma {eq}`eq-numeromacchina`,
possiamo scegliere ad esempio il numero $4/3$ che non può essere scritto esattamente nella
forma $s \times 2^k$. Se proviamo ad eseguire l'operazione
```matlab
e = 1 - 3*(4/3 - 1)
```
da cui ci aspetteremo di ottenere un $1$, otteniamo invece
```
e =
   2.2204e-16
```
che è un errore della grandezza della *precisione di macchina* per l'aritmetica
in virgola mobile adoperata da MATLAB.

In maniera analoga, possiamo considerare un altro numero che non è esattamente
rappresentato in macchina $0.1$. Se lo sommiamo $10$ volte in aritmetica esatta
ci aspettiamo di ottenere $1$:
```matlab
a = 0.0;
for i = 1:10
  a = a + 0.1;
end
```
Tuttavia se proviamo a fare la verifica leggiamo
```matlab
a == 1
ans =

  logical

   0
```
Ed infatti,
```matlab
abs(a-1)

ans =

   1.1102e-16
```
che è di nuovo dell'ordine della precisione di macchina.

:::{tip}
Quando impostiamo dei confronti di "uguaglianza" tra numeri *floating point* la
procedura corretta è sempre quella di controllare la differenza in valore
assoluto tra il valore calcolato ed il risultato aspettato in termine della
precisione di macchina in uso:
```matlab
abs(1-a) < eps

ans =

 logical

  1
```
che ci restituisce il valore aspettato, dove `eps` è spesso chiamato *floating-point
zero*.
:::

All'altro estremo del range dinamico dei numeri rappresentati osserviamo anche
il problema del "diradarsi" dei numeri di macchina, infatti sfruttando la
definizione di numero normalizzato osserviamo facilmente che:
```matlab
(2^53 + 1) - 2^53

ans =
     0
```
Possiamo farci dire da MATLAB quali sono il più piccolo ed il più grande numero
reale rappresentato richiamando le variabili `realmin` e `realmax`:  
```matlab
>> realmin

ans =

  2.2251e-308

>> realmax

ans =

  1.7977e+308
```
Qualunque operazione generi un numero maggiore di `realmax` provocherà un errore
di **overflow**, qualunque operazione generi un numero minore di `realmin` genererà
un errore di **underflow**. In MATLAB questo è rappresento dai valori `+Inf` e `-Inf`:
```matlab
realmax + .0001e+308
ans =
   Inf

-realmax - .0001e+308
ans =
  -Inf
```

:::{warning}
Alcune macchine permettono il trattamento di alcuni casi eccezionali di numeri
*floating point*, cioè l'esistenza di numeri *denormalizzati* (o *subnormali*).
Questi si trovano nell'intevallo [`eps*realmin`,`realmin`].
:::

## Associatività delle operazioni

Mentre l'operazione di somma e di prodotto sono garantite essere commutative
nello standard IEEE, l'operazione di soma tra *floating point* è sicuramente
non associativa. Si consideri infatti l'esempio:
```matlab
b = 1e-16 + 1 - 1e-16;
c = 1e-16 - 1e-16 + 1;
b == c
ans =

  logical

   0
```
Si osserva che se andiamo a valutare la differenza tra le due procedure
```matlab
>> abs(b-c)

ans =

   1.1102e-16
```
che è di nuovo dell'ordine della precisione di macchina.

:::{tip}
Quando si calcola la somma di più termini di ordine diverso è opportuno valutare
l'accumulazione ed agire di conseguenza.
:::

Per correggere il problema precedente si può implementare l'**algoritmo delle somme
compensate** di Kahan, per cui uno pseudocodice è dato da:

```
function KahanSomma(input)
    somma = 0.0                  // variabile che conterrà la somma finale
    c = 0.0                      // Compensazione per i bits che altrimenti andrebbero persi.

    for i = 1 to length(length) do // L'array che ha in input le quantità da sommare va da input(1)
                                   // fino a input(length(input))
        y = input(i) - c           // Al primo passaggio c è zero
        t = somma + y              // Purtroppo, somma è "grande", y è piccolo, quindi alcuni bits
                                   // sono persi, ma non per sempre...
        c = (t - somma) - y        // (t - somma) cancella la parte di ordine alto di y; sottrarre y
                                   // recupera la parte "piccola" di y
        somma = t                  // In aritmetica di precisione infinita c dovrebbe essere
                                   // sempre zero
    // Alla prossima iterata la parte "persa" verrà aggiunta ad y in un nuovo
    // tentativo di recuperarla.
    end for

    return somma
```

:::{admonition} Esercizio
Si implementi l'algoritmo KahanSomma in una funzione MATLAB e se ne verifichino
le proprietà numeriche.
```
function [somma] = KahanSomma(input)
%%KAHANSOMMA algoritmo delle somme compensate di Kahan

end
```
Che possiamo testare sull'esempio precedente costruendo uno script con
```matlab
clear; clc;

input = [ 1e-16 +1 -1e-16];

somma1 = input(1)+input(2)+input(3);
somma2 = sum(input);
somma3 = KahanSomma(input);
```
e confrontando la differenza in valore assoluto tra i tre valori `somma1`, `somma2`
e `somma3`. Cosa si osserva?
:::

Per questo algoritmo è possibile dare una limitazione dell'errore commesso. Se chiamiamo
```{math}
S_n = \sum_{i=1}^{n} \text{input}_i
```
la somma calcolata in precisione infinita, allora con un algoritmo otteniamo in
genere $S_n + E_n$ dove l'errore $E_n$ può essere limitato per l'algoritmo delle somme
compensate da
```{math}
|E_n| \leq [2 \varepsilon + O(n\varepsilon^2)] \sum_{i=1}^{n} |\text{input}_i|,
```
dove $\varepsilon$ è la precisione di macchina. Più in generale, siamo di solito
interessati all'errore relativo, cioè alla quantità
```{math}
\frac{|E_n|}{|S_n|} \leq [2 \varepsilon + O(n\varepsilon^2)] \frac{\sum_{i=1}^{n} |\text{input}_i|}{\left| \sum_{i=1}^{n} \text{input}_i| \right|},
```
```{margin} Numero di condizionamento
Ricordiamo che il numero di condizionamento di un problema rappresenta
essenzialmente la "sensitività" intrinseca del problema, indipendentemente
dall'algoritmo utilizzato per risolverlo.
```
dove la quantità $\kappa = \frac{\sum_{i=1}^{n} |\text{input}_i|}{\left| \sum_{i=1}^{n} \text{input}_i| \right|}$
rappresenta il **numero di condizionamento** dell'operazione di somma. Esistono
algoritmi per la somma che esibiscono migliori limitazioni dell'errore {cite}`MR378388,MR2210098` , per i
nostri scopi illustrativi questa versione è sufficiente.

## Errori di cancellazione/roundoff

Un altro caso in cui calcoli avventati possono avere effetti catastrofici è
quello delle sottrazioni eseguite con operandi quasi uguali, è facile che
l'annullamento si verifichi in modo imprevisto. Consideriamo l'esempio:
```matlab
sqrt(1e-16 + 1) - 1

ans =
     0
```
in cui osserviamo una **cancellazione** causata da *swamping*, che è un fenomeno
analogo a quello che abbiamo visto per l'associatività della somma. Stiamo
osservando una perdita di precisione che rende l'aggiunta insignificante.
È possibile introdurre delle correzioni algoritmiche in maniera analoga a quanto
fatto per la somma anche per altre funzioni, per corregere l'esempio visto sopra
possiamo usare la seguente riscrittura:
```{math}
\sqrt{1e-16 + 1} - 1 = \exp( \log(\sqrt{1e-16 + 1}) ) - 1 = \exp( 0.5 \log(1e-16 + 1) ) - 1,
```
ed usare le funzioni `expm1` e `log1p` di MATLAB che ci permettono di risolvere
il problema di cancellazione:
```matlab
expm1(0.5*log1p(1e-16))
```
in particolare
- `expm1` calcola $\exp(x)-1$ compensando per il *roundoff* in $\exp(x)$,
- `log1p` calcola $\log(1+x)$ evitando di calcolare $1+x$ per valori "piccoli"
di $x$.

```{margin} Roundoff polinomio
![Roundoff nella valutazione di un polinomio](./images/polynomialroundoff.png)
```
Consideriamo un altro esempio, produciamo uno script che valuti il seguente
polinomio
```{math}
:label: eq-polinomio
p(x) = x^7 - 7x^6 + 21x^5 -35x^5 +35x^3 + 21x^2 +7x -1,
```
nell'intervallo $[0.988,1.012]$ su di una griglia con scansione $10^{-4}$. Come
si vede dalla figura al margine questo produce il *plot* di una funzione che
non sembra proprio essere un polinomio: non è liscia! Stiamo osservando di nuovo
degli errori di **roundoff** dati dalla sottrazione di numeri dello stesso
ordine (elevato), che infatti (come si legge dalla scala sull'asse delle $y$)
hanno un ordine di $10^{-14}$. Se guardiamo meglio al polinomio in {eq}`eq-polinomio`
possiamo osservare che questo non è nient'altro che l'espansione di $p(x) = (x-1)^7$,
provate a fare un *plot* sullo stesso intervallo e confrontiamolo con il precedente
```{figure} ./images/polynomialroundoffgood.png
---
name: buonpolinomio
---
Confronto del grafico del polinomio {eq}`eq-polinomio` calcolato nella forma {eq}`eq-polinomio`
e a partire dalla forma  $p(x) = (x-1)^7$.
```

## Condizionamento di un sistema lineare

Ricordiamo che il **numero di condizionamento** associato all'equazione lineare
$A \mathbf{x} = \mathbf{b}$ fornisce un limite sulla precisione della soluzione
$\mathbf{x}$ dopo che un qualunque algoritmo sarà stato applicato per la
sua approssimazione ed in maniera indipendente dalla precisione *floating point*
usata.

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
x2 = A\b
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

## Bibliografia

 ```{bibliography}
 :filter: docname in docnames
 ```
