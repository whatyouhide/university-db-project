-- Operazione 7
-- ============
-- Mensilmente si vuole calcolare il consumo registrato da ogni quadro di
-- controllo (risultante dalla differenza tra la lettura più recente e quella
-- che la precede).


-- TODO rivedere se va tutto bene
CREATE OR REPLACE FUNCTION data_lettura_piu_recente_rispetto_a_data(c CodiceImpianto, d date)
RETURNS date AS $body$
BEGIN
  return (
    SELECT data
    FROM lettura
    WHERE codice_impianto = $1 AND data < $2
    ORDER BY data
    DESC LIMIT 1
  );
END;
$body$ language plpgsql;


-- Creiamo la vista `consumi`, che contiene il consumo registrato da ogni quadro
-- di controllo, come descritto dalla specifica dell'operazione.
--
-- In questa vista eseguiamo il join con la relazione `lettura` due volte in
-- quanto abbiamo bisogno di due letture per quadro (e per riga dunque);
-- sfruttiamo la funzione appena creata per ottenere la data della lettura più
-- recente per ogni quadro di controllo e utilizzare questa informazione nelle
-- condizioni di join.
-- La differenza delle letture (cioè il consumo) viene calcolato nella parte
-- della SELECT.
CREATE VIEW consumi AS SELECT DISTINCT qdc.codice_impianto,
    lett_piu_recente.kilowatt_ora - lett_precedente.kilowatt_ora AS consumo,
    lett_piu_recente.data AS data_lettura_piu_recente, lett_precedente.data AS
    data_lettura_precedente

  FROM quadro_di_controllo AS qdc

  JOIN lettura AS lett_piu_recente ON
    lett_piu_recente.codice_impianto = qdc.codice_impianto
    AND lett_piu_recente.data =
      data_lettura_piu_recente_rispetto_a_data(qdc.codice_impianto, CURRENT_DATE)

  JOIN lettura AS lett_precedente ON
    lett_precedente.codice_impianto = qdc.codice_impianto
    AND lett_precedente.data =
      data_lettura_piu_recente_rispetto_a_data(qdc.codice_impianto, lett_piu_recente.data)
;
