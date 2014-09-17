-- TODO commentare
CREATE FUNCTION check_impianto_e_qdc(codice CodiceImpianto)
RETURNS BOOLEAN AS $$
BEGIN
  IF EXISTS (SELECT * FROM quadro_di_controllo WHERE codice_impianto = $1) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
END;
$$ LANGUAGE plpgsql;
