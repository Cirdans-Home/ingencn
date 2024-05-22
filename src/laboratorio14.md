# Laboratorio 11b: Metodi Multistep Lineari

In questo laboratorio esploreremo i metodi multistep lineari per la risoluzione di equazioni differenziali ordinarie (ODE). Questi metodi, a differenza dei metodi single-step che utilizzano informazioni solo dall'intervallo attuale, sfruttano più intervalli precedenti per calcolare la soluzione. Vedremo la costruzione e l'implementazione di alcuni metodi multistep lineari e confronteremo la loro efficacia rispetto ai metodi di ordine inferiore.

## Problema ai Valori Iniziali

Consideriamo un problema ai valori iniziali per una equazione differenziale del primo ordine

```{math}
\begin{cases}
y'(t)=f(t,y(t))\\
y(t_0)=y_0
\end{cases}
```

## Metodi Multistep Lineari

Un metodo multistep lineare utilizza più punti precedenti per stimare la soluzione nel punto successivo. In generale, un metodo a $p+1$ passi può essere scritto come:

```{math}
y_{n+1} = \sum_{j=0}^{p} a_j y_{n-j} + h \sum_{j=0}^{p} b_j f_{n-j} + h b_{-1} f_{n+1}, \quad n = p, p+1, \ldots
```

dove $a_i$ e $b_i$ sono i coefficienti del metodo e $h$ è il passo di integrazione. Si noti che, in generale, se $b_{-1}$ è diverso da zero, il metodo è implicito, altrimenti il metodo è esplicito.

Un modo semplice per costruire metodi multi-step automaticamente consistenti e di alto ordine è sfruttare l'interpolazione polinomiale, nella formulazione differenziale del problema di Cauchy o nella sua forma integrale, ovvero, indicando con $I(y)$ o $I(f)$ una opportuna interpolazione polinomiale di grado $k\leq p+1$ della funzione $y$ o della funzione $f$, i seguenti metodi numerici multi-step sono automaticamente di ordine di consistenza almeno $k$:

```{math}
(I(y))'(t_{n+1}) = f(t_{n+1}, y_{n+1})
```

Scegliendo i punti di interpolazione tra i punti $y_{n-p}, ..., y_{n}, y_{n+1}$, calcolando la derivata della funzione interpolatrice e riordinando i termini si ottengono dei metodi della famiglia descritta sopra con $b_{-1}=1$ e $b_i = 0, i\ge 0$. I metodi BDF (*Backward Differentiation Formula*) sono un caso speciale di questi dove si utilizzano tutti i $p+2$ punti $y_{n-p}, ..., y_{n}, y_{n+1}$ per costruire un polinomio interpolatore di ordine $p+1$.

Usando invece la formulazione integrale

```{math}
y_{n+1} = y_{n-s} + \int_{t_{n-s}}^{t_{n+1}} I(f)
```

