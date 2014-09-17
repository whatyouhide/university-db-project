-- Questa funzione esegue un check per verificare che l'impianto identificato
-- dal `codice` in input sia un quadro di controllo. Questa verifica viene
-- effettuata controllando che esista una riga nella relazione
-- `quadro_di_controllo` identificata da `codice`.
CREATE OR REPLACE FUNCTION check_impianto_e_qdc(codice CodiceImpianto)
RETURNS BOOLEAN AS $body$
BEGIN
  IF EXISTS (SELECT * FROM quadro_di_controllo WHERE codice_impianto = $1) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
END;
$body$ LANGUAGE plpgsql;

-- Trasforma il parametro `miles` (valore in miglia terrestri) nell'equivalente
-- valore in km.
-- Questa funzione è stata creata in quanto l'estensione `earthdistance` di
-- PostgreSQL (in particolare l'operatore di distanza che mette a disposizione,
-- ovvero `<@>`) ritorna un valore in miglia terrestri.
CREATE OR REPLACE FUNCTION miles_to_km(miles float8)
RETURNS float8 AS $body$
BEGIN
  RETURN ($1 * 1.60934);
END;
$body$ LANGUAGE plpgsql;
