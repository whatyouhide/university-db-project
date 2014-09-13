### Ristrutturazione delle specifiche

##### Frasi di carattere generale

Si vuole realizzare una applicazione per un'azienda che gestisce impianti di
illuminazione pubblica.

##### Frasi relative a "impianto"

Il sistema **deve** raccogliere informazioni relative alla posizione e allo stato di
manutenzione e operativo di una serie di impianti. Di seguito vengono elencate
le tipologie di impianti e, tra parentesi, la quantità stimata di impianti da
gestire per ogni tipologia.

- lampioni (200.000)
- semafori (4.000)
- segnali stradali (1.000)
- quadri di controllo (11.000)
- attraversamenti pedonali (20.000)

Ogni impianto **deve** essere identificato da una codice univoco e **deve**
essere caratterizzato da:

- dati di localizzazione (latitudine e longitudine),
- indirizzo completo (via, numero civico di riferimento, comune, provincia),
- informazioni sul sostegno sul quale l'impianto stesso è montato
- caratteristiche della linea elettrica di alimentazione
- caratteristiche delle sorgenti di illuminazione
- altezza alla quale è montato l'impianto

Si **deve** conoscere quali sono gli impianti associati (controllati) da ogni
quadro di controllo.

Ogni quadro di controllo controlla mediamente 20 impianti, mentre ogni
"centralina semaforica" (quadro che controlla soltanto semafori) controlla
mediamente 4 semafori.

Su ogni impianto vengono effettuati *in media* 4 interventi di ispezione
all'anno.

*Operazione 3*: in fase di creazione di una nuova missione, a partire da una
posizione data, si **devono** individuare gli impianti più vicini fino a un
massimo di 50 impianti su cui non siano stati effettuati altri interventi
nell'ambito di missioni recenti (ossia occorse nell'ultimo mese).

*Operazione 4*: per ogni quadro di controllo che dovrà essere censito in una
data missione, si **dovrà** produrre la lista di tutti gli impianti a esso
connessi.

*Operazione 6*: al termine di una missione, di **deve** produrre la lista di
tutti gli impianti censiti (ovvero sui quali sono stati effettuati interventi di
censimento). Da questa lista si **dovranno** poter raggruppare gli impianti che
richiedono interventi di manutenzione, in base alla tipologia di intervento.

*Operazione 8*: per supportare l'installazione di nuovi impianti in una data
zona, si **devono** individuare i quadri di controllo circostanti (i più vicini
alla posizione del nuovo impianto) che abbiano un numero di uscite libere
sufficienti.

##### Frasi relative a "sostegno"

I sostegni **devono** essere caratterizzati da un tipo tra i seguenti:

- sostegni aerei
- staffe a muro
- pali a terra

I sostegni possono essere di diverso materiale. Di un sostegno si **deve**
conoscere lo stato di conservazione e una descrizione dell'eventuale intervento
di manutenzione richiesto.

Ogni impianto **deve** essere caratterizzato da informazioni sul sostegno sul
quale l'impianto stesso è montato.

##### Frasi relative a "linea elettrica di alimentazione"

Ogni impianto **deve** essere aver associate caratteristiche della linea
elettrica di alimentazione.

Per le caratteristiche della linea elettrica di alimentazione, si **deve**
registrare il tipo di alimentazione, compreso tra:

- pannello solare
- linea bifase
- linea trifase

Si **deve** registrare inoltre se la linea di alimentazione è presente in
pozzetto di derivazione, lo stato di conservazione e una descrizione
dell'eventuale intervento di manutenzione richiesto.

##### Frasi relative a "sorgente di illuminazione"

Ogni impianto **deve** essere caratterizzato da caratteristiche delle sorgenti
di illuminazione.

Relativamente alle sorgenti di illuminazione, se ne **deve** conoscere:

- il numero (per ogni impianto)
- il tipo di lampada utilizzata (per ogni sorgente di illuminazione)
- lo stato di funzionamento
- se è necessario sostituire la lampada

##### Frasi relative a "quadro di controllo"

I quadri di controllo **devono** essere caratterizzati, oltre che dalle
informazioni che caratterizzano un impianto, anche da:

- stato di funzionamento
- descrizione dell'eventuale intervento di manutenzione necessario
- numero di uscite disponibili

Un quadro di controllo può essere immerso in pozzetto, dunque ai tipi di
sostegno associati a un quadro di controllo si aggiunge il tipo "immerso in
pozzetto".

Si **deve** conoscere quali sono gli impianti associati (controllati) da ogni
quadro di controllo.

Ogni quadro di controllo controlla mediamente 20 impianti, mentre ogni
"centralina semaforica" (quadro che controlla soltanto semafori) controlla
mediamente 4 semafori.

Si vogliono registrare le letture effettuate (con periodicità mensile)
nell'ambito delle missioni assegnate a un operatore, relativamente ai consumi
registrati dai quadri di controllo. Per ogni lettura si **devono** registrare i
kilowatt/ora indicati dal quadro di controllo, la data della lettura e
l'operatore che l'ha effettuata.

*Operazione 4*: per ogni quadro di controllo che dovrà essere censito in una
data missione, si **dovrà** produrre la lista di tutti gli impianti a esso
connessi.

*Operazione 5*: all'approssimarsi della scadenza mensile (fine del mese), si
**deve** produrre la lista di tutti i quadri di controllo per i quali è ancora
necessario effettuare la lettura del consumo, ovvero per i quali non è ancora
disponibile una lettura effettuata nel mese in corso

