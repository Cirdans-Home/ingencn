# Laboratorio 3 : Il Metodo di Bisezione

In questo laboratorio ci occuperemo del problema dell'individuazione degli zeri
di una funzione **continua** $f : \mathbb{R} \to \mathbb{R}$. Per farlo
adopereremo il *metodo di bisezione*.

Per applicare il metodo abbiamo bisogno di un intervallo $[a,b] \subset \mathbb{R}$
per cui abbiamo che $f(a)f(b) < 0$, ovvero per cui $f(a)$ e $f(b)$ assumono
segni opposti.

:::{margin} Function Handle
Il modo più semplice di passare la funzione scalare $f$ al nostro algoritmo è
quello di utilizzare un **function handle**, ovvero un tipo di dato di MATLAB
che conserva l'associazione ad una funzione.

Questo può essere fatto in diversi modi, si definisce un file funzione
```matlab
function y = funzione(x)
  y = x.^3 -x -2;
end
```
e poi si invoca la funzione `[c,residuo] = bisezione(@funzione,a,b,maxit,tol)`.

Oppure si definisce direttamente nello script di lancio (o nella *command window*)
la funzione come
```matlab
f = @(x) x.^3 -x -2;
```
e poi si invoca la funzione semplicemente come `[c,residuo] = bisezione(f,a,b,maxit,tol)`.
Si veda l'esempio di script di seguito.
:::
:::{admonition} Esercizio 1
Si implementi in una funzione MATLAB l'algoritmo di bisezione:
1. Calcolare $c$, punto medio dell'intervallo $[a,b]$, $c = (a+b)/2$,
2. Calcolare il valore della funzione al punto medio $f(c)$,
3. Se il *criterio di convergenza* è soddisfatto, restituire $c$ e terminare le
iterazioni
4. Esaminare il segno di $f(c)$ e rimpiazzare $(a,f(a))$ o $(b,f(b))$ con
$(c,f(c))$ in modo che ci sia uno zero all'interno del nuovo intervallo.

Un *template* della funzione da implementare è il seguente:

  ```matlab
  function [c,residuo] = bisezione(f,a,b,maxit,tol)
  %%BISEZIONE applica il metodo di bisezione per il calcolo di f(x) = 0
  % Input:  f function handle della funzione di cui si cerca lo zero
  %         a estremo sinistro dell'intervallo
  %         b estremo destro dell'intervallo
  %         maxit numero massimo di iterazioni
  %         tol tolleranza richiesta su abs(f(c))
  % Output: c vettore dei valori trovato dall'algoritmo
  %         residuo vettore che contiene tutti i residui abs(f(c))


  end
  ```
È importante che la funzione implementata
- faccia il controllo degli input,
- pre-allochi la memoria per i vettori `c` e `residuo`,
- riduca al minimo le chiamate ad $f(\cdot)$.

Per testare l'algoritmo possiamo usare il problema di test:
```matlab
%% Test del metodo di bisezione

clear; clc; close all;

f = @(x) x.^3 -x -2;
a = 1;
b = 2;
maxit = 200;
tol = 1e-6;

[c,residuo] = bisezione(f,a,b,maxit,tol);
```
:::

## Convergenza

L'analisi di convergenza per questo metodo vista a lezione ci dice che, se
chiamiamo $c_n$ l'iterata $n$-ma prodotta dal metodo e $c$ la radice dell'equazione
$f(x) = 0$, allora
```{math}
| c_n - c | \leq \frac{|b-a|}{2^n}.
```
Possiamo usare MATLAB per verificare che quanto abbiamo implementato sia
consistente con quanto abbiamo dimostrato, per farlo elaboriamo ulteriormente
l'esempio dell'Esercizio 1 con il seguente codice:
```matlab
ctrue = 1.52137970680456757;
n = 1:length(residuo);
semilogy(n,residuo,'x--',...
    n,abs(c-ctrue),'ro--',...
    n,abs(b-a)./(2.^n),'k-','LineWidth',2)
xlabel('Iterazione n');
legend('Residuo del metodo','Errore Assoluto c','Bound');
axis tight
```
Che ci permette di produrre la figura {numref}`bisezione-errore`, da cui osserviamo
che l'errore assoluto sulla radice $c$ segue l'andamento predetto dall'analisi
teorica.
```{figure} ./images/bisezione-errore.png
:name: bisezione-errore

Errore nel metodo di bisezione per la soluzione del problema dell'Esercizio 1.
```
Alcune note sul codice usato.
- Per confrontare la convergenza sulla $c_n$ abbiamo avuto necessità di avere un
valore di $c$ che abbiamo calcolato per altre via con 16 cifre di accuratezza,
- Abbiamo usato la funzione `semilogy` per avere un grafico delle quantità in
oggetto in cui abbiamo usato una scala logaritmica sull'asse delle $y$ (in cui
  stavamo riportando gli errori).
