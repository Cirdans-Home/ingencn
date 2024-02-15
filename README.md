# ingencn

Calcolo Numerico - Laurea Triennale in Ingegneria dell'Energia - Esercitazioni di Laboratorio

## L'ambiente jupyter-book

Per generare le pagine web con jupyter-book è conveniente creare un *virtual environment* ed
utilizzare il file `requirements.txt` distribuito nel repository:

1. `python3 -m pip install --user virtualenv` (Installare virtualenv),
2. `python3 -m venv jupyterbook` (Creare un virtual environment),
3. `source jupyterbook/bin/activate` (Attivare il virtual environment),
4. `python3 -m pip install -r requirements.txt` (Installare i pacchetti necessari).

Tutte le volte che si vorrà aggiornare il materiale relativo ai laboratori sarà
sufficiente avviare il *virtual environment*:

```
source jupyterbook/bin/activate
```

navigare nella cartella del repository ed utilizzare `make`:

- `make clean` ripulisce la distribuzione,
- `make build` costruisce le pagine html,
- `make show` costruisce le pagine e le mostra in un browser locale,
- `make publish` utilizza `gh-pages` per pubblicare le pagine web,
- `make latex` produce una versione `.tex` dei laboratori.

The script `start.sh` performs the initialization of the environment for you. If you have never initialized the environment, it creates one for you (running exactly the commands above), otherwise it simply sources the virtual environment.
