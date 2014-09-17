-- TODO commentare
CREATE OR REPLACE FUNCTION check_impianto_e_qdc(codice CodiceImpianto)
RETURNS BOOLEAN AS $$
BEGIN
  IF EXISTS (SELECT * FROM quadro_di_controllo WHERE codice_impianto = $1) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Trasforma il parametro `miles` (valore in miglia terrestri) nell'equivalente
-- valore in km.
CREATE OR REPLACE FUNCTION miles_to_km(miles float8)
RETURNS float8 AS $body$
BEGIN
  RETURN ($1 * 1.60934);
END;
$body$ LANGUAGE plpgsql;
