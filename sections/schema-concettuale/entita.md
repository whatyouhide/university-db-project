#### Promozione del concetto "impianto" a entità

La frase

> Ogni impianto è identificato da una codice univoco ed è caratterizzato da: i
> dati di localizzazione, ovvero dalle coordinate GPS e da un indirizzo completo
> (via, numero civico di riferimento, comune, provincia e regione) [...].

e la frase

> [...] si vuole conoscere a quale altezza è montato l'impianto.

suggeriscono la creazione di un'entità impianto e ne descrive gli attributi, che
risultano essere:

- `codice` (che identifica un impianto, e dunque può essere la *chiave
    primaria*)
- coordinate GPS (`latitudine` e `longitudine`)
- `altezza`
- `indirizzo`
    * `via`
    * `numero_civico_di_riferimento`
    * `comune`
    * `provincia`
    * <strike>regione</strike> [vedi nota]

**Raffinamento specifica**: in Italia ogni provincia è identificata da una sigla
di due lettere *univoca*. Siccome una provincia può ovviamente trovarsi in una
sola regione, l'attributo `regione` dell'attributo composto `indirizzo completo`
è depennato in quanto informazione ridondante. La scelta è giustificata anche
dall'assenza di operazioni o altre sezioni dei requisiti che menzionano la
"regione" in cui si trova un impianto.

#### Promozione del concetto "sostegno" a entità

La frase

> I sostegni possono essere di diverso tipo (sostegni aerei, staffe a muro o
> pali a terra), di diverso materiale e si vuole conoscere a quale altezza è
> montato l'impianto. Inoltre [del sostegno] se ne deve conoscere lo stato di
> conservazione e una descrizione dell'eventuale intervento di manutenzione
> richiesto.

suggerisce la creazione di un'entità "sostegno" e ne identifica gli attributi:

- `tipo` (sostegno aereo, staffa a muro, palo a terra)
- `materiale`
- `stato_di_conservazione`

Come si vedrà a breve, un sostegno è identificato univocamente dalla sua
relazione con un impianto.

Un sostegno potrebbe essere rappresentato anche come un attributo composto di un
impianto. Tuttavia, la specifica che riguarda la "descrizione dell'eventuale
intervento di manutenzione richiesto", insieme a diversi altri riferimenti a
"interventi di manutenzione" nei requisiti, suggerisce la creazione di un'entità
del tipo "intervento di manutenzione" con cui diverse altre entità possano
associarsi.

**Vincolo**: il valore di `tipo` deve essere uno dei seguenti:

- `"sostegno aereo"`
- `"staffa a muro"`
- `"palo a terra"`

#### Associazione tra "impianto" e "sostegno"

La frase

> Ogni impianto è caratterizzato da [...] informazioni sul sostegno sul quale
> l'impianto stesso è montato.

suggerisce la creazione di un'associazione "sostenimento" tra un "impianto" e un
"sostegno". Ogni impianto ha un sostegno e ogni sostegno appartiene ad un solo
impianto, dunque la relazione è del tipo *uno a uno*.

#### Promozione del concetto di "linea elettrica di alimentazione" a entità

La frase

> Per le caratteristiche di alimentazione bisogna registrare il tipo di
> alimentazione (i.e. pannello solare, linea bifase o trifase), se è presente in
> pozzetto di derivazione e [...] lo stato di conservazione e l'eventuale
> manutenzione richiesta.

suggerisce la creazione di un'entità "linea elettrica di alimentazione" con gli
attributi:

- `tipo_alimentazione` (pannello solare, linea bifase, linea trifase)
- `in_pozzetto_di_derivazione`
- `stato_di_conservazione`

**Vincolo**: il valore di `tipo_alimentazione` deve essere uno dei seguenti:

- `"pannello_solare"`
- `"linea_bifase"`
- `"linea_trifase"`

Analogamente a come deciso per il sostegno, si è estratta l'entità "linea
elettrica di alimentazione" (non rappresentandola come attributo composto di
impianto) in modo da poterla in seguito associare a un "intervento di
manutenzione".

La frase

> Ogni impianto [...] è caratterizzato da [...] caratteristiche della linea
> elettrica di alimentazione.

indica un'associazione "alimentazione" tra un "impianto" e una "linea elettrica
di alimentazione", di cardinalità uno a uno e che serve da chiave univoca per
l'entità "linea elettrica di alimentazione".

#### Promozione del concetto "sorgente di illuminazione" a entità

La frase

> Relativamente alle sorgenti di illuminazione se ne vuole conoscere il numero,
> il tipo di lampade utilizzate, il loro stato di funzionamento e quante è
> necessario sostituirne.

