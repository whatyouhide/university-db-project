### Decomposizione del testo in gruppi di frasi omogenee

##### Frasi di carattere generale

Si vuole realizzare una applicazione per un'azienda che gestisce impianti di
illuminazione pubblica.

##### Frasi relative a "impianto"

Il sistema deve raccogliere informazioni relative alla posizione e allo stato di
manutenzione e operativo di una serie di impianti quali: 200.000 lampioni, 4.000
semafori, 1.000 segnali stradali luminosi, 11.000 quadri elettrici di controllo,
20.000 attraversamenti pedonali.

Ogni impianto è identificato da una codice univoco ed è caratterizzato da: i
dati di localizzazione, ovvero dalle coordinate GPS e da un indirizzo completo
(via, numero civico di riferimento, comune, provincia e regione); informazioni
sul sostegno sul quale l'impianto stesso è montato; caratteristiche della linea
elettrica di alimentazione e le caratteristiche delle sorgenti di illuminazione.

[...] si vuole conoscere a quale altezza è montato l'impianto.

Bisogna anche conoscere quali sono gli impianti connessi e controllati da
ciascun quadro di controllo.

Si consideri che ogni quadro controlla mediamente 20 impianti di illuminazione
mentre ogni centralina semaforica controlla mediamente 4 semafori.

Mediamente ogni impianto viene ispezionato 4 volte all'anno.

*Operazione 3*: in fase di creazione di una nuova missione è necessario
individuare, a partire da una posizione data, gli impianti più vicini, fino ad
un massimo di 50, che non siano già stati oggetto di altre missioni recenti (< 1
mese).

*Operazione 4*: per ogni quadro di controllo che dovrà essere censito in una
data missione, bisognerà produrre la lista di tutti gli impianti ad esso
connessi.

*Operazione 6*: al termine di una missione, si vuole produrre la lista di tutti
gli impianti censiti, raggruppando quelli che richiedono interventi di
manutenzione, in base alla tipologia di intervento (e.g. quelli che richiedono
la sostituzione di lampade, quindi quelli che richiedono interventi sulle linee
di alimentazione, ecc.)

*Operazione 8*: per supportare l'installazione di nuovi impianti in una data
zona, si devono individuare i quadri di controllo circostanti che abbiano un
numero di uscite libere sufficienti.

##### Frasi relative a "sostegno"

I sostegni possono essere di diverso tipo (sostegni aerei, staffe a muro o pali
a terra), di diverso materiale [...]. Inoltre [del sostegno] se ne deve
conoscere lo stato di conservazione e una descrizione dell'eventuale intervento
di manutenzione richiesto.

Ogni impianto [...] è caratterizzato da [...] informazioni sul sostegno sul
quale l'impianto stesso è montato.

I quadri di controllo sono caratterizzati [...] dalle informazioni di sostegno.

##### Frasi relative a "linea elettrica di alimentazione"

Per le caratteristiche di alimentazione bisogna registrare il tipo di
alimentazione (i.e. pannello solare, linea bifase o trifase), se è presente in
pozzetto di derivazione e [...] lo stato di conservazione e l'eventuale
manutenzione richiesta.

Ogni impianto [...] è caratterizzato da [...] caratteristiche della linea
elettrica di alimentazione.

I quadri di controllo sono caratterizzati [...] dalle informazioni di
alimentazione.

##### Frasi relative a "sorgente di illuminazione"

Relativamente alle sorgenti di illuminazione se ne vuole conoscere il numero,
il tipo di lampade utilizzate, il loro stato di funzionamento e quante è
necessario sostituirne.

Ogni impianto [...] è caratterizzato da [...] caratteristiche delle sorgenti di
illuminazione.

##### Frasi relative a "quadro di controllo"

I quadri di controllo sono caratterizzati, oltre che dalle informazioni di
localizzazione, sostegno (i quadri possono essere montati su pali, su muri
tramite staffe o immersi in pozzetti) ed alimentazione, anche dai dati relativi
al codice del contatore che registra i consumi degli impianti connessi al quadro
stesso, il numero di uscite disponibili, lo stato di funzionamento e le
necessarie manutenzioni.

Bisogna anche conoscere quali sono gli impianti connessi e controllati da
ciascun quadro di controllo.

Si consideri che ogni quadro mediamente 20 impianti di illuminazione mentre ogni
centralina semaforica controlla mediamente 4 semafori.

*Operazione 4*: per ogni quadro di controllo che dovrà essere censito in una
data missione, bisognerà produrre la lista di tutti gli impianti ad esso
connessi.

*Operazione 5*: all'approssimarsi della scadenza mensile, si vuole produrre la
lista di tutti i quadri di controllo per i quali è ancora necessario effettuare
la lettura del contatore ovvero per i quali non è ancora disponibile una lettura
aggiornata nel mese in corso.

*Operazione 8*: per supportare l'installazione di nuovi impianti in una data
zona, si devono individuare i quadri di controllo circostanti che abbiano un
numero di uscite libere sufficienti.

##### Frasi relative a "contatore"

I quadri di controllo sono caratterizzati [...] dai dati relativi al codice del
contatore che registra i consumi degli impianti connessi al quadro stesso [...].

