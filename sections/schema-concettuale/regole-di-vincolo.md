### Regole di vincolo

*Nota*: con la notazione `entità_o_associazione.attributo` si identificheranno
gli attributi delle varie entità con una notazione compatta.

##### RV1

`impianto.sostegno.tipo` può assumere uno dei seguenti valori:

- `"sostegno aereo"`
- `"staffa a muro"`
- `"palo a terra"`
- `"immerso in pozzetto"` [nota]

Nota: `impianto.sostegno.tipo` può assumere il valore `"immerso in pozzetto"` se
e solo se l'impianto in questione è un quadro di controllo.

##### RV2

`impianto.linea_elettrica_di_alimentazione.tipo_alimentazione` può assumere uno
dei seguenti valori:

- `"pannello solare"`
- `"linea bifase"`
- `"linea trifase"`

##### RV3

Un impianto non deve avere attributi `sorgente_di_illuminazione` se è ti
tipologia "quadro di controllo".

##### RV4

L'entità "quadro di controllo" non può partecipare in qualità di "impianto" alla
relazione "controllo", ma solo in qualità di altro estremo della relazione
(appunto "quadro di controllo").

##### RV5

`intervento.tipo` può assumere uno dei seguenti valori:

- `"censimento"`
- `"installazione"`
- `"manutenzione"`
- `"ispezione"`