suggerisce la creazione di un'entità "sorgente di illuminazione". Nonostante la
specifica possa far intendere che a ogni sorgente di illuminazione appartengono più
lampade, una **discussione con il cliente** ha chiarito questo aspetto: a ogni
sorgente di illuminazione corrisponde una lampada -- o meglio, ogni sorgente di
illuminazione *è* una lampada.  
La relazione uno a molti è tra un impianto e un insieme di sorgenti di
illuminazione.

*Raffinamento specifica*: l'attributo "numero di lampade da sostituire" è stato
depennato in favore di un attributo `da_sostituire` (booleano) dell'entità
"sorgente di illuminazione". Sarà comunque possibile contare il numero di
sorgenti di illuminazione associate a un dato impianto che sono da sostituire.

Gli attributi dell'entità "sorgente di illuminazione" risultano dunque essere:

- `tipo_lampada`
- `stato_di_funzionamento`
- `da_sostituire`

Inoltre si aggiunge un attributo `id` (intero) che identifichi univocamente una
"sorgente di illuminazione".

La frase

> Ogni impianto [...] è caratterizzato da [...] caratteristiche delle sorgenti
> di illuminazione.

suggerisce la creazione di un'associazione "illuminazione" tra "impianto" e
"sorgente di illuminazione". L'associazione ha cardinalità uno a molti (un
impianto può avere più sorgenti di illuminazione).

**Vincolo**: dopo averne discusso con il cliente, si è dedotto che tra tutti gli
impianti, i "quadri di controllo" non hanno alcuna sorgente di illuminazione
(per loro natura). Si introduce dunque il vincolo che impone che solo impianti
che non siano "quadri di controllo" possono partecipare all'associazione
"illuminazione".

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
- quadro elettrico
- attraversamento pedonale

#### Caratteristiche aggiuntive di "quadro di controllo"

La frase

> I quadri di controllo sono caratterizzati, oltre che dalle informazioni di
> localizzazione, sostegno (i quadri possono essere montati su pali, su muri
> tramite staffe o immersi in pozzetti) ed alimentazione, anche dai dati
> relativi al codice del contatore che registra i consumi degli impianti
> connessi al quadro stesso, il numero di uscite disponibili, lo stato di
> funzionamento e le necessarie manutenzioni.

descrive caratteristiche aggiuntive dell'entità (specializzazione di "impianto")
"quadro di controllo".

**Vincolo**: siccome viene specificato che il sostegno che sorregge un quadro
elettrico può essere anche immerso in un pozzetto (mentre i sostegni che
sorreggono altri impianti non hanno questa opzione), si aggiunge il tipo
`"immerso in pozzetto"` ai tipi possibili per un impianto e si introduce il
vincolo che un sostegno può essere di tipo "immerso in pozzetto" se e solo se è
il sostegno che sorregge un determinato quadro elettrico.

Siccome un contatore è sempre associato a uno e un solo quadro di controllo, e
un quadro di controllo ha un solo contatore, si è deciso di inglobare le
caratteristiche del contatore direttamente nel relativo quadro di controllo.  
Dopo aver discusso questa scelta con il cliente, il cliente si è trovato
d'accordo a depennare il concetto di "codice" associato a un contatore e di
inglobare le funzionalità del contatore direttamente nel "quadro di controllo",
specialmente per quanto riguarda lo stato di funzionamento e la necessità di un
intervento di manutenzione. Se ci fosse un problema al contatore, esso andrebbe
semplicemente segnalato come problema del quadro di controllo di cui il
contatore fa parte; analogamente per gli interventi di manutenzione.

