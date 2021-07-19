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
di quelle di più frequente utilizzo sono riportate nella

```{list-table}
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