con $0\leq s\leq p$ e scegliendo i punti di interpolazione tra i punti $f(t_{n-p}, y_{n-p}), ..., f(t_{n}, y_{n}), f(t_{n+1}, y_{n+1})$ si ottengono metodi multistep dove solo il coefficiente $a_s = 1$ è $\neq 0$, e i coefficienti $b_i$ sono in generale diversi da zero, e coincidono con i pesi di quadratura (ovvero con l'integrale delle basi di Lagrange legate ai punti di interpolazione scelti per $f$).

I metodi di Adams-Bashfort (Espliciti) o Adams-Multon (Impliciti), sono costruiti con una interpolazione polinomiale su tutti i punti $f(t_{n-p}, y_{n-p}), ..., f(t_{n}, y_{n})$ (Adams-Bashfort), o includendo anche  $f(t_{n+1}, y_{n+1})$ (Adams-Multon), e calcolando l'integrale tra $t_n$ e $t_{n+1}$ ($s=0$ nella formula sopra).

Si noti che nei metodi di Adams di ordine $\gt 2$, l'intervallo di integrazione è sempre $(t_n, t_{n+1})$, ma il polinomio di interpolazione è calcolato anche usando punti esterni all'intervallo $(t_n, t_{n+1})$.

Un caso speciale che non rientra nei metodi qui sopra descritti, ma che è spesso usato, è dato scegliendo $p=1$, e $k=0$, e usando come punto di di interpolazione $f_n$:

```{math}
y_{n+1} = y_{n-1} + 2 h f(t_n, y_n)
```

In questo caso si utilizza la formula del punto medio per approssimare l'integrale, ovvero si considera $I(f)$ costante, con punto di interpolazione scelto nel mezzo dell'intervallo $t_{n-1}, t_{n+1}$. Questa scelta garantisce che l'integrale sia esatto per funzioni lineari, risultante in un metodo di ordine due.

### Basi di Lagrange su punti equispaziati

Le basi di Lagrange su punti a distanza $h$ tra loro possono essere espresse in modo esplicito.

Consideriamo $p+2$ punti equispaziati $t_{-p}, t_{-p+1}, \ldots, t_0, t_1 $con una distanza $h$ tra loro. Questi punti sono dati da:

$$
t_i = ih \quad \text{per} \quad i = -p, -p+1, \ldots, 0, 1
$$

Vogliamo derivare le basi di Lagrange per questi punti. La base di Lagrange $L_j(t)$ per il punto $t_j = jh$ è data dalla formula generale:
$$
L_j(t) = \prod_{\substack{-p \le m \le 1 \\ m \ne j}} \frac{t - mh}{jh - mh}
$$

Poiché $jh - mh = (j - m)h$, possiamo semplificare la formula come segue:
$$
L_j(t) = \prod_{\substack{-p \le m \le 1 \\ m \ne j}} \frac{t - mh}{(j - m)h} = \prod_{\substack{-p \le m \le 1 \\ m \ne j}} \frac{\frac{t}{h} - m}{j - m}
$$

Questa è la forma esplicita delle basi di Lagrange per punti equispaziati $t_{-p}, t_{-p+1}, \ldots, t_0, t_1 $con distanza $h$ tra loro.

Consideriamo un esempio con $p = 1$, ovvero un polinomio di grado 2. Questo significa che utilizziamo tre punti $t_{-1}, t_0, t_1$ con una distanza $h$ tra loro. I punti sono dati da:

$$
t_{-1} = -h, \quad t_0 = 0, \quad t_1 = h
$$

Deriviamo le basi di Lagrange per questi punti.

### Base $L_{-1}(t)$

$$
L_{-1}(t) = \prod_{\substack{-1 \le m \le 1 \\ m \ne -1}} \frac{\frac{t}{h} - m}{-1 - m} = \frac{\frac{t}{h} - 0}{-1 - 0} \cdot \frac{\frac{t}{h} - 1}{-1 - 1}
$$

$$
L_{-1}(t) = \frac{\frac{t}{h}}{-1} \cdot \frac{\frac{t}{h} - 1}{-2}
$$

$$
L_{-1}(t) = -\frac{t}{h} \cdot \frac{t - h}{2h}
$$

$$
L_{-1}(t) = -\frac{t(t - h)}{2h^2}
$$

### Base $L_0(t)$

$$
L_0(t) = \prod_{\substack{-1 \le m \le 1 \\ m \ne 0}} \frac{\frac{t}{h} - m}{0 - m} = \frac{\frac{t}{h} + 1}{0 + 1} \cdot \frac{\frac{t}{h} - 1}{0 - 1}
$$

$$
L_0(t) = \left( \frac{t + h}{h} \right) \cdot \left( \frac{t - h}{-h} \right)
$$

$$
L_0(t) = \frac{(t + h)(t - h)}{-h^2}
$$

$$
L_0(t) = \frac{t^2 - h^2}{-h^2}
$$

$$
L_0(t) = -\frac{t^2 - h^2}{h^2}
$$

### Base $L_1(t)$

$$
L_1(t) = \prod_{\substack{-1 \le m \le 1 \\ m \ne 1}} \frac{\frac{t}{h} - m}{1 - m} = \frac{\frac{t}{h} + 1}{1 + 1} \cdot \frac{\frac{t}{h} - 0}{1 - 0}
$$

$$
L_1(t) = \frac{\frac{t}{h} + 1}{2} \cdot \frac{\frac{t}{h}}{1}
$$

$$
L_1(t) = \frac{t + h}{2h} \cdot \frac{t}{h}
$$

$$
L_1(t) = \frac{(t + h)t}{2h^2}
$$

### Riepilogo delle Basi di Lagrange

Quindi, le basi di Lagrange per $p = 1$ su punti $t_{-1}, t_0, t_1$ con distanza $h$ tra loro sono:

$$
L_{-1}(t) = -\frac{t(t - h)}{2h^2}
$$
$$
L_0(t) = -\frac{t^2 - h^2}{h^2}
$$
$$
L_1(t) = \frac{(t + h)t}{2h^2}
$$

Queste basi di Lagrange possono essere utilizzate per costruire i polinomi di interpolazione e approssimare l'integrale o la derivata, come richiesto nei metodi di Adams e BDF.

### Adams-Bashforth (Esplicito)

Come detto, per il metodo di Adams-Bashforth, l'integrale viene approssimato utilizzando l'interpolazione polinomiale di Lagrange basata sui valori di $f$ in tutti i punti a disposizione nei precedenti $p$ intervalli, ad esclusione dell'ultimo. Ad esempio, per il metodo di Adams-Bashforth di ordine 2, usiamo i punti $ t_n $ e $ t_{n-1} $:

```{math}
y_{n+1} = y_n + h \left( \frac{3}{2} f(t_n, y_n) - \frac{1}{2} f(t_{n-1}, y_{n-1}) \right)
```

Da wikipedia, questi sono i primi Adams-Bashfort methods:

$$
\begin{align}
y_{n+1} &= y_n + hf(t_n, y_n) , \qquad\text{(This is the Euler method)} \\
y_{n+2} &= y_{n+1} + h\left( \frac{3}{2}f(t_{n+1}, y_{n+1}) - \frac{1}{2}f(t_n, y_n) \right) , \\
y_{n+3} &= y_{n+2} + h\left( \frac{23}{12} f(t_{n+2}, y_{n+2}) - \frac{16}{12} f(t_{n+1}, y_{n+1}) + \frac{5}{12}f(t_n, y_n)\right) , \\
y_{n+4} &= y_{n+3} + h\left( \frac{55}{24} f(t_{n+3}, y_{n+3}) - \frac{59}{24} f(t_{n+2}, y_{n+2}) + \frac{37}{24} f(t_{n+1}, y_{n+1}) - \frac{9}{24} f(t_n, y_n) \right) , \\
y_{n+5} &= y_{n+4} + h\left( \frac{1901}{720} f(t_{n+4}, y_{n+4}) - \frac{2774}{720} f(t_{n+3}, y_{n+3}) + \frac{2616}{720} f(t_{n+2}, y_{n+2}) - \frac{1274}{720} f(t_{n+1}, y_{n+1}) + \frac{251}{720} f(t_n, y_n) \right) .
\end{align}
$$

### Adams-Moulton (Implicito)

Per il metodo di Adams-Moulton, l'interpolazione polinomiale viene fatta utilizzando anche il punto $t_{n+1}$, rendendo il metodo implicito. Ad esempio, per il metodo di Adams-Moulton di ordine 2, usiamo i punti  $t_{n+1}, t_n$, e ritroviamo il metodo dei trapezi:

```{math}
y_{n+1} = y_n + \frac{h}{2} \left( f(t_{n+1}, y_{n+1}) + f(t_n, y_n) \right)
```

Da wikipedia, questa è la tabulazione per i primi Adams-Moulton methods:

$$
\begin{align}
y_{n} &= y_{n-1} + h f(t_{n},y_{n}), \\
y_{n+1} &= y_n + \frac{1}{2} h \left( f(t_{n+1},y_{n+1}) + f(t_n,y_n) \right), \\
y_{n+2} &= y_{n+1} + h \left( \frac{5}{12} f(t_{n+2},y_{n+2}) + \frac{8}{12} f(t_{n+1},y_{n+1}) - \frac{1}{12} f(t_n,y_n) \right) , \\
y_{n+3} &= y_{n+2} + h \left( \frac{9}{24} f(t_{n+3},y_{n+3}) + \frac{19}{24} f(t_{n+2},y_{n+2}) - \frac{5}{24} f(t_{n+1},y_{n+1}) + \frac{1}{24} f(t_n,y_n) \right) , \\
y_{n+4} &= y_{n+3} + h \left( \frac{251}{720} f(t_{n+4},y_{n+4}) + \frac{646}{720} f(t_{n+3},y_{n+3}) - \frac{264}{720} f(t_{n+2},y_{n+2}) + \frac{106}{720} f(t_{n+1},y_{n+1}) - \frac{19}{720} f(t_n,y_n) \right) .
\end{align}
$$

### BDF di ordine 2

Per il metodo BDF di ordine 2, utilizziamo l'interpolazione polinomiale basata sui punti $ t_{n-1}, t_n, t_{n+1} $:

```{math}
I(y)'(t_{n+1}) = \frac{1}{h} \left( \frac{1}{2} y_{n-1} - 2 y_n + \frac{3}{2} y_{n+1}  \right)
```

Poiché $ I(y)'(t_{n+1}) = f(t_{n+1}, y_{n+1}) $, otteniamo:

```{math}
f(t_{n+1}, y_{n+1}) = \frac{1}{h} \left( \frac{3}{2} y_{n+1} - 2 y_n + \frac{1}{2} y_{n-1} \right)
```

Risolviamo per $ y_{n+1} $:

```{math}
y_{n+1} = \frac{4}{3} y_n - \frac{1}{3} y_{n-1} + \frac{2h}{3} f(t_{n+1}, y_{n+1})
```

Da wikipedia, i primi BDF methods sono:

$$
\begin{aligned}
 & y_{n+1} - y_n = h f(t_{n+1}, y_{n+1}) \\
 & y_{n+2} - \tfrac43 y_{n+1} + \tfrac13 y_n = \tfrac23 h f(t_{n+2}, y_{n+2}) \\
 & y_{n+3} - \tfrac{18}{11} y_{n+2} + \tfrac9{11} y_{n+1} - \tfrac2{11} y_n = \tfrac6{11} h f(t_{n+3}, y_{n+3}) \\
 & y_{n+4} - \tfrac{48}{25} y_{n+3} + \tfrac{36}{25} y_{n+2} - \tfrac{16}{25} y_{n+1} + \tfrac{3}{25} y_n = \tfrac{12}{25} h f(t_{n+4}, y_{n+4}) \\
 & y_{n+5} - \tfrac{300}{137} y_{n+4} + \tfrac{300}{137} y_{n+3} - \tfrac{200}{137} y_{n+2} + \tfrac{75}{137} y_{n+1} - \tfrac{12}{137} y_n = \tfrac{60}{137} h
\end{aligned}
$$

## Implementazione

Implementeremo i metodi di Adams-Bashforth di ordine 2,  Adams-Moulton di ordine 3, e BDF di ordine 2 utilizzando i seguenti prototipi di funzione in MATLAB.

### Metodo di Adams-Bashforth

```matlab
function [y, t] = adams_bashforth(f, y0, a, b, h)
    %ADAMS_BASHFORTH Implementa il metodo di Adams-Bashforth di ordine 2.
    % INPUT:
    %        f   = handle della funzione che specifica l'equazione differenziale f(t,y)
    %        y0  = vettore dei valori iniziali
    %        a,b = estremi dell'intervallo di integrazione
    %        h   = passo di integrazione
    % OUTPUT:
    %        y = valori calcolati della soluzione nei corrispondenti valori di t
    %        t = valori di t nei quali è stata calcolata la soluzione

end
```

### Metodo di Adams-Moulton

```matlab
function [y, t] = adams_moulton(f, y0, a, b, h)
    %ADAMS_MOULTON Implementa il metodo di Adams-Moulton di ordine 3.
    % INPUT:
    %        f   = handle della funzione che specifica l'equazione differenziale f(t,y)
    %        y0  = vettore dei valori iniziali
    %        a,b = estremi dell'intervallo di integrazione
    %        h   = passo di integrazione
    % OUTPUT:
    %        y = valori calcolati della soluzione nei corrispondenti valori di t
    %        t = valori di t nei quali è stata calcolata la soluzione

end
```

### BDF di ordine 2

```matlab
function [y, t] = bdf2(f, y0, a, b, h)
    %BDF2 Implementa il metodo BDF di ordine 2.
    % INPUT:
    %        f   = handle della funzione che specifica l'equazione differenziale f(t,y)
    %        y0  = vettore dei valori iniziali
    %        a,b = estremi dell'intervallo di integrazione
    %        h   = passo di integrazione
    % OUTPUT:
    %        y = valori calcolati della soluzione nei corrispondenti valori di t
    %        t = valori di t nei quali è stata calcolata la soluzione

end
```

### Problema di Test

Testiamo i metodi sul seguente problema:

```matlab
%% Metodo di Adams-Bashforth, Adams-Moulton e BDF

clear; clc; close all;

f = @(t, y) - (2*y + (t^2)*(y^2))/(t);
ytrue = @(t) 1./(t.^2.*(log(t)+1));

a = 1;
b = 2;
h  = 1e-2;
y0 = 1;

[y_ab, t_ab] = adams_bashforth(f, y0, a, b, h);
[y_am, t_am] = adams_moulton(f, y0, a, b, h);
[y_bdf2, t_bdf2] = bdf2(f, y0, a, b, h);

figure(1)
plot(t_ab, y_ab, 'r--', t_ab, ytrue(t_ab), 'b-', 'LineWidth', 2);
xlabel('t');
legend({'Computed Solution (Adams-Bashforth)', 'True Solution'}, 'FontSize', 14);

figure(2)
plot(t_am, y_am, 'g--', t_am, ytrue(t_am), 'b-', 'LineWidth', 2);
xlabel('t');
legend({'Computed Solution (Adams-Moulton)', 'True Solution'}, 'FontSize', 14);

figure(3)
plot(t_bdf2, y_bdf2, 'k--', t_bdf2, ytrue(t_bdf2), 'b-', 'LineWidth', 2);
xlabel('t');
legend({'Computed Solution (BDF2)', 'True Solution'}, 'FontSize', 14);

figure(4)
semilogy(t_ab, abs(y_ab - ytrue(t_ab)), 'r-', 'LineWidth', 2);
hold on;
semilogy(t_am, abs(y_am - ytrue(t_am)), 'g-', 'LineWidth', 2);
semilogy(t_bdf2, abs(y_bdf2 - ytrue(t_bdf2)), 'k-', 'LineWidth', 2);
xlabel('t');
ylabel('Errore Assoluto');
legend({'Errore Adams-Bashforth', 'Errore Adams-Moulton', 'Errore BDF2'}, 'FontSize', 14);

```

## Analisi della Convergenza

Possiamo analizzare la convergenza dei metodi confrontando l'errore rispetto alla soluzione esatta:

```matlab
%% Convergenza
k = 9;
h = fliplr(logspace(-6, -1, k));
err_ab = zeros(k, 1);
err_am = zeros(k, 1);
for i = 1:k
    [y_ab, t_ab] = adams_bashforth(f, y0, a, b, h(i));
    [y_am, t_am] = adams_moulton(f, y0, a, b, h(i));
    yt = ytrue(t_ab);
    err_ab(i) = norm(y_ab - yt) / norm(yt);
    err_am(i) = norm(y_am - yt) / norm(yt);
end

figure(4)
loglog(h, err_ab, 'o-', h, err_am, 'x-', 'LineWidth', 2);
xlabel('h')
ylabel('Errore Relativo');
legend({'Errore Adams-Bashforth', 'Errore Adams-Moulton'}, 'FontSize', 14);
```

Da questa analisi possiamo osservare come i metodi di ordine più elevato raggiungono la precisione desiderata con un numero minore di passi di integrazione rispetto ai metodi di ordine inferiore, riducendo il costo computazionale.

:::{admonition} Esercizio
Implementate i metodi di Adams-Bashforth e Adams-Moulton di ordine 2 utilizzando i prototipi forniti e testateli sul problema descritto sopra. Verificate la convergenza dei metodi e confrontate i risultati.
:::

Buon lavoro!
