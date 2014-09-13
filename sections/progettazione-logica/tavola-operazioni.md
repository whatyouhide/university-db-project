### Tavola delle operazioni

Per quanto riguarda le *operazioni 1 e 2*, le entità "impianto" e le relative
specializzazioni non comportano situazioni particolari nella loro
creazione/distruzione. Le uniche associazioni tra queste entità sono:

- "controllo": ogni volta che si crea un impianto va specificato qual è il
    quadro di controllo che lo controlla;
- "illuminazione": ogni volta che viene creato un attraversamento pedonale va
    specificato il lampione che lo illumina.

Analoga è la situazione per tutte le altre istanze dello schema: non si sono
riscontrate operazioni di creazione/cancellazione/aggiornamento particolarmente
complicate.

L'*operazione 3* è probabilmente la più onerosa, in quanto ogni volta che viene
creata una missione (40 volte al giorno) vanno cercati gli impianti più vicini a
un dato punto nello spazio. Questo poiché gli impianti sono più di 200.000 e
l'operazione (di calcolo della distanza e ordinamento dei risultati) è per sua
natura computazionalmente "faticosa".

L'*operazione 4* è immediata in quanto ogni impianto è controllato da un solo
quadro di controllo, e dunque è semplice trovare tutti gli impianti controllati
da un dato quadro di controllo.

L'*operazione 5* potrebbe risultare onerosa in quanto bisogna risalire ai quadri
di controllo a partire da una selezione di letture (quelle dell'ultimo mese);
tuttavia i quadri di controllo risultano in numero contenuto (11.000) e la
frequenza dell'operazione è molto bassa (mensile).

L'*operazione 6* viene effettuata abbastanza spesso (40 volte al giorno, una per
ogni missione) e coinvolge circa 4000 impianti -- un impianto per intervento di
censimento o ispezione. Per come è stata strutturato lo schema concettuale,
quest'operazione risulta estremamente costosa in quanto per determinare se un
impianto ha bisogno di manutenzioni bisogna esaminare tutti i suoi attributi
composti e vedere se essi hanno singolarmente bisogno di manutenzioni. Nella
ristrutturazione dello schema ER porremo una soluzione a questo problema.

L'*operazione 9* supporta la scelta appena menzionata nell'operazione 6 in
quanto viene effettuata giornalmente su 20.000 lampioni e necessita di trovare
quelli che hanno bisogno di interventi di manutenzione.

L'*operazione 7* è immediata e viene oltretutto svolta con frequenza mensile,
dunque non impatta negativamente le performance della base di dati.

Infine, l'*operazione 8* opera su quadri di controllo (11.000) ma solo quando deve
essere installato un nuovo impianto (circa 900 volte all'anno o 2,5 volte al
giorno) e non risulta dunque essere particolarmente onerosa (nonostante, come
l'operazione 3, essa calcoli distanze tra un punto e quadri di controllo).
