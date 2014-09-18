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


-- Trova la distanza in km tra i due punti passati in input. Questa funzione è
-- stata create in quanto l'operatore "distanza" (`<@>`) messo a disposizione
-- dall'etensione `earthdistance` di PostgreSQL ritorna un valore in miglia
-- terrestri.
CREATE OR REPLACE FUNCTION distance_in_km(p1 point, p2 point)
RETURNS float8 AS $body$
BEGIN
  RETURN (1.60934 * (p1 <@> p2));
END;
$body$ LANGUAGE plpgsql;
