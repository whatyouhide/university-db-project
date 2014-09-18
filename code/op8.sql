-- Operazione 8
-- ============
-- Per supportare l'installazione di nuovi impianti in una data zona, si devono
-- individuare i quadri di controllo circostanti (i più vicini alla posizione
-- del nuovo impianto) che abbiano un numero di uscite libere sufficienti.


-- Per realizzare l'operazione descritta nell'operazione 8 si filtrano
-- semplicemente i quadri di controllo con sufficienti uscite libere rispetto a
-- quelle richieste dall'argomento `num_uscite_necess`; una volta filtrati, essi
-- si ordinano in base alla distanza dell'impianto ad essi associato dal punto
-- definito dall'argomento `posizione`.
-- Il terzo argomento, infine, specifica un numero massimo di quadri di
-- controllo che si vogliono visualizzare. Esso è stato aggiunto (anche se non
-- specificato nel requisito dell'operazione) in modo da non ottenere *tutti* i
-- quadri di controllo presenti con un numero sufficiente di uscite.
-- Proprio poiché questo terzo argomento non è richiesto dal testo
-- dell'operazione, ad esso è associato un valore di default (di 10 elementi) in
-- modo da poter invocare la funzine sia con che senza l'argomento in questione.
--
-- Seguono alcuni esempi di utilizzo:
--
--    SELECT * FROM qdc_con_sufficienti_uscite_libere('(12.03, 33.232)', 3);
--    SELECT * FROM qdc_con_sufficienti_uscite_libere('(14.79, 23.483)', 5, 2);

CREATE OR REPLACE FUNCTION
qdc_con_sufficienti_uscite_libere(
  p point,
  num_uscite_necess int,
  lim int DEFAULT 10
)
RETURNS table (
  codice_qdc CodiceImpianto,
  posizione point,
  uscite_libere smallint,
  distanza_in_km float8
) AS $body$;

SELECT
  qdc.codice_impianto,
  imp.lon_lat,
  numero_uscite_libere(qdc.codice_impianto),
  distance_in_km(p, imp.lon_lat) AS dist

FROM quadro_di_controllo AS qdc

JOIN impianto AS imp ON qdc.codice_impianto = imp.codice

WHERE numero_uscite_libere(qdc.codice_impianto) >= num_uscite_necess

ORDER BY dist ASC

LIMIT lim;

$body$ language sql;
