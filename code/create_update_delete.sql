-- Impianti.

-- Inserimento.

-- TODO commentare questa cosa che bisogna inserire prima il quadro di controllo
-- e poi l'impianto associato (deferred + check function che non può essere
-- deferred), percio la transaction.
BEGIN TRANSACTION;
INSERT INTO quadro_di_controllo VALUES ('qdc1', 10, 'ottimo');
INSERT INTO impianto VALUES (
  'qdc1', 'quadro di controllo', NULL, NULL, -- codice, tipo, controllato_da, lampione
  '(33.132523, 11.142633)', 485, -- lon_lat, altezza
  NULL, NULL, -- intervento
  'immerso in pozzetto', 'ottimo', -- sostegno
  'linea trifase', 'buono', false, -- linea el. di alimentazione
  'corso vittorio emanuele', '1110', 'Milano', 'MI' --indirizzo
);
COMMIT;

INSERT INTO impianto VALUES (
  'lamp1', 'lampione', 'qdc1', NULL, -- codice, tipo, quadro, lampione
  '(43.211234, 12.421341)', 100, -- lon_lat, altezza
  'Si è danneggiato il sostegno a causa del maltempo', 'manutenzione', -- intervento
  'palo a terra', 'danneggiato', -- sostegno
  'linea bifase', 'buono', false, -- linea el. di alimentazione
  'via carducci', '33bis', 'L''aquila', 'AQ' -- indirizzo
);

INSERT INTO sorgente_di_illuminazione(
  da_sostituire, tipo_lampada, stato_di_conservazione, codice_impianto
) VALUES (false, 'alogena', 'buono', 'lamp1');

INSERT INTO impianto VALUES (
  'attrped1', 'attraversamento pedonale', 'qdc1', 'lamp1', -- codice, tipo, controllato_da, lamp.
  '(43.211238, 12.421228)', 0, -- lon_lat, altezza
  NULL, NULL, -- intervento
  'staffa a muro', 'ottimo', -- sostegno
  'pannello solare', 'buono', false, -- linea el. di alimentazione
  'via rossi', '1', 'Miglianico', 'CH' -- indirizzo
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
