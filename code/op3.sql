-- Operazione 3
-- ============
-- In fase di creazione di una nuova missione, a partire da una posizione data,
-- si devono individuare gli impianti più vicini fino a un massimo di 50
-- impianti su cui non siano stati effettuati altri interventi nell'ambito di
-- missioni recenti (ossia occorse nell'ultimo mese).

-- Per realizzare questa operazione si costruisce la funzione impianti_vicini().
-- Questa funzione prende in input una posizione. La funzione deve essere
-- invocata manualmente passando una coppia di coordinate in input, come
-- nell'esempio seguente:
--
--     SELECT * FROM impianti_vicini('(32.324234, 12.023123)');

-- Prima di tutto creiamo una view in cui filtriamo gli impianti che non hanno
-- ricevuto interventinell'ultimo mese.
CREATE VIEW impianti_senza_interventi_nellultimo_mese AS
  SELECT * FROM impianto WHERE codice NOT IN (
    SELECT codice_impianto
    FROM intervento
    WHERE data >= (CURRENT_DATE - interval '1 month')
    AND data <= CURRENT_DATE
  );

-- Creiamo una funzione al posto di una view in modo da poter parametrizzare la
-- posizione di partenza (come richiesto dall'operazione 3).
CREATE OR REPLACE FUNCTION impianti_vicini(posiz point)
-- La funzione ritorna una relazione.
RETURNS table (
  codice CodiceImpianto,
  tipo TipoImpianto,
  controllato_da CodiceImpianto,
  codice_lampione CodiceImpianto,
  lon_lat point,
  altezza integer,
  descrizione_intervento_richiesto text,
  tipo_intervento_richiesto varchar(200),
  sost_tipo TipoSostegno,
  sost_stato_di_conservazione varchar(200),
  alim_tipo_alimentazione TipoLineaElettricaDiAlimentazione,
  alim_stato_di_conservazione varchar(200),
  alim_in_pozzetto_di_derivazione boolean,
  ind_via varchar(200),
  ind_numero_civico_di_riferimento varchar(10),
  ind_comune varchar(100),
  ind_provincia Provincia,
  distanza float8
) as $body$;

-- Ordiniamo in base al valore (in km) della distanza tra la posizione data come
-- argomento (`$1`) e le posizione dei singoli impianti.
-- Sfruttiamo la view create in precedenza per selezionare gli impianti soltanto
-- tra quelli su cui non sono stati fatti interventi nell'ultimo mese.
SELECT *, miles_to_km($1 <@> lon_lat) AS distanza
FROM impianti_senza_interventi_nellultimo_mese
ORDER BY distanza ASC
LIMIT 50;

-- Terminiamo la funzione e specifichiamo che il linguaggio utilizzato è SQL.
$body$ language sql;
