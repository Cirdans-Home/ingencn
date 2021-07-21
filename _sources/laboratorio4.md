# Laboratorio 4 : Il Metodo di Newton


## Convergenza

### Stimare l'ordine di convergenza

In questo caso eravamo in possesso di un'analisi teorica completa che ci ha
permesso di calcolare l'ordine (o tasso) di convergenza del nostro metodo.
Può essere utile in alcuni casi avere una procedura numerica che ci permetta
di stimare l'ordine di convergenza.

Ricordiamo che una successione di approssimate $\{x_n\}_n$ che converge ad $x$
ha ordine di convergenza $p \geq 1$ se
```{math}
\lim_{n \rightarrow +\infty} \frac{|x_{n+1}-x|}{|x_n -x|^p} = \mu, \text{ con } \mu \in (0,1).
```
Possiamo sfruttare la definizione per ottenere una stima dell'ordine di
convergenza mediante i rapporti:

che possiamo implementare in una funzione MATLAB come
```matlab
function q = convergenza(xn, xtrue)
%%CONVERGENZA produce una stima dell'ordine di convergenza della
%%successione x_n ad xtrue.
  e = abs(xn - xtrue);
  q = zeros(length(e)-2,1);
  for n = 2:(length(e)-1)
      q(n-1) = log(e(n+1)/e(n))/log(e(n)/e(n-1));       
  end
end
```
