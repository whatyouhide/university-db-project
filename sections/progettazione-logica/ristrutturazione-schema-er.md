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

Per convenzione, assumeremo che un impianto *ha bisogno di un intervento di
manutenzione* quando l'attributo `impianto.tipo_intervento_richiesto` non ha il
valore nullo.

Di viene raffigurata l'entità "impianto" aggiornata alla modifica appena
discussa; lo schema ER completo non viene riportato di nuovo per brevità.

![](images/entita-impianto-con-manutenzione.png)