*Operazione 7*: mensilmente si vuole calcolare il consumo registrato da ogni
quadro di controllo (risultante dalla differenza tra la lettura più recente e
quella che la precede).

*Operazione 8*: per supportare l'installazione di nuovi impianti in una data
zona, si **devono** individuare i quadri di controllo circostanti (i più vicini
alla posizione del nuovo impianto) che abbiano un numero di uscite libere
sufficienti.

##### Frasi relative a "lampione"

*Operazione 9*: ogni giorno si **deve** produrre la lista di tutti i lampioni
che illuminano attraversamenti pedonali e che hanno necessità di interventi di
manutenzione.

##### Frasi relative a "attraversamento pedonale"

Per ogni attraversamento pedonale si **deve** sapere qual è il lampione dedicato
alla sua illuminazione.

*Operazione 9*: ogni giorno si **deve** produrre la lista di tutti i lampioni
che illuminano attraversamenti pedonali e che hanno necessità di interventi di
manutenzione.

##### Frasi relative a "operatore"

L'azienda dispone di 40 operatori, che **devono** essere identificati da una
matricola e **devono** aver associate le seguenti informazioni anagrafiche:

- nome
- cognome
- email
- lista di numeri di telefono
- indirizzo di residenza (via, numero civico, comune, CAP)

Per ogni lettura si **deve** registrare l'operatore che l'ha effettuata.

##### Frasi relative a "missione"

Si **deve** mantenere uno storico delle missioni compiute da ogni operatore,
registrando:

- la data della missione
- la lista degli impianti su cui l'operatore assegnato alla missione è
    intervenuto

L'azienda dispone di 40 operatori ai quali, giornalmente, **deve** essere
assegnata una missione che consiste in una serie di interventi su impianti.

*Operazione 3*: in fase di creazione di una nuova missione, a partire da una
posizione data, si **devono** individuare gli impianti più vicini fino a un
massimo di 50 impianti su cui non siano stati effettuati altri interventi
nell'ambito di missioni recenti (ossia occorse nell'ultimo mese).

*Operazione 4*: per ogni quadro di controllo che dovrà essere censito in una
data missione, si **dovrà** produrre la lista di tutti gli impianti a esso
connessi.

*Operazione 6*: al termine di una missione, di **deve** produrre la lista di
tutti gli impianti censiti (ovvero sui quali sono stati effettuati interventi di
censimento). Da questa lista si **dovranno** poter raggruppare gli impianti che
richiedono interventi di manutenzione, in base alla tipologia di intervento.

##### Frasi relative a "intervento"

Si **deve** mantenere uno storico delle missioni registrando, per ogni
intervento associato a una missione:

- il tipo di intervento (censimento, ispezione, manutenzione, installazione)
- una descrizione dell'intervento

*Operazione 6*: al termine di una missione, di **deve** produrre la lista di
tutti gli impianti censiti (ovvero sui quali sono stati effettuati interventi di
censimento). Da questa lista si **dovranno** poter raggruppare gli impianti che
richiedono interventi di manutenzione, in base alla tipologia di intervento.

*Operazione 9*: ogni giorno si **deve** produrre la lista di tutti i lampioni
che illuminano attraversamenti pedonali e che hanno necessità di interventi di
manutenzione.

Mediamente su ogni impianto vengono effettuati 4 interventi di ispezione.

#### Operazioni

1. Fornire le istruzioni per la creazione del DB e degli oggetti che lo
costituiscono.
2. Per ogni relazione individuata, fornire le istruzioni di inserimento,
modifica ed eliminazione delle istanze.
3. In fase di creazione di una nuova missione, a partire da una posizione data,
si **devono** individuare gli impianti più vicini fino a un massimo di 50
impianti su cui non siano stati effettuati altri interventi nell'ambito di
missioni recenti (ossia occorse nell'ultimo mese).
4. Per ogni quadro di controllo che dovrà essere censito in una data missione,
si **dovrà** produrre la lista di tutti gli impianti a esso connessi.
5. All'approssimarsi della scadenza mensile (fine del mese), si **deve**
produrre la lista di tutti i quadri di controllo per i quali è ancora necessario
effettuare la lettura del consumo, ovvero per i quali non è ancora disponibile
una lettura effettuata nel mese in corso
6. Al termine di una missione, di **deve** produrre la lista di tutti gli
impianti censiti o ispezionati (ovvero sui quali sono stati effettuati
interventi di censimento o di ispezione). Da questa lista si **dovranno** poter
raggruppare gli impianti che richiedono interventi di manutenzione, in base alla
tipologia di intervento.  
**Raffinamento specifica** si è aggiunto anche il tipo `"ispezione"` ai tipi di
interventi citati nell'operazione 6. Questa scelta è derivata come conseguenza
naturale del fatto che gli interventi di ispezione hanno proprio lo scopo di
scoprire eventuali interventi di manutenzione necessari per un dato impianto.
7. Mensilmente si vuole calcolare il consumo registrato da ogni quadro di
controllo (risultante dalla differenza tra la lettura più recente e quella che
la precede).
8. Per supportare l'installazione di nuovi impianti in una data zona, si
**devono** individuare i quadri di controllo circostanti (i più vicini alla
posizione del nuovo impianto) che abbiano un numero di uscite libere
sufficienti.
9. Ogni giorno si **deve** produrre la lista di tutti i lampioni che illuminano
attraversamenti pedonali e che hanno necessità di interventi di manutenzione.
