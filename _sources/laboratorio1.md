# Laboratorio 1 : Introduzione a MATLAB

MATLAB/Simulink è uno strumento software per:
- Esecuzione di calcoli matematici ed elaborazione dei segnali,
- Analisi e visualizzazione dei dati: possiedi svariati strumenti grafici,
- Modellazione di sistemi e fenomeni fisici,
- Test e simulazioni di progetti ingegneristici.

## Il Desktop di Matlab

```{figure} ./images/matlabdesktop.png
:name: matlabdesktop

Il Desktop di Matlab
```

1. La **command window** è dove digiti i comandi MATLAB seguendo il prompt:
  ```
  >>
  ```
2. La finestra **workspace** mostra tutte le variabili che hai definito nella sessione
corrente. Le variabili possono essere effettivamente manipolate all'interno della
finestra dell'area di lavoro.

3. La **command history** mostra tutti i comandi MATLAB che hai usato di recente,
includendo anche le sessioni passate.

4. La **current folder** mostra tutti i file in qualsiasi cartella sia stata
selezionata per essere la cartella corrente.

## Operazioni artimetiche e ordine delle operazioni

- Le operazioni di base sono l'addizione (`+`), sottrazione (`-`), la
moltiplicazione (`*`), la divisione (`\`), l'elevamento a potenza (`^`),
- L'ordine delle operazioni è quello *canonico* adoperato in matematica e segue
le usuali convenzioni di una calcolatrice scientifica
  1. Si completano tutte le operazioni tra parentesi `( )` usando le seguenti
  regole di precedenza,
  2. Elevamento a potenza (da sinistra verso destra)
  3. Moltiplicazione e divisione (da sinistra verso destra)
  4. Addizione e sottrazione (da sinistra verso destra)

  :::{admonition} Esempio
  Si considerino ad esempio le seguenti operazioni:

    ```matlab
    30/5*3
    5*2^4+4*(3)
    -1^8
    8^(1/3)
    ```

  :::
(sec-variabili)=
## Variabili

Come in ogni linguaggio di programmazione, MATLAB fa utilizzo di **variabili**,
che, in informatica, sono contenitori di dati situate in una porzione della
memoria e destinate a contenere valori, che possono (in generale) essere
modificati nel corso dell'esecuzione di un programma.

Una variabile è caratterizzata da un nome (inteso solitamente come una sequenza
di caratteri e cifre) che deve seguire un insieme di *convenzioni* che dipende
dal linguaggio che si sta adoperando. In MATLAB le seguenti convenzioni devono
essere adoperate:
1. I nomi delle variabili devono iniziare con una lettera,
2. I nomi possono includere ogni combinazione di lettere, numeri, e *underscore*,
3. La lunghezza massima per il nome di una variabile è di 63 caratteri,
4. MATLAB è **case sensitive**. La variabile di nome `pAlla` è diversa dalla
variabile di nome `palla`,
5 È buona norma evitare i seguenti nomi:  `i`, `j`, `pi`, e più in generale
tutte i nomi di funzioni predefinite di MATLAB come, ad esempio, `length`,
`char`, `size`, `plot`, `break`, `cos`, `log`, etc.
6. È buona norma chiamare le variabili con nomi intellegibili, cioè con nomi che
riflettano l'uso che se ne fa all'interno del programma piuttosto che usare dei
nomi generici di variabili come ad esempio `x`, `y`, `z`.

:::{tip}
Se vogliamo calcolare l'aria superficiale di una sfera $A = 4\pi r^2$ di raggio $r = 5$, è molto
meglio scrivere
```matlab
raggio = 5;
area_superficiale = 4*pi*raggio^2
```
al posto di
```matlab
r = 5;
A = 4*pi*r^2
```
Quando riapriremo il secondo codice fra un mese le possibilità di ricordarsi
cosa intendevamo saranno piuttosto scarse (o, nel mio caso, anche se lo aprissi
fra due ore).
:::

Dall'esempio che abbiamo appena inserito nella **workspace** osserviamo diverse
cose
```matlab
raggio = 5;
area_superficiale = 4*pi*raggio^2
```
1. una variabile `raggio` di tipo `double` è stata creata,
2. una posizione di memoria per la variabile `raggio` è stata allocata ed
inizializzata al valore $5$,
3. il `;` al termine dell'istruzione sopprime la stampa a schermo del contenuto
della variabile,
4. la variabile `area_superficiale` viene invece creata ed allocata utilizzando
invece una delle quantità predeterminate di MATLAB, il valore di $\pi$, ed il
contenuto della variabile `raggio` che abbiamo definito in precedenza. Poiché non
abbiamo terminato la seconda istruzione con un `;`, vediamo stampato nella
**command window**
```
area_superficiale =

  314.1593
```
A questo punto possiamo cambiare il valore della variabile `raggio` semplicemente
riassegnandolo ad una nuova quantità *senza* alterare il valore conservato nel
**workspace** della variabile `area_superficiale`.

Per mostrare il contenuto di una variabile, si può utilizzare il comando `disp`,
ad esempio:
```matlab
disp("L'area superficiale della sfera è:"); disp(area_superficiale);
```
che produrrà nella **command window**:
```
L'area superficiale della sfera è:
  314.1593
```

### Variabili carattere e stringhe

Non siamo obbligati ad usare unicamente variabili di tipo numerico. Ad **esempio**
possiamo scrivere nella **command window**:
```matlab
studente='C.F. Gauss'
```
che ci stamperà
```
studente =

    'C.F. Gauss'
```
Abbiamo costruito un'**array** di `char`, cioè una variabile di nome `studente`
a cui abbiamo assegnato uno spazio di memoria e in cui abbiamo inserito i
caratteri `C.F. Gauss`. Nel dubbio, possiamo interrogare MATLAB riguardo il
tipo della variabile con il comando
```matlab
whos studente
```
che ci restituirà
```
  Name          Size            Bytes  Class    Attributes

  studente      1x10               20  char      
```
Una variante all'**array** di `char` è quello di definire invece un oggetto
`string`, cioè assegnare
```matlab
studente_stringa = "C.F. Gauss"
```
per cui `whos studente_stringa` ci dirà invece
```
Name                  Size            Bytes  Class     Attributes

studente_stringa      1x1               156  string              
```
Riassumendo:
- Un *array di `char`* è una sequenza di caratteri, proprio come un vettore
numerico è una sequenza di numeri. Un suo uso tipico è quello di memorizzare
brevi parti di testo come vettori di caratteri,
- Un oggetto `string`, ovvero un *array* di `string` è un contenitore per
parti di testo. Gli *array di stringhe* forniscono una serie di funzioni per
lavorare con il testo come dati.

## Alcune funzioni di cui è opportuno ricordarsi

MATLAB contiene un grande numero di funzioni matematica già implementate, alcune
di quelle di più frequente utilizzo sono riportate nella {numref}`tabfunzionidibase`

```{list-table} alcune funzioni di base.
:header-rows: 1
:name: tabfunzionidibase

* - Funzione
  - MATLAB
  - Funzione
  - MATLAB
* - Coseno
  - `cos`
  - Radice quadrata
  - `sqrt`
* - Seno
  - `sin`
  - Esponenziale
  - `exp`
* - Tangente
  - `tan`
  - Logaritmo (base 10)
  - `log10`
* - Cotangente
  - `cot`
  - Logaritmo (naturale)
  - `log`
* - Arcocoseno
  - `acos`
  - Arrotonda all'intero più vicino
  - `round`
* - Arcotangente
  - `atan`
  - Arrotonda all'intero $\leq$
  - `round`
* - Arcocotangente
  - `acot`
  - Arrotonda all'intero $\geq$
  - `ceil`
```
:::{danger}
Le funzioni trigonometriche così espresse assumono gli input in radianti, ovvero
le funzioni inverse restituiscono l'angolo in radianti. Le versioni che fanno
utilizzo dei gradi si invocano con il suffisso `d`, e.g., `cosd`, `acosd`.
:::

Se si incontra una funzione di cui non si conosce l'utilizzo è possibile
interrogare la guida di MATLAB dalla **command window** con, ad esempio,
```matlab
help cosd
```
che stamperà delle informazioni essenziali
```
cosd   Cosine of argument in degrees.
   cosd(X) is the cosine of the elements of X, expressed in degrees.
   For odd integers n, cosd(n*90) is exactly zero, whereas cos(n*pi/2)
   reflects the accuracy of the floating point value for pi.

   Class support for input X:
      float: double, single

   See also acosd, cos.

   Documentation for cosd
   Other functions named cosd
```
per cui poi si potrà accedere alle informazioni complete utilizzando il link
*Documentation for ...*.

Un'ultima coppia di funzioni estremamente utili è rappresentata dalle funzioni
* `clear` che svuota la **workspace** di tutte le variabili, ovvero `clear nomevariabile1 nomevariabile2` che cancella unicamente le variabili `nomevariabile1` e `nomevariabile2`,
* `clc` che cancella il contenuto stampato nella **command window**.

## Creazione di Script

Tutti (o quasi) i comandi visti fino ad ora sono in realtà degli **script** o
delle **funzioni** pre-costruite e rese disponibili nell'ambiente generale. MATLAB
permette all'utente di costruire i suoi script e le sue funzioni per la soluzione
di problemi specifici.

Uno **script file** è semplicemente una *collezione* di comandi eseguibili di
MATLAB e, in alcuni casi più raffinati, di interfacce verso software esterno
prodotto in C o in Fortran.

Per creare un nuovo script è sufficiente fare *click* sull'icona **New script**,
{numref}`newscript`, che aprirà una nuova finestra *editor* in cui è possibile
scrivere il proprio programma.

```{figure} ./images/newscript.png
:name: newscript

Crea un nuovo script.
```

Come abbiamo detto uno script non è nient'altro che una sequenza di comandi da
inserirsi nella finestra dell'editor. Per poter *eseguire* lo script è necessario
che questo sia salvato nella **Current Folder**.

:::{warning}
Le convenzioni per i nomi degli script sono le stesse che per i nomi delle
variabili ({ref}`sec-variabili`), in particolare è estremamente importante
evitare di usare nomi di funzioni predefinite di MATLAB.
:::

Per **eseguire** lo script si può
1. Fare click sul bottone **Run** ![Run](/images/mrun.png)
2. Inserire nella **command window** il nome con cui è stato salvato lo script
(senza l'estensione `.m`).

:::{admonition} Esempio
Trasformiamo in uno script il nostro codice per il calcolo dell'area superficiale
di una sfera. Ovvero, scriviamo all'interno dell'editor:
  ```matlab
  raggio = 5;
  area_superficiale = 4*pi*raggio^2;
  disp("L'Area Superficiale della Sfera è: "); disp(area_superficiale);
  ```
Salviamo il file come `areasfera.m` ed eseguiamolo una volta con il pulsante **Run**
ed una volta scrivendo `areasfera` nella **Command Window**.
:::

**Riassumendo** I file di script sono estremamente utili quando si intende
eseguire sequenze di molti comandi MATLAB. Immaginiamo ad esempio una sequenza
di calcoli divisa in $n$ comandi, dopo averli inseriti tutti nel *prompt* ci
accorgiamo che il valore assegnato ad una variabile al primo comando è sbagliato,
o vogliamo cambiarlo. Lavorando solo nella **command window** dovremmo correggere
l'errore nel primo comando, quindi eseguire di nuovo gli altri $n-1$ comandi.

Se avessimo prodotto invece uno script, potremmo semplicemente correggere il
primo comando ed eseguire nuovamente l'intera sequenza premendo un solo tasto
o scrivendo un solo comando: il nome dello script.

### Creazione di Funzioni

Una funzione (detta anche, a seconda del linguaggio di programmazione, routine,
  subroutine, procedura, metodo), è un particolare costrutto sintattico che
  raggruppa all'interno di un singolo programma, una sequenza di istruzioni in
  un unico blocco. Il suo scopo è quello di portare a termine una operazione,
  azione, o elaborazione in modo tale che, a partire da determinati *input*,
  restituisca determinati *output*.

In MATLAB una funzione di nome `miafunzione` è dichiarata come `function [y1,...,yN] = miafunzione(x1,...,xM)` che accetta come *input* `x1,...,xM` e restituisce come
*output* `y1,...,yN`. Questa dichiarazione **deve** essere la prima istruzione
eseguibile del file che contiene la funzione. Nomi validi di funzioni iniziano
con un carattere alfabetico e possono contenere lettere, numeri o *underscore*.

Si può salvare una funzione in
- un file funzione che contiene solamente definizioni di funzione. Il nome del
file *deve* corrispondere esattamente con il nome della prima funzione contenuta
nel file;
- uno script che toneiente comandi e definizioni di funzione. In questo caso le
funzioni *devono* essere contenute alla fine del file e lo *script* non può avere
lo stesso nome di nessuna delle funzioni contenute al suo interno.

I file possono includere molteplici funzioni locali o innestate. Al fine di
produrre del codice leggibile, è consigliato utilizzare sempre la parola chiave
`end` per indicare la fine di ogni funzione all'interno di un file.

In particolare, la parola chiave `end` è richiesta ogni qual volta:
- una qualunque funzione in un file contiene una funzione innestata,
- la funzione è una funzione *locale* all'interno di un file che contiene solo
funzioni e, a sua volta, ogni funzione locale usa la parola chiave `end`,
- la funzione è una funzione *locale* all'intero di uno *script*.

Per interrompere l'esecuzione di una funzione prima del raggiungimento dell'`end`
finale, si può utilizzare la parola chiave `return` che, come suggerisce il nome,
restituisce il controllo allo script che ha invocato la funzione. Una chiamata
diretta allo script o alla funzione che contiene `return`, non richiama alcun
programma di origine e restituisce invece il controllo al prompt dei comandi.

:::{admonition} Esempio
Trasformiamo in una funzione il nostro codice per il calcolo dell'area superficiale
di una sfera. Ovvero, scriviamo all'interno dell'editor:
```matlab
function [area_superficiale] = areasfera(raggio)
%%AREASFERA Funzione che calcola l'area superficiale di una sfera di raggio r
area_superficiale = 4*pi*raggio^2;
end
```
Salviamo il file come `areasfera.m` e possiamo eseguire la funzione direttamente
nella **command window** come
1. `area_superficiale = areasfera(raggio)`,
2. `area_superficiale = areasfera(raggio);`,
3. `areasfera(raggio)`.
Si osservino le differenze.
:::

## Array e Matrici

Abbiamo discusso fino ad ora l'utilizzo di variabili scalari, tuttavia in MATLAB
i dati sono rappresentati in maniera naturale come **matrici**, **array** e, più
in generale, **tensori**. È possibile applicare tutte le operazioni dell'algebra
lineare agli array, in più si possono creare griglie comuni, combinare array
esistenti, manipolare la forma e il contenuto di un array e utilizzare diverse
modalità di indicizzazione per accedere ai loro elementi.

In realtà, abbiamo già surrettiziamente lavorato con degli array, poiché in MATLAB
anche le variabili scalari non sono nient'altro che array unidimensionali, in
notazione matematica un $a \in \mathbb{R}$ è sempre un $a \in \mathbb{R}^{1\times 1}$.
Infatti se scriviamo nella **command window**:
```matlab
a = 100;
whos a
```
il sistema ci restituirà
```
Name      Size            Bytes  Class     Attributes

a         1x1                 8  double   
```
Immaginiamo ora di disporre di uno specifico insieme di dati, che vogliamo disporre
in una matrice. Possiamo farlo utilizzando la semantica delle parentesi quadre `[ ]`.

Una singola riga di dati contiene spazi o virgole `,` tra gli elementi e fa uso di
un punto e virgola `;` per separare le righe.

Ad esempio, se vogliamo crea una singola riga di tre elementi numerici
```matlab
v = [ 1 2 3]
```
oppure
```matlab
v = [ 1, 2, 3]
```
La dimensione della matrice risultante è 1 per 3, poiché ha una riga e tre colonne.
Una matrice di questa forma viene definita **vettore riga** e se chiamiamo la
funzione `isrow(v)` ci vediamo rispondere
```
ans =

  logical

   1
```
Similmente, possiamo costuire un **vettore colonna** come
```matlab
w = [ 1; 2; 3]
```
per cui abbiamo che invece `iscolumn(w)` ci restituirà
```
ans =

  logical

   1
```
Più in generale, possiamo costruire una matrice di $4 \times 4$ elementi come
```matlab
A = [ 1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16]
```
oppure come
```matlab
A = [ 1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12; 13, 14, 15, 16]
```
o
```matlab
A = [ 1, 2, 3, 4
      5, 6, 7, 8
      9, 10, 11, 12
      13, 14, 15, 16]
```
In tutti i casi ci vedremo restituire
```matlab
A =

     1     2     3     4
     5     6     7     8
     9    10    11    12
    13    14    15    16
```
Possiamo indagare le dimensioni di una matrice mediante la funzione `size(A)`,
che nel caso precedente ci restituirà
```
ans =

     4     4
```
### Costruttori predefiniti

Costruire matrici semplicemente inserendo i valori all'interno in sequenza o in
maniera esplicita è chiaramente scomodo (e molto noioso). A questo scopo MATLAB
possiede i costruttori riportati in {numref}`costruttoriarray`.

```{list-table} Costruttori per array e matrici.
:header-rows: 1
:name: costruttoriarray

* - Funzione
  - Operazione
* - `zeros`
  - **Crea un array di tutti zeri**
    Per costruire la matrice $0 = (O)_{i,j}$ $i,j=1,\ldots,n$ scriviamo
    ```matlab
    O = zeros(n,m);
    ```
* - `ones`
  - **Crea un array di tutti uno**
    Per costruire la matrice $1 = (E)_{i,j}$ $i,j=1,\ldots,n$ scriviamo
    ```matlab
    E = ones(n,m);
    ```
* - `rand`
  - **Crea un array di numeri casuali uniformemente distribuiti** in $[0,1]$.
    ```matlab
    R = rand(n,m);
    ```
    Possiamo generare numeri uniformemente distribuiti nell'intervallo $[a,b]$ come
    ```matlab
    R = a + (b-a).*rand(n,m);
    ```
* - `eye`
  - **Matrice identità** costruisce la matrice identità $(I)_{i,i} = 1$, $i=1,\ldots,n$
  e $0$ altrimenti `I = eye(n)`.
* - `diag`
  - Crea una **matrice diagonale** o estrae gli elementi diagonali di una matrice data. Se `v` è un vettore di lunghezza $n$, allora `diag(v)` è una matrice la cui diagonale principale è data dagli elementi di `v`. Se `A` è una matrice allora `diag(v)` è un vettore che contiene gli elementi della diagonale principale di $A$.
```

Altre funzioni dello stesso tipo sono `true`, `false`, `blkdiag` e i loro
funzionamento può essere esplorato mediante la funzione `help`.

Il secondo insieme di funzioni estremamente utile per costruire matrici è quello
che si occupa di gestire le concatenazioni. Queste possono essere ottenute sia
utilizzando la notazione con le parentesi quadre `[ ]`, ad esempio,
```matlab
A = rand(5,5);
B = rand(5,10);
C = [A,B];
```
costruisce a partire dalle matrici $A \in \mathbb{R}^{5 \times 5}$,
$B \in \mathbb{R}^{5\times 10}$, la matrice $C \in \mathbb{R}^{5\times 15}$ ottenuta
ponendo una accanto alle altre tutte le colonne di $A$ seguite da quelle di $B$.
Alla stesso modo, si può ottenere la concatenazione verticale come
```matlab
A = rand(8,8);
B = rand(12,8);
C = [A;B];
```
che genererà la matrice $C \in \mathbb{R}^{20,8}$ ottenuta impilando tutte le
righe di $A$ seguite dalle righe di $B$.

:::{danger}
Le operazioni di concatenazione devono essere fatte tra matrici di dimensione
compatibile, non possono esserci "avanzi" tra le dimensioni in oggetto. Per
provare ad ottenere un errore si esegua:
```matlab
A = rand(5,5);
B = rand(5,10);
C = [A;B];
```
che restituirà
```
Error using vertcat
Dimensions of arrays being concatenated are not consistent.
```
:::
Al posto della notazione con le parentesi quadre è possibile fare uso delle
funzioni `horzcat` e `vertcat` che corrispondono, rispettivamente, alle
concatenazioni della forma `[,]` e `[;]`.

Se vogliamo costruire invece una matrice diagonale a blocchi a partire dai blocchi
diagonali possiamo utilizzare la funzione `blkdiag` il cui `help` ci restituisce
esattamente
```
blkdiag  Block diagonal concatenation of matrix input arguments.

                                   |A 0 .. 0|
   Y = blkdiag(A,B,...)  produces  |0 B .. 0|
                                   |0 0 ..  |

   Class support for inputs:
      float: double, single
      integer: uint8, int8, uint16, int16, uint32, int32, uint64, int64
      char, logical
```

### Slicing: accedere agli elementi

Il modo più comune di accedere ad un determinato elemento di un array o di una
matrice è quello di specificare esplicitamente gli indici degli elementi.
Ad **esempio**, per accedere a un singolo elemento di una matrice, specificare
il numero di riga seguito dal numero di colonna dell'elemento:
```matlab
A = [ 1 2 3 4
      17 8 2 1];
A(2,1)
```
che stamperà nella **command window** `17`, cioè l'elemento in posizione riga
2 e colonna 1 di `A` ($a_{2,1}$).

Possiamo anche fare riferimento a più elementi alla volta specificando i loro
indici in un vettore. Ad **esempio**, accediamo al primo e al quarto elemento
della seconda riga della `A` precedente, facendo
```matlab
A(2,[1,4])
```
che restituirà
```
ans =

    17     1
```
Per accedere agli elementi in un intervallo di righe o colonne, è possibile
utilizzare l'operatore due punti `:`. Ad esempio, possiamo accedere accedi
agli elementi dalla prima alla quinta riga e dalla seconda alla sesta colonna di
una matrice $A$ come
```matlab
A = rand(10,10);
A(1:5,2:6)
```
Nel caso si voglia scorrere fino al termine di una dimensione è possibile
sostituire il valore di destra nei `:` con la parola chiave `end`, ad esempio:
```matlab
A(1:5,2:end)
```
Invece l'utilizzo di `:` senza valori di inizio/fine estrae tutte le entrate della
dimensione relativa, ad esempio, 5 colonna, `A(:,5)`, oppure colonne dalla quarta
alla settima, `A(:,4:7)`.

```{note}
In generale, si può utilizzare l'indicizzazione per accedere agli elementi di
qualsiasi array in MATLAB **indipendentemente** dal tipo di dati o dalle
dimensioni.
```
L'ultimo modo di fare uno *slicing* di un vettore di cui vogliamo parlare è
quello mediante **vettori logici**. L'utilizzo di indicatori logici `true` e
`false` è particolarmente efficace quando si lavora con istruzioni condizionali.
Ad **esempio**, supponiamo di voler sapere se gli elementi di una matrice $A$
sono maggiori degli elementi corrispondenti di un'altra matrice $B$.
L'operatore di confronto applicato alle due matrici restituisce un array
logico i cui elementi sono 1 quando un elemento in $A$ soddisfa il confronto con il
corrispondente elemento in $B$.  
```matlab
A = [1 2 6; 4 3 6];
B = [0 3 7; 3 7 5];
ind = A>B
A(ind)
B(ind)
```
ci restituisce
```
ind =

  2×3 logical array

   1   0   0
   1   0   1


ans =

     1
     4
     6


ans =

     0
     3
     5
```
Gli operatori di confronto non sono gli unici per cui è possibile compiere questa
operazione, MATLAB stesso implementa un certo numero di funzioni utili a questo
scopo, si vedano  `isnan`, `isfinite`, `isinf`, `ismissing`. È inoltre possibile
combinare insieme diverse richieste mediante l'uso degli **operatori logici**,
si veda più avanti la sezione su {ref}`sec-ifelsestuff`.

### Operazioni tra array e matrici

MATLAB supporta tutte le operazioni che hanno senso in termini di algebra lineare,
dunque prodotti matrici-vettore, somme di matrici e di vettori, trasposizione,
coniugio, *etc.*, con i medesimi vincoli di consistenza tra gli operatori.
Specificamente, il prodotto $A \mathbf{v}$ con $A \in \mathbb{R}^{n \times k_1}$
e $\mathbf{v} \in \mathbb{R}^{k_2}$ è possibile se e solo se $k_1 \equiv k_2$,
consideriamo ad esempio
```matlab
A = [1 2 3 4;
     4 3 2 1;
     2 4 3 1;
     3 2 4 1];
v1 = [1,2,3,4];
v2 = [1;2;3;4];
```
e proviamo a calcolare
- `A*v1` da cui otteniamo un errore:
```
Error using  *
Incorrect dimensions for matrix multiplication. Check that the number of columns in the first matrix matches the number of rows in the second matrix. To perform elementwise multiplication, use '.*'.
```
  poiché stiamo cercando di fare un'operazione che non ha senso dal punto di vista
  dell'algebra lineare.
- `A*v2` è invece l'operazione corretta e otteniamo
```
ans =

    30
    20
    23
    23
```
- `v1*A` anche questa operazione ha senso dal punto di vista matriciale e infatti
otteniamo
```
ans =

    27    28    32    13
```
- `v2*A` ha il medesimo problema della prima, cioè abbiamo di nuovo delle dimensioni
che non sono consistenti
```
Error using  *
Incorrect dimensions for matrix multiplication. Check that the number of columns in the first matrix matches the number of rows in the second matrix. To perform elementwise multiplication, use '.*'.
```
- `A*v1'` introduciamo qui l'operazione di trasposta-coniugata (che poiché stiamo
  utilizzando vettori di numeri reali coincide con la semplice operazione di
  trasposizione `.'`), che ci porta ad avere le dimensioni corrette e ci restituisce
```
ans =

    30
    20
    23
    23
```
- `A*v2'` la trasposizione in questo caso rende le dimensioni di `v2` incompatibili
per cui otteniamo di nuovo il medesimo errore
```
Error using  *
Incorrect dimensions for matrix multiplication. Check that the number of columns in the first matrix matches the number of rows in the second matrix. To perform elementwise multiplication, use '.*'.
```

:::{warning}
Il messaggio di errore che abbiamo incontrato ci dice che l'operazione non ha senso
in termine delle usuali operazioni dell'algebra lineare, tuttavia ci suggerisce
che quello che potevamo avere intenzione di fare era un prodotto **elementwise**
ovvero "elemento ad elemento". Questa operazione si ottiene utilizzando l'operatore
`.*`, cioè con un `.` prefisso davanti all'operatore di prodotto che in genere
significa proprio "esegui in maniera elemento-ad-elemento". Proviamo con la prima
operazione sbagliata che abbiamo proposto:
```matlab
A.*v1
```
che ci restituisce
```
ans =

     1     4     9    16
     4     6     6     4
     2     8     9     4
     3     4    12     4
```
Che operazione abbiamo eseguito? Si provi ad eseguire anche le operazioni di
elevamento a potenza
```matlab
A^3
A.^3
v1^3
v1.^3
```
e si descriva il risultato.
:::

Le ultime due operazioni che ci sono rimaste da descrivere sono `+`/`-`. Di nuovo
dobbiamo preoccuparci della compatibilità delle operazioni che vogliamo compiere.
Se vogliamo essere sicuri di star eseguendo la somma tra array e matrici che abbiamo
in mente dobbiamo assicurarci che le dimensioni siano compatibili.

Supponiamo di avere i vettori riga e colonna
```matlab
v = [1 2 3 4]
w = [1
     2
     3
     4]
```
se vogliamo sommarli o sottrarli e ottenere un vettore rispettivamente riga o
colonna dobbiamo fare in modo che abbiano ambedue la dimensione corretta. Ovvero,
dobbiamo avere, rispettivamente,
```matlab
v + w'
```
oppure
```matlab
v' + w
```
Se inavvertitamente sommiamo i due vettori come
```matlab
v + w
```
otteniamo invece
```
ans =

     2     3     4     5
     3     4     5     6
     4     5     6     7
     5     6     7     8
```
che è invece una matrice! Non esattamente quello che ci aspettavamo (riuscite
  a capire che operazione abbiamo ottenuto?). Uguale cautela va esercitata
  nello scrivere operazioni di somma/sottrazioni tra matrici e vettori.
  Si provi ad eseguire:
  ```
  A = pascal(4);
  v = [1 3 2 4];
  A + v
  A + v'
  A + 0.5
  v + 1
  ```

  È legittimo domandarsi a questo punto perché mai queste operazioni vengano
  eseguite senza restituire errori. Anche se dal punto di vista della pura
  algebra lineare queste operazioni non sono di immediata sensatezza, dal punto
  di vista implementativo permettono di semplificare (e velocizzare) un certo
  numero di operazioni che altrimenti richiederebbero diverse righe di codice
  (la cui ottimizzazione per le performance non è scontata) per essere
  implementate.

(sec-ifelsestuff)=
## Selezione e Strutture Condizionali

```{list-table} Strutture Condizionali.
:header-rows: 1
:name: tabcondizionali

* - Funzione di MATLAB
  - Descrizione
* - `if, elseif, else`
  - Execute statements if condition is true
* - `switch, case, otherwise`
  - Execute one of several groups of statements
* - `try, catch`
  - Execute statements and catch resulting errors
```

## Cicli e Cicli Innestati

```{list-table} Strutture Condizionali.
:header-rows: 1
:name: tabcicli
* - Funzione di MATLAB
  - Descrizione
* - for
  - for loop to repeat specified number of times
* - while
  - while loop to repeat when condition is true
* - break
  - Terminate execution of for or while loop
* - continue
  - Pass control to next iteration of for or while loop
* - pause
  - Stop MATLAB execution temporarily
```
