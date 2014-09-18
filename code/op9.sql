-- Operazione 9
-- ============
-- Ogni giorno si deve produrre la lista di tutti i lampioni che illuminano
-- attraversamenti pedonali e che hanno necessità di interventi di manutenzione.


-- Questa operazione può essere realizzata con una semplice vista in quanto non
-- è parametrica.
--
-- Anche la query eseguita nella vista è estremamente semplice: si selezionano
-- tutti i lampioni (impianti di tipo 'lampione') che necessitano una
-- manutenzione (impianti dove tipo_intervento_richiesto non è nullo), e si fa
-- il join di nuovo con la relazione `impianto` in modo da ottenere soltanto i
-- lampioni che effettivamente illuminano un attraversamento pedonale. In questo
-- modo si possono ottenere anche informazioni sull'attraversamento pedonale
-- stesso, che vengono incluse nelle colonne risultanti dalla query.

CREATE VIEW lampioni_che_necessitano_manutenzione AS
  SELECT
    lamp.codice AS codice_lampione,
    lamp.lon_lat AS posizione_lampione,
    attrped.codice AS codice_attr_ped_illuminato,
    lamp.tipo_intervento_richiesto,
    lamp.descrizione_intervento_richiesto

  FROM impianto AS lamp
  JOIN impianto AS attrped ON attrped.codice_lampione = lamp.codice
  WHERE lamp.tipo = 'lampione' AND lamp.tipo_intervento_richiesto IS NOT NULL;
