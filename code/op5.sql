-- Operazione 5
-- ============
-- All'approssimarsi della scadenza mensile (fine del mese), si deve produrre la
-- lista di tutti i quadri di controllo per i quali è ancora necessario
-- effettuare la lettura del consumo, ovvero per i quali non è ancora
-- disponibile una lettura effettuata nel mese in corso.

-- Per effettuare questa operazione ci serviamo di una semplice vista, in quanto
-- l'operazione non è parametrica. In questa vista selezioniamo i codici dei
-- quadri di controllo per i quali è ancora necessario effettuare la lettura e
-- la data dell'ultima lettura effettuata.
-- La clausola GROUP BY ci permette di ottenere una riga per quadro e ci
-- permette di ottenere facilmente la data dell'ultima lettura.
--
-- Esempio di utilizzo:
--
--     SELECT * FROM quadri_che_necessitano_lettura;

CREATE VIEW quadri_che_necessitano_lettura AS
  SELECT
    quadro_di_controllo.codice_impianto AS quadro,
    max(lettura.data) AS ultima_lettura

  FROM lettura

  JOIN quadro_di_controllo
    ON lettura.codice_impianto = quadro_di_controllo.codice_impianto

  WHERE date_trunc('month', lettura.data) < date_trunc('month', CURRENT_DATE)

  GROUP BY quadro_di_controllo.codice_impianto;
