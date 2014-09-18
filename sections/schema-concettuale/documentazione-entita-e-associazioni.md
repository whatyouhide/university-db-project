### Documentazione delle entità

| Entità                   | Descrizione                                          | Attributi                                                                                                          | Identificatore            |
|--                        | -                                                    | -                                                                                                                  | -                         |
| impianto                 | impianto di illuminazione
| latitudine, longitudine, altezza, indirizzo, sostegno,
sorgente_di_illuminazione, linea_elettrica_di_alimentazione, installato | codice                    |
| segnale stradale         | segnale stradale luminoso                            |                                                                                                                    |                           |
| semaforo                 | strumento per il controllo del traffico agli incroci |                                                                                                                    |                           |
| attraversamento pedonale | punto riservato all'attraversamento dei pedoni       |                                                                                                                    |                           |
| lampione                 | strumento di illuminazione della strada              |                                                                                                                    |                           |
| quadro di controllo      | strumento per il controllo di altri impianti         | numero_uscite, stato_di_funzionamento, descrizione_intervento_richiesto                                            |                           |
| operatore                | impiegato dell'agenzia                               | matricola, nome, cognome, email, telefono, indirizzo_di_residenza                                                  | matricola                 |
| missione                 | compito giornaliero assegnato agli operatori         | data                                                                                                               | data, matricola_operatore |


### Documentazione delle associazioni

| Relazione     | Descrizione                                                                   | Entità coinvolte                   | Attributi                                                       |
|--             | -                                                                             | -                                  | -                                                               |
| controllo     | associa un quadro di controllo agli impianti che controlla                    | quadro di controllo, impianto      |                                                                 |
| illuminazione | associa un lampione all'attraversamento pedonale che illumina                 | lampione, attraversamento pedonale |                                                                 |
| intervento    | associa una missione agli impianti su cui si è intervenuti in quella missione | missione, impianto                 | tipo, tipologia_manutenzione, descrizione, lettura_kilowatt_ora |
| lettura       | descrive la lettura di un quadro di controllo nell'ambito di una missione     | missione, quadro di controllo      | kilowatt_ora                                                    |
| assegnamento  | associa un operatore a ciascuna missione                                      | missione, operatore                |                                                                 |

