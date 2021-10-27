# Laboratorio 6 : L'Eliminazione di Gauss il Metodo LU


## Esercizi

:::{admonition} Esercizio
La formulazione per gli spostamenti di una trave reticolare piana è simile a
quella di un sistema di masse e molle. Le differenze sono che
1. i termini di rigidità sono dati da $k_{i} = (E A/L)_ {i}$, dove $E$ è il modulo
di elasticità, $A$ rappresenta l'area della sezione di taglio e $L$ è la
lunghezza dell'elemento;
2. ci sono due componenti dello scostamento in ogni punto di giuntura.

Per la trave reticolare in figura:
```{figure} ./images/planetruss.png

Profilo di un elemento della trave reticolare piana.
```

si ottiene quindi il seguente sistema di equazioni lineari
```{math}
K \mathbf{u} = \mathbf{p}
```
dove
```matlab
K = [27.58  7.004 -7.004 0 0
     7.004 29.57  -5.253 0 -24.32
    -7.004 -5.253 29.57  0 0
    0 0 0 27.58 -7.004
    0 -24.32 0 -7.004 29.57];
p = [0 0 0 0 -45]'; % kN
```
si determinino tutti gli scostamenti $u_i$ per il sistema.
:::
