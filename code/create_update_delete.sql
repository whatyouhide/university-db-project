-- Impianti.

-- Inserimento.
INSERT INTO impianto VALUES (
  -- codice, tipo
  'qdc1', 'quadro di controllo',
  -- controllato da
  NULL,
  -- codice lampione
  NULL,
  -- lon_lat, altezza
  point '(33.132523, 11.142633)', 485,
  -- intervento
  NULL, NULL,
  -- sostegno
  'immerso in pozzetto', 'ottimo',
  -- linea elettrica di alimentazione
  'linea trifase', 'buono', false,
  -- indirizzo
  'corso vittorio emanuele', '1110', 'Milano', 'MI'
);
INSERT INTO quadro_di_controllo VALUES ('qdc1', 10, 'ottimo');

INSERT INTO impianto VALUES (
  -- codice, tipo
  'lamp1', 'lampione',
  -- quadro di controllo, lampione
  'qdc1', NULL,
  -- lon_lat, altezza
  point '(43.211234, 12.421341)', 100,
  -- intervento
  'Si è danneggiato il sostegno a causa del maltempo', 'manutenzione',
  -- sostegno
  'palo a terra', 'danneggiato',
  -- linea elettrica di alimentazione
  'linea bifase', 'buono', false,
  -- indirizzo
  'via carducci', '33bis', 'L''aquila', 'AQ'
);

INSERT INTO sorgente_di_illuminazione(
  da_sostituire, tipo_lampada, stato_di_conservazione, codice_impianto
) VALUES (false, 'alogena', 'buono', 'lamp1');

INSERT INTO impianto VALUES (
  -- codice, tipo
  'attrped1', 'attraversamento pedonale',
  -- controllato da
  'qdc1',
  -- codice lampione
  'lamp1',
  -- lon_lat, altezza
  point '(43.211238, 12.421228)', 0,
  -- intervento
  NULL, NULL,
  -- sostegno
  'staffa a muro', 'ottimo',
  -- linea di alimentazione
  'pannello solare', 'buono', false,
  -- indirizzo
  'via rossi', '1', 'Miglianico', 'CH'
);

UPDATE impianto
SET alim_in_pozzetto_di_derivazione = true
WHERE codice = 'attrped1';



-- Creiamo degli operatori con relativi numeri di telefono.
INSERT INTO operatore(
  matricola, nome, cognome, email,
  ind_via, ind_numero_civico, ind_comune, ind_cap
) VALUES
  ('12', 'Gino', 'Rosi', 'gino@ro.si', 'via bui', '4', 'Sassa', '67100'),
  ('94', 'Anna', 'Ari', 'annari@a.b', 'via vecchia', '1', 'Terni', '53411');

INSERT INTO telefono(matricola_operatore, numero) VALUES
  ('12', '3331234567'), ('12', '3289874538'), ('94', '3639383739');


-- Associamo delle missioni agli operatori creati.
INSERT INTO missione(matricola_operatore, data) VALUES
  ('12', '2014-11-01'), ('12', '2014-09-26'), ('94', '2014-12-25'),
  ('94', '2014-09-26'), ('94', '2014-02-02');
-- Correggiamo la data alla missione del 2014-12-25
UPDATE missione
SET data = '2014-12-15'
WHERE matricola_operatore = '94' AND data = '2014-12-25';
-- Cancelliamo la missione del 2014-11-01.
DELETE FROM missione WHERE matricola_operatore = '12' AND data = '2014-11-01';


-- Creiamo degli interventi associati alle missioni create.
INSERT INTO
  intervento(codice_impianto, matricola_operatore, data, tipo, descrizione)
VALUES
  ('attrped1', '94', '2014-12-15', 'censimento', NULL),
  ('qdc1', '94', '2014-02-02', 'censimento', 'Censimento e lettura quadro'),
  ('lamp1', '94', '2014-09-26', 'manutenzione', 'Riparato danno al sostegno');


-- Creiamo delle letture.
INSERT INTO lettura(matricola_operatore, data, codice_impianto, kilowatt_ora)
VALUES ('94', '2014-02-02', 'qdc1', 33.0232312);