<strike>Infine si vogliono registrare le letture effettuate con periodicità
mensile [...] relativamente ai consumi registrati dai contatori associati a
ciascun quadro di controllo.</strike>

**Raffinamento specifica**: poiché in tutte le altre occasioni in cui viene
nominato un contatore esso viene nominato "al singolare" per un dato quadro di
controllo, si considera il precedente un errore semantico nei requisiti e si
raffina la specifica nel modo seguente:

> Infine si vogliono registrare le letture effettuate con periodicità mensile
relativamente al consumo registrato dal contatore associato a ciascun quadro di
controllo.

*Operazione 5*: all'approssimarsi della scadenza mensile, si vuole produrre la
lista di tutti i quadri di controllo per i quali è ancora necessario effettuare
la lettura del contatore ovvero per i quali non è ancora disponibile una lettura
aggiornata nel mese in corso.

*Operazione 7*: mensilmente si vuole calcolare il consumo registrato da ogni
contatore (data evidentemente dalla differenza tra l'ultima lettura e quella
precedente).

##### Frasi relative a "semaforo"

Si consideri che ogni quadro mediamente 20 impianti di illuminazione mentre ogni
centralina semaforica controlla mediamente 4 semafori.

##### Frasi relative a "lampione"

*Operazione 9*: ogni giorno bisogna produrre la lista di tutti i lampioni che
illuminano attraversamenti pedonali e che hanno necessità di interventi di
manutenzione. [vedi *nota* sotto *Frasi relative a "attraversamento pedonale"]

##### Frasi relative a "attraversamento pedonale"

<strike>[...] per ogni attraversamento pedonale si vuole sapere quale è
l'impianto dedicato alla sua illuminazione.</strike> [vedi nota]

*Operazione 9*: ogni giorno bisogna produrre la lista di tutti i lampioni che
illuminano attraversamenti pedonali e che hanno necessità di interventi di
manutenzione.

*Nota*: in realtà, siccome tra i possibili tipi di impianti elencati l'unico in
grado di illuminare un attraversamento pedonale è un "lampione", riformuleremo
la frase nel modo seguente:
> Per ogni attraversamento pedonale si vuole sapere quale è il lampione
dedicato alla sua illuminazione.

Poiché viene menzionato un *singolo* impianto, si assume che un lampione sia
sufficiente ad illuminare un attraversamento pedonale.

##### Frasi relative a "operatore"

L'azienda dispone di 40 operatori, identificati da una matricola e dalle
relative informazioni anagrafiche [...].

Infine si vogliono registrare le letture effettuate con periodicità mensile
nell'ambito delle missioni assegnate a un operatore [...].

Per ogni lettura si registrano [...] e l'operatore che l'ha effettuata.

##### Frasi relative a "missione"

Si vuole mantenere uno storico delle missioni compiute da ogni operatore,
registrando la data della missione, la lista degli impianti sui quali è
intervenuto, il tipo di intervento ed una sua descrizione.

[...] operatori [...] ai quali, giornalmente, viene assegnata una
missione che consiste in una attività che può essere di installazione,
censimento o manutenzione di uno o più impianti.

*Operazione 3*: in fase di creazione di una nuova missione è necessario
individuare, a partire da una posizione data, gli impianti più vicini, fino ad
un massimo di 50, che non siano già stati oggetto di altre missioni recenti (< 1
mese).

*Operazione 4*: per ogni quadro di controllo che dovrà essere censito in una
data missione, bisognerà produrre la lista di tutti gli impianti ad esso
connessi.

*Operazione 6*: al termine di una missione, si vuole produrre la lista di tutti
gli impianti censiti, raggruppando quelli che richiedono interventi di
manutenzione, in base alla tipologia di intervento (e.g. quelli che richiedono
la sostituzione di lampade, quindi quelli che richiedono interventi sulle linee
di alimentazione, ecc.)

##### Frasi relative a "intervento"

Si vuole mantenere uno storico delle missioni [...] registrando [...] il tipo di
intervento ed una sua descrizione.

*Operazione 6*: al termine di una missione, si vuole produrre la lista di tutti gli impianti
censiti, raggruppando quelli che richiedono interventi di manutenzione, in base
alla tipologia di intervento (e.g. quelli che richiedono la sostituzione di
lampade, quindi quelli che richiedono interventi sulle linee di alimentazione,
ecc.).

*Operazione 9*: ogni giorno bisogna produrre la lista di tutti i lampioni che
illuminano attraversamenti pedonali e che hanno necessità di interventi di
manutenzione.

##### Frasi relative a "ispezione"

Mediamente ogni impianto viene ispezionato 4 volte all'anno.

##### Frasi relative a "lettura"

Infine si vogliono registrare le letture effettuate con periodicità mensile,
nell'ambito delle missioni assegnate ad un operatore, relativamente ai consumi
registrati dai contatori associati a ciascun quadro di controllo. Per ogni
lettura si registrano i kilowatt/ora indicati dal contatore, la data della
lettura e l'operatore che l’ha effettuata.

*Operazione 5*: all'approssimarsi della scadenza mensile, si vuole produrre la
lista di tutti i quadri di controllo per i quali è ancora necessario effettuare
la lettura del contatore ovvero per i quali non è ancora disponibile una lettura
aggiornata nel mese in corso.
