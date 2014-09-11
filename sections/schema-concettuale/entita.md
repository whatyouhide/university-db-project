#### Promozione del concetto "impianto" a entità

La frase

> Ogni impianto è identificato da una codice univoco ed è caratterizzato da: i
> dati di localizzazione, ovvero dalle coordinate GPS e da un indirizzo completo
> (via, numero civico di riferimento, comune, provincia e
> <strike>regione</strike>) [vedi raffinamento specifica] [...].

e la frase

> [...] si vuole conoscere a quale altezza è montato l'impianto.

suggeriscono la creazione di un'entità impianto con i seguenti attributi:

- `codice` (che identifica un impianto)
- `latitudine`
- `longitudine`
- `altezza`
- `indirizzo`
    * `via`
    * `numero_civico_di_riferimento`
    * `comune`
    * `provincia`

**Raffinamento specifica** in Italia ogni provincia è identificata da una sigla
di due lettere *univoca*. Siccome una provincia può trovarsi in una sola
regione, l'attributo `regione` dell'attributo composto `indirizzo` è depennato
in quanto informazione ridondante. La scelta è giustificata anche dall'assenza
di operazioni o altre sezioni dei requisiti che menzionano la "regione" in cui
si trova un impianto.

##### Sostegno

Nonostante la frase

> I sostegni possono essere di diverso tipo (sostegni aerei, staffe a muro o
> pali a terra), di diverso materiale e si vuole conoscere a quale altezza è
> montato l'impianto. Inoltre [del sostegno] se ne deve conoscere lo stato di
> conservazione e una descrizione dell'eventuale intervento di manutenzione
> richiesto.

possa suggerire la creazione di un'entità "sostegno", essa non avrebbe poi
associazioni con altre entità (se non con "impianto") e sarebbe identificata
dalla sola associazione che avrebbe con "impianto". Si è deciso dunque di
rappresentarla come attributo composto di impianto. Di seguito l'attributo
composto con i suoi sotto-attributi:

- `sostegno`
    * `tipo`
    * `materiale`
    * `stato_di_conservazione`
    * `descrizione_intervento_richiesto`

*Nota*: `descrizione_intervento_richiesto` potrà assumere il valore nullo, ad
indicare che non è richiesto alcun intervento. La presenza di una descrizione
segnalerà dunque che è richiesto un intervento per il sostegno. Questo varrà
anche per le situazioni analoghe incontrate successivamente.

**Vincolo** il valore di `tipo` dell'attributo composto `sostegno` deve essere
uno dei seguenti:

- `"sostegno aereo"`
- `"staffa a muro"`
- `"palo a terra"`

##### Linea elettrica di alimentazione

La frase

> Per le caratteristiche di alimentazione bisogna registrare il tipo di
> alimentazione (i.e. pannello solare, linea bifase o trifase), se è presente in
> pozzetto di derivazione e [...] lo stato di conservazione e l'eventuale
> manutenzione richiesta.

suggerisce la creazione di un altro attributo composto di impianto, ovvero
`linea_elettrica_di_alimentazione`. La struttura del nuovo attributo composto è:

- `linea_elettrica_di_alimentazione`
    * `tipo_alimentazione`
    * `in_pozzetto_di_derivazione`
    * `stato_di_conservazione`
    * `descrizione_intervento_richiesto` [vedi *nota* in *Sostegno*]

**Vincolo** il valore di `tipo_alimentazione` deve essere uno dei seguenti:

- `"pannello_solare"`
- `"linea_bifase"`
- `"linea_trifase"`

##### Sorgente di illuminazione

Le frasi

> Ogni impianto [...] è caratterizzato da [...] caratteristiche delle sorgenti
> di illuminazione.

e

> Relativamente alle sorgenti di illuminazione se ne vuole conoscere il numero,
> il tipo di lampade utilizzate, il loro stato di funzionamento e quante è
> necessario sostituirne.

suggeriscono la creazione di un attributo composto `sorgente_di_illuminazione` con
cardinalità `1...N`.

Nonostante la specifica possa far intendere che a ogni sorgente di illuminazione
appartengono più lampade, una discussione con il cliente ha chiarito questo
aspetto: a ogni sorgente di illuminazione corrisponde una lampada -- o meglio,
ogni sorgente di illuminazione *è* una lampada.

**Raffinamento specifica** l'attributo "numero di lampade da sostituire" è
stato depennato in favore di un attributo `da_sostituire` (booleano) di
`sorgente_di_illuminazione`. Sarà comunque possibile contare il numero di
sorgenti di illuminazione associate a un dato impianto che sono da sostituire.

L'attributo composto `sorgente_di_illuminazione` è strutturato nel modo
seguente:

- `sorgente_di_illuminazione`
    * `tipo_lampada`
    * `stato_di_conservazione` (e non "stato di funzionamento", per omogeneità
        col resto del sistema)
    * `da_sostituire`