Un quadro di controllo avrà i seguenti attributi (oltre a quelli "ereditati"
dall'entità "impianto"):

- `numero_uscite`
- `stato_di_funzionamento`

#### Associazione tra "quadro di controllo" e "impianto"

La frase

> Bisogna anche conoscere quali sono gli impianti connessi e controllati da
> ciascun quadro di controllo.

indica un'associazione "controllo" tra l'entità "quadro di controllo" e l'entità
"impianto". L'associazione ha cardinalità uno a molti: un impianto è controllato
da un solo quadro di controllo, che a sua volta controlla molti impianti.

**Vincolo**: un quadro di controllo controlla impianti, ma un quadro di
controllo è allo stesso tempo una specializzazione di "impianto". Poiché un
quadro di controllo non può controllare sé stesso o altri quadri di controllo
(un quadro di controllo non ha bisogno di essere "controllato"), si introduce il
vincolo che gli impianti che partecipano alla relazione "controllo" non possono
essere quadri di controllo.

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

> ogni giorno bisogna produrre la lista di tutti i lampioni che illuminano
> attraversamenti pedonali e che hanno necessità di interventi di manutenzione.

suggerisce la creazione di un'associazione "illuminazione attraversamento" tra
"attraversamento pedonale" e "lampione" che indica quale lampione illumina un
dato attraversamento pedonale. La relazione ha dunque cardinalità uno a uno.

*Nota*: è facile confondere le associazioni "illuminazione" (tra sorgente di
illuminazione e impianto, dunque anche attraversamento pedonale) e
l'associazione "illuminazione attraversamento" appena descritta. Si noti che
esse sono semanticamente diverse: mentre la prima indica, ad esempio, le lampade
"verde, gialla e rossa" di un attraversamento pedonale, la seconda indica quale
lampione illumina l'area in cui si trova l'attraversamento pedonale.

#### Promozione del concetto "operatore" a entità

La frase

> L'azienda dispone di 40 operatori, identificati da una matricola e dalle
> relative informazioni anagrafiche [...].

identifica l'entità "operatore". Gli attributi elencati in seguito (che
riguardano le informazioni anagrafiche) sono stati discussi con il cliente in
modo da dettagliare il concetto piuttosto vago di "informazioni anagrafiche".

- `matricola` (chiave)
- `nome`
- `cognome`
- `data_di_nascita`
- `cellulare`
- `email`
- `indirizzo_di_residenza`
    * `via`
    * `numero_civico`
    * `comune`
    * `cap`

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

*Raffinamento specifica*: l'operazione 6:

> Al termine di una missione, si vuole produrre la lista di tutti gli impianti
> censiti, raggruppando quelli che richiedono interventi di manutenzione, in
> base alla tipologia di intervento (e.g. quelli che richiedono la sostituzione
> di lampade, quindi quelli che richiedono interventi sulle linee di
> alimentazione, ecc.).

 (in particolare "impianti censiti suggerisce che il
"censimento" non sia in realtà un tipo di intervento, bensì sia l'intervento
stesso: un intervento (di qualsiasi tipo) è implicitamente un'attività di
censimento di uno specifico impianto, dunque "censimento" non viene identificato
come tipo di intervento e viene depennato dalla specifica.

L'associazione "intervento" avrà gli attributi:

- `tipo`: il tipo di intervento (manutenzione o installazione);
- `tipologia_manutenzione`: l'operazione 6 (citata su) richiede che gli
    interventi *di manutenzione* vengano raggruppati tramite tipologia.
- `descrizione`: una descrizione dell'intervento effettuato da parte
    dell'operatore. Questo attributo assumerà il valore nullo finché
    l'intervento non verrà effettivamente svolto da un operatore.

**Vincolo**: a causa dell'attributo `tipologia_manutenzione`, si introduce un
vincolo che richiede che `tipologia_manutenzione` sia nullo per un intervento
quando l'attributo `tipo` dello stesso intervento è diverso da "manutenzione".

La frase

> Mediamente ogni impianto viene ispezionato 4 volte all'anno.

suggerisce l'aggiunta di un nuovo tipo di intervento, ossia "ispezione".

**Vincolo**: riassumento, le possibili tipologie di intervento sono:

- `"installazione"`
- `"manutenzione"`
- `"ispezione"`

#### Associazione tra "missione" e "operatore"

A ogni operatore viene giornalmente assegnata una missione e si è dunque scelto
di creare l'associazione "assegnamento" tra queste due entità.  
Considerando l'associazione come molti a molti, si riesce a rappresentare in
modo compatto il concetto di "storico" delle missioni, come richiesto dalla
frase:

> Si vuole mantenere uno storico delle missioni [...] registrando [...] il tipo
> di intervento ed una sua descrizione.

È possibile identificare la missione assegnata a un operatore in un dato giorno
basandosi soltanto sull'attributo `data` della missione; per ottenere lo storico
delle missioni di un operatore basta invece cercare tutte le missioni di
quell'operatore con `data` precedente a quella del giorno corrente.

#### Promozione del concetto di "lettura" ad associazione

La frase

> Infine si vogliono registrare le letture effettuate con periodicità mensile,
> nell'ambito delle missioni assegnate ad un operatore, relativamente ai consumi
> registrati dai contatori associati a ciascun quadro di controllo. Per ogni
> lettura si registrano i kilowatt/ora indicati dal contatore, la data della
> lettura e l'operatore che l’ha effettuata.

suggerisce la creazione di un'associazione "lettura" tra "operatore" e "quadro
elettrico".
L'associazione è del tipo molti a molti e ha gli attributi:

- `data`
- `kilowatt_ora` (al momento della lettura)
