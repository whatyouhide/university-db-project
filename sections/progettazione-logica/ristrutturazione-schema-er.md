### Ristrutturazione dello schema ER

#### Manutenzione degli impianti

Come accennato nella sezione "Tavola delle operazioni", l'*operazione 6* e
l'*operazione 9* creano potenziali problemi di performance in quanto richiedono
di trovare tutti gli impianti che necessitano interventi di manutenzione.

Nello schema sviluppato finora, questo sarebbe possibile soltanto esaminando
*tutti* gli attributi composti dell'entità "impianto" e risulterebbe dunque
oneroso.

La soluzione scelta consiste nel "muovere" le informazioni relative a eventuali
interventi di manutenzione su sostegno, linea elettrica di alimentazione e
sorgente di illuminazione degli impianti. Queste informazioni sono state
spostate dai vari attributi composti dell'entità "impianto" all'entità impianto
stessa. Si è deciso che il componente che necessita l'intervento di manutenzione
può essere specificato nella descrizione dell'intervento richiesto e che il tipo
di intervento richiesto può essere specificato in modo più generale.

In questo modo diventa facile selezionare gli impianti che richiedono
manutenzioni e raggrupparli in base al tipo di manutenzione.

L'attributo `descrizione_intervento_richiesto` viene eliminato anche dall'entità
(specializzazione) "quadro" in quanto l'informazione è già contenuta nell'entità
di cui essa è figlia.

Per convenzione, assumeremo che un impianto *ha bisogno di un intervento di
manutenzione* quando l'attributo `impianto.tipo_intervento_richiesto` non ha il
valore nullo.

**Vincolo** si definisce il vincolo che impone che, per una data istanza di
impianto, `impianto.tipo_intervento_richiesto` può essere nullo *se e solo se* è
nullo anche `impianto.descrizione_intervento_richiesto` per lo stesso impianto.

Di seguito viene raffigurata l'entità "impianto" aggiornata alla modifica appena
discussa; lo schema ER completo non viene riportato di nuovo per brevità.

![](images/entita-impianto-con-manutenzione.png)

#### Generalizzazione "impianto"

La generalizzazione impianto presenta le seguenti caratteristiche:

- ha 5 specializzazioni
- la generalizzazione è *totale*
- "quadro di controllo" è l'unica specializzazione che ha attributi *aggiuntivi*
    rispetto a "impianto"
- le specializzazioni "segnale stradale" e "semaforo" non hanno attributi
    aggiuntivi né associazioni con altre entità nello schema
- "quadro di controllo" ha *due* associazioni specifiche che gli altri impianti
    non hanno ("controllo" e "lettura")
- l'associazione "illuminazione" coinvolge due specializzazioni, ma è di tipo
    uno a uno e può dunque essere rappresentata tramite un semplice attributo
    quando si tradurrà lo schema nel modello relazionale

Le possibili soluzioni per l'eliminazione delle generalizzazioni in vista della
traduzione al modello relazionale sono:

- accorpare tutte le specializzazioni nell'entità genitore della
    generalizzazione e aggiungere un attributo `tipo` all'entità genitore
- eliminare l'entità genitore e "distribuirla" nelle entità figlie
- sostituire la relazione di generalizzazione con associazioni tra le entità
    specializzazioni e l'entità genitore

La soluzione che si è scelto di adottare è in realtà un ibrido tra le tre
proposte: tutte le entità specializzazioni sono state accorpate nell'entità
"impianto" ad eccezione dell'entità "quadro di controllo", che viene associata
al relativo "impianto" con l'associazione "generalizzazione".  
La scelta è stata guidata dal fatto che tutte le altre specializzazioni di
"impianto" sono triviali e non contengono attributi aggiuntivi.

##### Ridondanza

Si è introdotta una ridondanza in modo da semplificare molti *check* di vincoli:
ogni quadro di controllo avrà come attributo `impianto.tipo` (dell'impianto
generalizzazione del quadro di controllo in questione) il valore `"quadro di
controllo"`.  
La ridondanza è presente in quanto sarebbe possibile inferire che un impianto è
un quadro di controllo semplicemente cercando un quadro di controllo che abbia
il `codice` corrispondente a quello dell'impianto stesso; siccome nel check dei
vincoli il DBMS scelto non consente di eseguire query annidate, l'assenza di
questa ridondanza porterebbe alla necessità di creare funzioni di check che
vengano triggerate quando c'è bisogno di eseguire questi controlli.

Si introduce il **vincolo** su `impianto.tipo`, che può assumere solo i valori:

- `"semaforo"`
- `"quadro di controllo"`
- `"segnale stradale"`
- `"lampione"`
- `"attraversamento pedonale"`

A seguito della ridondanza introdotta ed essendo la generalizzazione *completa*,
si aggiunge anche il **vincolo** che impone che `impianto.tipo` non sia nullo.

*Nota*: l'introduzione della ridondanza porta intuitivamente un ulteriore
**vincolo**, ossia che `impianto.tipo` può assumere il valore `"quadro di
controllo"` se e solo se quell'impianto è referenziato da un quadro di
controllo. Questo check va eseguito con una funzione triggerata come descritto
sopra, ma l'utilizzo di questo tipo di funzioni si limita (in questo modo) solo
a questo check.

L'unica associazione è "illumina": essa viene tradotta in un ulteriore attributo
dell'entità "impianto", ossia l'attributo `codice_lampione`. Esso si individua
univocamente il lampione che illumina un dato attraversamento pedonale, ed è
nullo quando `impianto.tipo` è diverso da `"attraversamento pedonale"`.

Si introduce dunque il **vincolo** che impone che `codice_lampione` per un dato
impianto sia nullo se quell'impianto non è un `attraversamento pedonale`, e il
**vincolo** che impone che `codice_lampione` si riferisca sempre a un impianto
di `tipo` `"lampione"`.

La porzione di schema modificata risulta come segue. Vengono indicati solo gli
attributi `impianto.tipo` e `impianto.codice_lampione` in quanto tutti gli altri
attributi vengono lasciati inalterati.

![](images/eliminazione-generalizzazione.png)

#### Eliminazione degli attributi multivalore

Gli attributi multivalore `operatore.telefono` e
`impianto.sorgente_di_illuminazione` vengono tradotti in entità.

- `operatore.telefono`: viene creata l'entità "telefono", associata
    molti a uno all'entità "operatore" tramite l'associazione
    "operatore_telefono".
- `impianto.sorgente_di_illuminazione`: viene creata l'entità "sorgente di
    illuminazione" che viene associata a "impianto" tramite l'associazione
    "sorgente". È necessario aggiungere l'attributo `id` all'entità "sorgente di
    illuminazione" in modo da avere una chiave primaria. Si è scelto un solo
    attributo numerico al posto di un attributo da accoppiare all'associazione
    "sorgente" per realizzare una chiave in modo da semplificare lo schema.  
    Si modifica infine il vincolo **RV3**, imponendo che un impianto non abbia
    "sorgenti di illuminazione" se quell'impianto partecipa all'associazione
    "generalizzazione" con un "quadro di controllo" (ovvero che i quadri di
    controllo non abbiano sorgenti di illuminazione, come esprimeva RV3).

#### Scelta degli identificatori principali

Tutti gli identificatori principali sono stati espressi nel corso della
progettazione avvenuta finora e sono evidenziati nello schema ER finale che ne è
risultato.

#### Schema finale

Lo schema finale risultante dalle ristrutturazioni effettuate è mostrato in
figura.

![](images/er-v2.png)
