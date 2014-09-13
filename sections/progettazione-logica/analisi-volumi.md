### Analisi dei volumi

| Concetto                 | Tipo | Volume                |
|--                        | -    | -                     |
| impianto                 | E    | 236.000               |
| segnale stradale         | E    | 1.000                 |
| semaforo                 | E    | 4.000                 |
| attraversamento pedonale | E    | 20.000                |
| lampione                 | E    | 200.000               |
| quadro di controllo      | E    | 11.000                |
| operatore                | E    | 40                    |
| missione                 | E    | 40/giorno             |
| controllo                | R    | 225.000 [nota 1]      |
| illuminazione            | R    | 20.000                |
| intervento               | R    | 4.185/giorno [nota 2] |
| lettura                  | R    | 11.000/mese           |
| assegnamento             | R    | 40/giorno             |

*Nota 1* ci sono in totale 236.000 impianti, ma come specificato in **RV4**, un
quadro di controllo non può controllare un altro quadro di controllo. Di
conseguenza, il numero di impianti controllabili da un quadro di controllo
scende a 225.000.

*Nota 2* le specifiche specificano solo il numero medio annuale di *ispezioni*
per impianto, ma non specificano altri tipi di interventi (manutenzione,
installazione, censimento). Discutendo questo aspetto con il cliente, si sono
ottenute le seguenti informazioni aggiuntive:

- ogni impianto subisce in media un guasto (di qualsiasi tipo --- al sostegno,
    alla linea elettrica di alimentazione, etc.) ogni 12 mesi
- vengono installati in media 900 impianti all'anno
- ogni impianto viene censito in media una volta ogni 2 anni

Secondo i dati raccolti, si è calcolato che ogni impianto subisce in media, ogni
anno, i seguenti interventi:

- ispezione (4)
- manutenzione (1)
- censimento (0,5)

per un totale di 1,527,500 interventi annui più i 900 di installazione; in tutto
si hanno dunque 1,528,400 interventi annui in media. Questo risultato si traduce
in circa 4158 interventi giornalieri.

Gli interventi di installazione sono stati trascurati in questo calcolo in
quanto sono *una tantum* per ogni impianto.

##### Ottimizzazioni

Non si sono riscontrati colli di bottiglia di alcun tipo nello schema
sviluppato. L'unica associazione che potrebbe suggerire un'ottimizzazione è
l'associazione "controllo" di cui vi sono 225.000 istanze; l'associazione verrà
tuttavia rappresentata come un solo attributo dell'entità "impianto" e non
aggiungerà quindi oneri alla base di dati.
