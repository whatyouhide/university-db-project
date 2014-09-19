-- Questa query ci permette di conoscere il numero di sorgenti di illuminazione
-- relative a un dato impianto. Nell'esempio supponiamo di voler conoscere il
-- numero di sorgenti di illuminazione associate all'impianto identificato da
-- 'lamp1'.
\echo Test (query): numero sorgenti di illuminazione
SELECT COUNT(*) AS numero_sorgenti
FROM sorgente_di_illuminazione
WHERE codice_impianto = 'lamp1';

-- Per conoscere soltanto il numero di sorgenti di illuminazione con lampade da
-- sostituire, la query si trasforma leggermente.
\echo Test (query): numero sorgenti di illuminazione da sostituire
SELECT COUNT(*) AS numero_sorgenti_con_lampade_da_sostituire
FROM sorgente_di_illuminazione
WHERE codice_impianto = 'lamp1' AND da_sostituire = true;



-- Con questa view "creiamo" il concetto di centralina semaforica, accennato
-- nelle specifiche e poi ridefinito più formalmente come "quadro di controllo"
-- che controlla solo semafori. Mettendo a disposizione questa vista si rende di
-- facile accesso l'insieme delle centraline semaforiche.
CREATE VIEW centralina_semaforica AS
  SELECT quadro_di_controllo.*
  FROM quadro_di_controllo
  WHERE NOT EXISTS (
    SELECT * FROM impianto
    WHERE controllato_da = quadro_di_controllo.codice_impianto
    AND tipo <> 'semaforo'
  );

\echo Test (view): centralina_semaforica
SELECT * FROM centralina_semaforica;
