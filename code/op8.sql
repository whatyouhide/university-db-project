-- Operazione 8
-- ============
-- Per supportare l'installazione di nuovi impianti in una data zona, si devono
-- individuare i quadri di controllo circostanti (i più vicini alla posizione
-- del nuovo impianto) che abbiano un numero di uscite libere sufficienti.

-- TODO Serve o no? Metto l'attributo uscite libere e lo aggiorno? Questa si fa
-- mensilmente.
CREATE OR REPLACE FUNCTION uscite_libere_per_qdc(c CodiceImpianto)
RETURNS int AS $body$
DECLARE num_uscite int;
DECLARE num_impianti_collegati int;
BEGIN
  num_uscite := (
    SELECT numero_uscite FROM quadro_di_controllo WHERE codice_impianto = $1
  );

  num_impianti_collegati := (
    SELECT COUNT(*) FROM impianto WHERE controllato_da = $1
  );

  return (num_uscite - num_impianti_collegati);
END;
$body$ language plpgsql;

-- TODO commentare
CREATE OR REPLACE FUNCTION
qdc_con_sufficienti_uscite_libere(
  p point,
  num_uscite_necess int,
  lim int DEFAULT 10
)
RETURNS table (
  codice_qdc CodiceImpianto,
  posizione point,
  uscite_libere int,
  distanza_in_km float8
) AS $body$;

SELECT
  qdc.codice_impianto,
  imp.lon_lat,
  uscite_libere_per_qdc(qdc.codice_impianto),
  distance_in_km(p, imp.lon_lat) AS dist
FROM quadro_di_controllo AS qdc
JOIN impianto AS imp ON qdc.codice_impianto = imp.codice
WHERE uscite_libere_per_qdc(qdc.codice_impianto) >= num_uscite_necess
ORDER BY dist ASC
LIMIT lim;

$body$ language sql;
