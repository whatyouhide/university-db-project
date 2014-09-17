### Regole di vincolo (finali)

Si elencano di seguito tutte le regolo di vincolo presenti nel sistema; quelle
già definite formalmente nella sezione "Regole di vincolo" sono riportate
intatte o rivisitate, e ne sono presenti di nuove (quelle derivate da come è
stato strutturato -- e *ristrutturato* -- il sistema). In questo modo si ha a
disposizione una *reference* per l'implementazione della base di dati.

#### RVF1

`impianto.tipo` può assumere uno dei seguenti valori:

- `"lampione"`
- `"semaforo"`
- `"segnale stradale"`
- `"attraversamento pedonale"`
- `"quadro di controllo"`

#### RVF2

Essendo la generalizzazione "impianto" completa, `impianto.tipo` **non deve**
assumere il valore nullo.

#### RFV3

Quando `impianto.tipo` assume il valore `"quadro di controllo"`, **deve** essere
presente un'istanza dell'entità "quadro di controllo" che partecipi alla
relazione "controllo" insieme all'impianto in questione.

#### RFV4

`impianto.codice_lampione` **deve** assumere il valore nullo quando, per lo
stesso impianto, `impianto.tipo` è diverso da `"attraversamento pedonale"`.

#### RVF5

(derivato da **RV1**)

`impianto.sostegno.tipo` può assumere uno dei seguenti valori:

- `"sostegno aereo"`
- `"staffa a muro"`
- `"palo a terra"`
- `"immerso in pozzetto"`

#### RVF6

(derivato da **RV1**)

`impianto.sostegno.tipo` può assumere il valore `"immerso in pozzetto"` se e
solo se l'impianto in questione ha l'attributo `tipo` con valore `"quadro di
controllo"`.

#### RVF7

(derivato da **RV2**)

`impianto.linea_elettrica_di_alimentazione.tipo_alimentazione` può assumere uno
dei seguenti valori:

- `"pannello solare"`
- `"linea bifase"`
- `"linea trifase"`

#### RVF8

(derivato da **RV3**)

Se un impianto ha l'attributo `tipo` con il valore `"quadro di controllo"`, esso
non può partecipare all'associazione "sorgente".

#### RVF9

(derivato da **RV4**)

Un impianto che abbia l'attributo `tipo` uguale a `"quadro di controllo"` non
può partecipare all'associazione "controllo", ma solo in qualità di altro
estremo della relazione.

#### RVF10

(derivato da **RV5**)

`intervento.tipo` può assumere uno dei seguenti valori:

- `"censimento"`
- `"manutenzione"`
- `"installazione"`
- `"ispezione"`

#### RFV11

`impianto.indirizzo.provincia` deve essere una valida sigla di provincia
Italiana: deve essere lunga due caratteri maiuscoli e deve essere compresa nella
lista di province italiane. Per la lista di province si rimanda al codice SQL
che implementa questo vincolo.
