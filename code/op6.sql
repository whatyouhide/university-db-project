-- Operazione 6
-- ============
-- Al termine di una missione, di deve produrre la lista di tutti gli impianti
-- censiti o ispezionati (ovvero sui quali sono stati effettuati interventi di
-- censimento o di ispezione). Da questa lista si dovranno poter raggruppare gli
-- impianti che richiedono interventi di manutenzione, in base alla tipologia di
-- intervento.

-- Per realizzare questa operazione si è sviluppata una funzione che in input
-- accetta una chiave primaria della relazione `missione`, ossia una coppia
-- (matricola operatore, data).
-- La specifica dell'operazione richiede di poter raggruppare gli impianti in
-- base alla tipologia di intervento di manutenzione richiesto. Usando una
-- clausola GROUP BY, tuttavia, si sarebbe persa l'informazione su quali
-- impianti richiedessero interventi di manutenzione. Si sarebbe potuto trovare
-- il numero di questi impianti per tipologia di intervento richiesto (tramite
-- COUNT).
-- Per ovviare a questo problema si è scelto semplicemente di ordinare i
-- risultati della query in base proprio alla tipologia di intervento richiesto.
-- In questo modo gli impianti con tipologia di intervento richiesto uguale
-- saranno mostrati adiacenti nella query, simulando un raggruppamento dei
-- risultati.

CREATE OR REPLACE FUNCTION
impianti_in_missione_con_interventi_di_manutenzione(matr MatricolaOperatore, data date)
RETURNS table (
  tipo_intervento_effettuato TipoIntervento,
  data_intervento date,
  codice_impianto CodiceImpianto,
  tipo_impianto TipoImpianto,
  tipo_intervento_richiesto varchar(200),
  descrizione_intervento_richiesto text
) as $body$;

SELECT
  intervento.tipo,
  intervento.data,
  impianto.codice,
  impianto.tipo,
  impianto.tipo_intervento_richiesto,
  impianto.descrizione_intervento_richiesto
FROM missione
JOIN intervento ON
  intervento.data = missione.data
  AND intervento.matricola_operatore = missione.matricola_operatore
JOIN impianto ON
  impianto.codice = intervento.codice_impianto
WHERE
  missione.data = $2
  AND missione.matricola_operatore = $1
  AND impianto.tipo_intervento_richiesto IS NOT NULL
ORDER BY impianto.tipo_intervento_richiesto;

$body$ language sql;
