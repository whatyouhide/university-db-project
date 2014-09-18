### Traduzione verso il modello relazionale

#### Associazioni molti a molti

Nello schema finale sviluppato sono presenti due associazioni molti a molti:

- l'associazione "intervento" tra missioni e impianti
- l'associazione "lettura" tra missioni e quadri di controllo

La traduzione di queste associazioni per il modello relazionale consiste nel
creare una relazione per ogni associazione molti a molti. Questa relazione avrà
il nome dell'associazione di partenza e come attributi avrà gli identificatori
delle entità parte dell'associazione e in più ogni attributo caratteristico
dell'associazione.

Nel caso specifico in esame, verranno create le relazioni **lettura** e
**intervento**.

#### Definizione delle relazioni

Di seguito definiamo le relazioni risultato della traduzione dello schema
sviluppato nel modello relazionale.

Si noti che le chiavi primarie delle tabelle sono, come di consueto, indicate
<u>sottolineando</u> il loro nome; le chiavi esterne, invece, sono indicate in
*corsivo* e descritte in dettaglio nella sezione successiva.

*Nota*: gli attributi composti sono rappresentati con un'abbreviazione del nome
dell'attributo composto, seguita da un carattere `"_"`, seguiti dal nome del
sotto-attributo. Ad esempio, l'attributo `tipo` di `impianto.sostegno` viene
individuato come `impianto.sost_tipo`.

- **impianto** (<u>codice</u>, lon_lat, altezza, tipo, *codice_lampione*,
    descrizione_intervento_richiesto, tipo_intervento_richiesto, sost_tipo,
    sost_stato_di_conservazione, ind_via, ind_numero_civico_di_riferimento,
    ind_comune, ind_provincia, alim_tipo_alimentazione,
    alim_stato_di_conservazione, alim_in_pozzetto_di_derivazione, installato,
    *controllato_da*) [*nota 1*]
- **sorgente_di_illuminazione** (<u>id</u>, da_sostituire, tipo_lampada,
    stato_di_conservazione, *codice_impianto*)
- **quadro_di_controllo** (<u>*codice_impianto*</u>, numero_uscite,
    stato_di_funzionamento)
- **operatore** (<u>matricola</u>, nome, cognome, email, ind_via,
    ind_numero_civico, ind_comune, ind_cap)
- **missione** (<u>*matricola_operatore*</u>, <u>data</u>)
- **telefono** (<u>*matricola_operatore*</u>, <u>numero</u>)
- **intervento** (<u>*codice_impianto*</u>, <u>*matricola_operatore*</u>,
    <u>*data*</u>, tipo, descrizione)
- **lettura** (<u>*matricola_operatore*</u>, <u>*data*</u>,
    <u>*codice_impianto*</u>, kilowatt_ora)


*Nota 1*: gli attributi `impianto.latitudine` e `impianto.longitudine` sono
stati fusi nel singolo attributo `lon_lat`, che rappresenta un punto su un
piano. Questa scelta deriva direttamente dalle possibilità offerte dal DBMS
scelto per l'implementazione e verrà discussa in dettaglio in seguito.

#### Vincoli di integrità referenziale

Si specificano le seguenti *foreign keys* sulle relazioni appena definite.

| Foreign key                                 | Verso                                  |
|-                                            | -                                      |
| `impianto.codice_lampione`                  | `impianto.codice`                      |
| `impianto.controllato_da`                   | `quadro_di_controllo.codice_impianto`  |
| `sorgente_di_illuminazione.codice_impianto` | `impianto.codice`                      |
| `quadro_di_controllo.codice_impianto`       | `impianto.codice`                      |
| `missione.matricola_operatore`              | `operatore.matricola`                  |
| `telefono.matricola_operatore`              | `operatore.matricola`                  |
| `intervento.codice_impianto`                | `impianto.codice`                      |
| `intervento.(matricola_operatore, data)`    | `missione.(matricola_operatore, data)` |
| `lettura.(matricola_operatore, data)`       | `missione.(matricola_operatore, data)` |
| `lettura.codice_impianto`                   | `impianto.codice`                      |

In figura gli stessi concetti sono rappresentati graficamente.

![](images/foreign-keys.png)
