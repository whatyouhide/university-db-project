# Testo originale

## Requisiti

Si vuole realizzare una applicazione per un'azienda che gestisce impianti di
illuminazione pubblica.

Il sistema deve raccogliere informazioni relative alla posizione e allo stato di
manutenzione e operativo di una serie di impianti quali: 200.000
lampioni, 4.000 semafori, 1.000 segnali stradali luminosi, 11.000
quadri elettrici di controllo, 20.000 attraversamenti pedonali.

Ogni impianto è identificato da una codice univoco ed è caratterizzato da: i
dati di localizzazione, ovvero dalle coordinate GPS e da un indirizzo completo
(via, numero civico di riferimento, comune, provincia e regione); informazioni
sul sostegno sul quale l'impianto stesso è montato; le caratteristiche della
linea elettrica di alimentazione e le caratteristiche delle sorgenti di
illuminazione.

I sostegni possono essere di diverso tipo (sostegni aerei, staffe a muro o
pali a terra), di diverso materiale e si vuole conoscere a quale altezza è
montato l'impianto. Inoltre se ne deve conoscere lo stato di conservazione e una
descrizione dell'eventuale intervento di manutenzione richiesto. Per le
caratteristiche di alimentazione bisogna registrare il tipo di alimentazione
(i.e. pannello solare, linea bifase o trifase), se è presente in pozzetto di
derivazione e, anche in questo caso, lo stato di conservazione e l'eventuale
manutenzione richiesta.

Relativamente alle sorgenti di illuminazione se ne vuole conoscere il numero,
il tipo di lampade utilizzate, il loro stato di funzionamento e quante è
necessario sostituirne.

I quadri di controllo sono caratterizzati, oltre che dalle informazioni di
localizzazione, sostegno (i quadri possono essere montati su pali, su muri
tramite staffe o immersi in pozzetti) ed alimentazione, anche dai dati relativi
al codice del contatore che registra i consumi degli impianti connessi al
quadro stesso, il numero di uscite disponibili, lo stato di funzionamento e le
necessarie manutenzioni.  Bisogna anche conoscere quali sono gli impianti
connessi e controllati da ciascun quadro di controllo. Si consideri che ogni
quadro mediamente 20 impianti di illuminazione mentre ogni centralina semaforica
controlla mediamente 4 semafori.

Infine, per ogni attraversamento pedonale, si vuole sapere quale è l'impianto
dedicato alla sua illuminazione.

L'azienda dispone di 40 operatori, identificati da una matricola e dalle
relative informazioni anagrafiche, ai quali, giornalmente, viene assegnata una
missione che consiste in una attività che può essere di installazione,
censimento o manutenzione di uno o più impianti. Mediamente ogni impianto viene
ispezionato 4 volte all'anno.

Si vuole mantenere uno storico delle missioni compiute da ogni operatore,
registrando la data della missione, la lista degli impianti sui quali è
intervenuto, il tipo di intervento ed una sua descrizione.

Infine si vogliono registrare le letture effettuate con periodicità mensile,
nell'ambito delle missioni assegnate ad un operatore, relativamente ai consumi
registrati dai contatori associati a ciascun quadro di controllo. Per ogni
lettura si registrano i kilowatt/ora indicati dal contatore, la data della
lettura e l'operatore che l'ha effettuata.

## Operazioni

Le operazioni sulla base di dati, oltre a quelle eventualmente ed implicitamente
definite nel testo precedente, sono:

1. Fornire le istruzioni per la creazione del DB e degli oggetti che lo costituiscono.
2. Per ogni relazione individuata, fornire le istruzioni di inserimento,
modifica ed eliminazione delle istanze.
3. In fase di creazione di una nuova missione è necessario individuare, a
partire da una posizione data, gli impianti più vicini, fino ad un massimo di
50, che non siano già stati
oggetto di altre missioni recenti (< 1 mese).
4. Per ogni quadro di controllo che dovrà essere censito in una data missione,
bisognerà produrre la lista di tutti gli impianti ad esso connessi.
5. All'approssimarsi della scadenza mensile, si vuole produrre la lista di tutti
i quadri di controllo per i quali è ancora necessario effettuare la lettura del
contatore ovvero per i quali non è ancora disponibile una lettura aggiornata nel
mese in corso.
6. Al termine di una missione, si vuole produrre la lista di tutti gli impianti
censiti, raggruppando quelli che richiedono interventi di manutenzione, in base
alla tipologia di intervento (e.g. quelli che richiedono la sostituzione di
lampade, quindi quelli che richiedono interventi sulle linee di alimentazione,
ecc.) 7. Mensilmente si vuole calcolare il consumo registrato da ogni contatore
(data evidentemente dalla differenza tra l'ultima lettura e quella precedente)
8. Per supportare l'installazione di nuovi impianti in una data zona, si devono
individuare i quadri di controllo circostanti che abbiano un numero di uscite
libere sufficienti.
9. Ogni giorno bisogna produrre la lista di tutti i lampioni che illuminano
attraversamenti pedonali e che hanno necessità di interventi di manutenzione