**Vincolo** dopo aver discusso con il cliente, si è dedotto che, tra tutti gli
impianti, i "quadri di controllo" non hanno alcuna sorgente di illuminazione
(per loro natura). Si introduce dunque il vincolo che impone che i "quadri di
controllo" debbano avere l'attributo composto `sorgente_di_illuminazione` con
valore nullo.

![](images/entita-impianto.png)

#### Gerarchia con radice "impianto"

La frase:

> Il sistema deve raccogliere informazioni relative alla posizione e allo stato
> di manutenzione e operativo di una serie di impianti quali: 200.000 lampioni,
> 4.000 semafori, 1.000 segnali stradali luminosi, 11.000 quadri elettrici di
> controllo, 20.000 attraversamenti pedonali.

suggerisce una struttura gerarchica (generalizzazione) con "impianto" alla
radice e le seguenti specializzazioni:

- lampione
- semaforo
- segnale stradale
- quadro di controllo
- attraversamento pedonale

![](images/gerarchia-impianto.png)

#### Caratteristiche aggiuntive di "quadro di controllo"

La frase

> I quadri di controllo sono caratterizzati, oltre che dalle informazioni di
> localizzazione, sostegno (i quadri possono essere montati su pali, su muri
> tramite staffe o immersi in pozzetti) ed alimentazione, anche dai dati
> relativi al codice del contatore che registra i consumi degli impianti
> connessi al quadro stesso, il numero di uscite disponibili, lo stato di
> funzionamento e le necessarie manutenzioni.

descrive caratteristiche aggiuntive dell'entità "quadro di controllo"
(specializzazione di "impianto").


**Vincolo** siccome viene specificato che il sostegno che sorregge un quadro
elettrico può essere anche immerso in un pozzetto (mentre i sostegni che
sorreggono altri impianti non hanno questa opzione), si aggiunge il tipo
`"immerso in pozzetto"` ai tipi possibili per un sostegno e si introduce il
vincolo che un sostegno può essere di tipo `"immerso in pozzetto"` se e solo se
è il sostegno che sorregge un quadro di controllo.

Siccome un contatore è sempre associato a uno e un solo quadro di controllo, e
un quadro di controllo ha un solo contatore, si è deciso di inglobare le
caratteristiche del contatore direttamente nel relativo quadro di controllo.
Dopo aver discusso questa scelta con il cliente, il cliente si è trovato
d'accordo a depennare il concetto di "codice" associato a un contatore e di
inglobare le funzionalità del contatore direttamente nel quadro di controllo,
specialmente per quanto riguarda lo stato di funzionamento e la necessità di un
intervento di manutenzione. Se ci fosse un problema al contatore, esso andrebbe
semplicemente segnalato come problema del quadro di controllo di cui il
contatore fa parte; analogamente per gli interventi di manutenzione.

Un quadro di controllo avrà i seguenti attributi (oltre a quelli ereditati
dall'entità "impianto"):

- `numero_uscite`
- `stato_di_funzionamento`
- `descrizione_intervento_richiesto`

![](images/entita-quadro-di-controllo.png)

#### Associazione tra "quadro di controllo" e "impianto"

La frase

> Bisogna anche conoscere quali sono gli impianti connessi e controllati da
> ciascun quadro di controllo.

indica un'associazione "controllo" tra l'entità "quadro di controllo" e l'entità
"impianto". L'associazione ha cardinalità uno a molti: un impianto è controllato
da un solo quadro di controllo, che a sua volta controlla molti impianti.

**Vincolo** un quadro di controllo controlla impianti, ma un quadro di
controllo è allo stesso tempo una specializzazione di "impianto". Poiché un
quadro di controllo non può controllare sé stesso o altri quadri di controllo
(un quadro di controllo non ha bisogno di essere "controllato"), si introduce il
vincolo che gli impianti che partecipano alla relazione "controllo" non possano
essere quadri di controllo.

![](images/associazione-controllo.png)

#### Depennamento di "centralina semaforica"

La frase 

> Si consideri che ogni quadro mediamente 20 impianti di illuminazione mentre
> ogni centralina semaforica controlla mediamente 4 semafori.

suggerirebbe che "centralina semaforica" sia un concetto diverso (se pur
fortemente correlato) da "quadro di controllo".

Confrontando la specifica con il cliente, si è convenuti che "centralina
semaforica" non è altro che un quadro di controllo che controlla soltanto
semafori. Nella specifica non ci si riferisce mai (se non nella frase appena
citata) specificatamente a una centralina semaforica rispetto a un quadro di
controllo; se fosse necessario distinguere i due concetti, basterebbe
identificare le centraline semaforiche come "quadri di controllo che controllano
soltanto semafori".

#### Associazione tra "lampione" e "attraversamento pedonale"

L'operazione 9:

> Ogni giorno bisogna produrre la lista di tutti i lampioni che illuminano
> attraversamenti pedonali e che hanno necessità di interventi di manutenzione.

suggerisce la creazione di un'associazione "illuminazione" tra "attraversamento
pedonale" e "lampione" che indica quale lampione illumina un dato
attraversamento pedonale. L'associazione ha dunque cardinalità uno a uno.

![](images/associazione-illuminazione.png)

#### Promozione del concetto "operatore" a entità

La frase

> L'azienda dispone di 40 operatori, identificati da una matricola e dalle
> relative informazioni anagrafiche [...].

identifica l'entità "operatore". Gli attributi elencati in seguito (che
riguardano le informazioni anagrafiche) sono stati discussi con il cliente in
modo da dettagliare il concetto piuttosto vago di "informazioni anagrafiche".

