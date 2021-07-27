# Laboratorio 8 : Metodi di Quadratura


## Applicazioni

:::{admonition} Accelerazione di una macchina

La {numref}`powertable` riporta la potenza $P$ fornita alle ruote motrici di una macchina come
funzione della velocità $v$. Se la massa della macchina è $m = 2000\,kg$, si
determini l'intervallo $\Delta t$ che serve alla macchina per accelerare da
$1\,m/s$ a $6\,m/s$ utilizzando la regola dei trapezi.

```{list-table} Potenza e velocità
:header-rows: 1
:name: powertable

* - $v\,(m/s)$
  - $P\,(kW)$
* - 0
  - 0
* - 1.0
  - 4.7
* - 1.8
  - 12.2
* - 2.4
  - 19.0
* - 3.5
  - 31.8
* - 4.4
  - 40.1
* - 5.1
  - 43.8
* - 6.0
  - 43.2
```
**Suggerimento:** La funzione di cui calcolare l'integrale si può ottenere dalla
seconda legge della dinamica e dalla definizione di potenza.
:::
