### Listing codice

Di seguito viene mostrato il codice SQL realizzato per l'implementazione della
base di dati modellata.

*Nota* dettagli e descrizioni del codice sviluppato sono presenti per lo più
sotto forma di commenti al codice SQL. Ulteriori osservazioni verranno
presentate all'inizio di ognuna delle sezioni che seguono.

#### `all.sql`

Non è altro che uno script SQL con sintassi specifica di PostgreSQL che esegue
tutti gli altri script SQL creati (in ordine). In questo modo è possibile
eseguire tutto il codice sviluppato (creazione di db e relazioni, operazioni
etc.) con il solo comando:

``` bash
psql -f code/all.sql 'nome-database-fittizio, di solito `template1`'
```

<<(code/all.sql)

#### `bootstrap.sql`

Questo script è il primo che viene eseguito e dunque esegue operazioni di base
come creazione del database e connessione ad esso.

- distruzione del database `illuminazione_pubblica` se presente in precedenza,
    in modo da poter partire con una "tavola bianca"
- creazione del database `illuminazione_pubblica` e connessione ad esso
- caricamento delle estensioni di PostgreSQL che sono state utilizzate

Lo script è responsabile dell'*operazione 1*.

<<(code/bootstrap.sql)

#### `domains.sql`

Questo script si occupa della creazione dei domini di dati utilizzati
nell'applicazione. La maggior parte di questi domini è stata creata in modo da
poter facilmente (e soprattutto senza "affollare" la creazione delle relazioni)
verificare i vincoli definiti sulla base di dati. La maggior parte di questi
vincoli è *di appartenenza*, ovvero consiste nel verificare che determinati
attributi appartengano a uno specifico insieme di valori.

<<(code/domains.sql)

#### `functions.sql`

In questo script vengono definite alcune funzioni *utility* (nella gran parte
scalari) che verranno utilizzate successivamente.

Il linguaggio usato per queste funzioni è il linguaggio procedurale messo a
disposizione da PostgreSQL
([PL/pgSQL](http://www.postgresql.org/docs/9.3/static/plpgsql.html)); la sua
sintassi è di immediata comprensione, specialmente alla luce della semplicità
delle funzioni create.

<<(code/functions.sql)

#### `table_creation.sql`

In questo script vengono create le relazioni nella base di dati. Tutti i
dettagli relativi a ciascuna relazioni sono espressi nei commenti del codice.

<<(code/table_creation.sql)

#### `create_update_delete.sql`

Questo script è volto a:

- popolare la base di dati
- mostrare come vengono eseguite le operazioni di inserimento, modifica e
    rimozione di righe dalle relazioni presenti nella base di dati
    (implementando effettivamente l'*operazione 2*).

Non tutte le operazioni (inserimento, modifica, rimozione) sono presenti per
ogni relazione creata; la maggior parte sarebbero minime variazioni di
operazioni già illustrate (ad esempio il cambiamento del nome di alcuni
attributi).

<<(code/create_update_delete.sql)

#### `op3.sql`...`op9.sql`

In questa serie di script è contenuto il codice necessario per svolgere le
operazioni ancora non affrontate (dall'*operazione 3* all'*operazione 9*).
Maggiori dettagli possono essere trovati nei commenti al codice relativo a
ciascuna operazione.

<<(code/op3.sql)
<<(code/op4.sql)
<<(code/op5.sql)
<<(code/op6.sql)
<<(code/op7.sql)