- `matricola` (univoca)
- `nome`
- `cognome`
- `data_di_nascita`
- `telefono` (`[1...N]`)
- `email`
- `indirizzo_di_residenza`
    * `via`
    * `numero_civico`
    * `comune`
    * `cap`

![](images/entita-operatore.png)

#### Promozione del concetto "missione" a entità e "intervento" ad associazione

La frase

> operatori [...] ai quali, giornalmente, viene assegnata una missione che
> consiste in una attività che può essere di installazione,
> <strike>censimento</strike> [vedi *raffinamento specifica*] o manutenzione di
> uno o più impianti.

suggerisce la creazione di un'entità missione.

Gli attributi di una missione consistono nel solo attributo `data`, ossia la
data in cui viene svolta la missione.

Una missione è costituita da più interventi (attività), ognuno dei quali è
dedicato a un impianto. Si è scelto di rappresentare il concetto di "intervento"
come un'associazione molti a molti tra "impianto" e "missione".

**Raffinamento specifica** l'operazione 6:

> Al termine di una missione, si vuole produrre la lista di tutti gli impianti
> censiti, raggruppando quelli che richiedono interventi di manutenzione, in
> base alla tipologia di intervento (e.g. quelli che richiedono la sostituzione
> di lampade, quindi quelli che richiedono interventi sulle linee di
> alimentazione, ecc.).

(in particolare "impianti censiti") suggerisce che il "censimento" non sia in
realtà un tipo di intervento, bensì sia l'intervento stesso: un intervento (di
qualsiasi tipo) è implicitamente un'attività di censimento di uno specifico
impianto, dunque "censimento" non viene identificato come tipo di intervento e
viene depennato dalla specifica.

L'associazione "intervento" avrà gli attributi:

- `tipo`: il tipo di intervento (manutenzione o installazione);
- `tipologia_manutenzione`: l'operazione 6 (citata su) richiede che gli
    interventi *di manutenzione* vengano raggruppati tramite tipologia.
- `descrizione`: una descrizione dell'intervento effettuato da parte
    dell'operatore. Questo attributo assumerà il valore nullo finché
    l'intervento non verrà effettivamente svolto da un operatore.

**Vincolo** a causa dell'attributo `tipologia_manutenzione`, si introduce un
vincolo che richiede che `tipologia_manutenzione` sia nullo per un intervento
quando l'attributo `tipo` dello stesso intervento è diverso da "manutenzione".

La frase

> Mediamente ogni impianto viene ispezionato 4 volte all'anno.

suggerisce l'aggiunta di un nuovo tipo di intervento, ossia "ispezione".

**Vincolo** riassumendo, le possibili tipologie di intervento sono:

- `"installazione"`
- `"manutenzione"`
- `"ispezione"`

##### Lettura

La frase

> Infine si vogliono registrare le letture effettuate con periodicità mensile,
> nell'ambito delle missioni assegnate ad un operatore, relativamente ai consumi
> registrati dal contatore associato a ciascun quadro di controllo. Per ogni
> lettura si registrano i kilowatt/ora indicati dal contatore, la data della
> lettura e l'operatore che l’ha effettuata.

suggerisce l'aggiunta di un attributo `lettura_kilowatt_ora` (con possibile valore
nullo) all'associazione "intervento". In questo modo, la lettura dei
kilowatt/ora è associata a una missione (dunque una data e un operatore) e a un
intervento (e dunque a un impianto).

**Vincolo** l'attributo `lettura_kilowatt_ora` dell'associazione "intervento" può essere
non nullo se e solo se l'intervento in questione è associato a un impianto di
tipologia "quadro di controllo".

![](images/entita-missione-associazione-intervento.png)

#### Associazione tra "missione" e "operatore"

A ogni operatore viene giornalmente assegnata una missione e si è dunque scelto
di creare l'associazione "assegnamento" tra queste due entità.  
Considerando l'associazione come molti a molti, si riesce a rappresentare, in
modo compatto, anche il concetto di "storico" delle missioni, come richiesto
dalla frase:

> Si vuole mantenere uno storico delle missioni [...] registrando [...] il tipo
> di intervento ed una sua descrizione.

È possibile identificare la missione assegnata a un operatore in un dato giorno
basandosi soltanto sull'attributo `data` della missione; per ottenere lo storico
delle missioni di un operatore basta invece cercare tutte le missioni di
quell'operatore con `data` precedente a quella del giorno corrente.

![](images/associazione-assegnamento.png)
