# Laboratorio 9 : Metodi di Interpolazione

Un **metodo iterativo** è una procedura matematica che a partire da un *valore iniziale* genera una sequenza di *soluzioni approssimate* migliorative per una
determinata classe di problemi, in cui l'approssimazione $n$esima è derivata dai precedenti. Abbiamo già visto, **ed implementato**, metodi di questo tipo per la ricerca degli zeri di una funzione.

In questo laboratorio vogliamo concentrarci invece sulla costruzione di alcuni
metodi di questo tipo per la soluzione di sistemi lineari.

La prima domanda che è legittimo porsi è perché mai vogliamo mettere in piedi
dei metodi iterativi se abbiamo già dei metodi diretti che possono raggiungere
la soluzione del problema cercato?
- A patto di richiedere una tolleranza minore (spesso sufficiente nelle applicazioni) sull'errore commesso sulla soluzione hanno un costo computazionale inferiore alle controparti dirette,
- Per le dimensioni dei problemi che si vogliono affrontare nelle applicazioni ingegneristiche attuali sono spesso l'unica opzione disponibile (problemi di fluidodinamica computazionale, combustione, meccanica del continuo, ...)

Nel corso e in questo laboratorio ci focalizziamo su alcuni dei metodi più semplici e che, in genere, sono usati come i blocchi costituivi di metodi più complessi (e.g., metodi di tipo *multigrid* o *domain decomposition*) o come acceleratori per la convergenza (in gergo chiamati: *precondizionatori*).

## Metodi di tipo stazionario

Dato un sistema lineare della forma
```{math}
A \mathbf{x} = \mathbf{b}, \qquad A \in \mathbb{R}^{n \times n},\; \mathbf{x},\mathbf{b} \in \mathbb{R}^n
```
siamo interessati a **metodi di punto fisso** basati sugli *splitting* della matrice $A$. Cioè metodi basati su una decomposizione additiva della matrice della forma
```{math}
A = M - N, \qquad\text{ con }\qquad \det(M) \neq 0.
```
Da questa decomposizione si ottiene poi l'iterata di punto fisso come
```{math}
A \mathbf{x} = \mathbf{b} \Rightarrow (M - N) \mathbf{x} = \mathbf{b} \Rightarrow M \mathbf{x} = N \mathbf{x} + \mathbf{b} \\
\mathbf{x} = M^{-1} N \mathbf{x} + M^{-1} \mathbf{b}
```
e quindi
```{math}
\mathbf{x}^{(k+1)} = M^{-1} N \mathbf{x}^{(k)} + M^{-1} \mathbf{b}, \quad k = 0,1,2,\ldots, \\
\mathbf{x}^{(0)} \text{ assegnato}.
```
Essendo questa un'iterata di punto fisso, la sua convergenza dipende dall'essere una **procedura contrattiva**, avete dimostrato a lezione che questo è equivalente alla richiesta che il *raggio spettrale* della matrice di iterazione $M^{-1}N$ sia strettamente minore di $1$:
```{math}
\rho(M^{-1}N) = \max_{1,\ldots,n }|\lambda_n(M^{-1}N)| < 1.
```