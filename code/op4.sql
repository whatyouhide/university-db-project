-- Operazione 4
-- ============
-- Per ogni quadro di controllo che dovrà essere censito in una data missione,
-- si dovrà produrre la lista di tutti gli impianti a esso connessi.

-- Per questa operazione creiamo la funzione impianti_per_qdc_in_missione(), che
-- prende in input la coppia (matricola_operatore, data) che identifica una data
-- missione e seleziona gli impianti secondo i criteri descritti
-- nell'operazione.
--
-- Esempio di utilizzo: supponiamo di voler selezionare gli impianti controllati
-- da quadri di controllo censiti nella missione identificata dalla coppia
-- ('94', '2014-02-02'). La query che andremo a eseguire sarà:
--
--     SELECT * FROM impianti_per_qdc_in_missione('94', '2014-02-02');

CREATE OR REPLACE FUNCTION
impianti_per_qdc_in_missione(matr MatricolaOperatore, data date)
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
  ind_provincia Provincia
) as $body$;

-- Volendo effettuare una query che rispecchia fedelmente le istruzioni indicate
-- nel testo dell'operazione 4, dovremmo iniziare la query dalla relazione
-- `missione` in quanto la funzione prende in input la chiave primaria della
-- relazione `missione` e prosegue trovando interventi in quella missione,
-- quali di questi interventi sono su quadri di controllo e infine quali
-- impianto sono controllati da questi quadri di controllo.
--
-- Possiamo tuttavia "saltare un passaggio" selezionando direttamente gli
-- interventi al posto della missione, utilizzando proprio la chiave primaria
-- della missione ricevuta in input.
SELECT impianto.*
FROM intervento
JOIN quadro_di_controllo ON
  intervento.codice_impianto = quadro_di_controllo.codice_impianto
JOIN impianto ON
  impianto.controllato_da = quadro_di_controllo.codice_impianto
WHERE
  intervento.matricola_operatore = $1
  AND intervento.data = $2
  AND intervento.tipo = 'censimento';

$body$ language sql;
