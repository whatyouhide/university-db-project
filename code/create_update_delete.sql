-- Impianti
-- ========


-- Inseriamo un paio di quadri di controllo.
BEGIN TRANSACTION;
INSERT INTO quadro_di_controllo VALUES ('qdc1', 10, 'ottimo');
INSERT INTO impianto VALUES (
  'qdc1', 'quadro di controllo', -- codice, tipo
  NULL, NULL, -- controllato_da, lampione
  '(33.132523, 11.142633)', 130, true, -- lon_lat, altezza, installato
  NULL, NULL, -- intervento
  'immerso in pozzetto', 'ottimo', 'cemento', -- sostegno
  'linea trifase', 'buono', false, -- linea el. di alimentazione
  'Corso Vittorio Emanuele', '1110', 'Milano', 'MI' --indirizzo
);
COMMIT;

BEGIN TRANSACTION;
INSERT INTO quadro_di_controllo VALUES ('qdc2', 3, 'buono');
INSERT INTO impianto VALUES (
  'qdc2', 'quadro di controllo', -- codice, tipo
  NULL, NULL, -- controllato_da, lampione
  '(39.136523, 19.142443)', -102, true, -- lon_lat, altezza, installato
  'Si sono danneggiati degli interruttori', 'sostituzione pezzi', -- intervento
  'palo a terra', 'ottimo', 'cemento', -- sostegno
  'linea trifase', 'buono', false, -- linea el. di alimentazione
  'Piazza di Spagna', '843a', 'Roma', 'RM' --indirizzo
);
COMMIT;


-- Creiamo due lampioni.
INSERT INTO impianto VALUES (
  'lamp1', 'lampione', -- codice, tipo
  'qdc2', NULL, -- quadro, lampione
  '(43.211234, 12.421341)', 300, true, -- lon_lat, altezza, installato
  'Danneggiato il sostegno a causa del maltempo', 'manutenzione', -- intervento
  'palo a terra', 'danneggiato', 'ferro', -- sostegno
  'linea bifase', 'buono', false, -- linea el. di alimentazione
  'Via Carducci', '33bis', 'L''Aquila', 'AQ' -- indirizzo
);
INSERT INTO impianto VALUES (
  'lamp2', 'lampione', -- codice, tipo
  'qdc1', NULL, -- quadro, lampione
  '(24.584934, 17.784951)', 320, true, -- lon_lat, altezza, installato
  NULL, NULL, -- intervento
  'palo a terra', 'eccellente', 'ferro', -- sostegno
  'linea bifase', 'buono', false, -- linea el. di alimentazione
  'Via XX Settembre', '3', 'L''Aquila', 'AQ' -- indirizzo
);

-- Associamo sorgenti di illuminazione ai lampioni creati.
INSERT INTO sorgente_di_illuminazione(
  da_sostituire, tipo_lampada, stato_di_conservazione, codice_impianto
) VALUES
  (false, 'alogena', 'buono', 'lamp1'),
  (false, 'alogena', 'buono', 'lamp1'),
  (false, 'neon', 'ottimo', 'lamp2');


-- Creiamo un attraversamento pedonale illuminato da un lampione.
INSERT INTO impianto VALUES (
  'attrped1', 'attraversamento pedonale', -- codice, tipo
  'qdc1', 'lamp1', -- controllato_da, lampione
  '(43.211238, 12.421228)', 0, true, -- lon_lat, altezza, installato
  NULL, NULL, -- intervento
  'staffa a muro', 'ottimo', 'plastica', -- sostegno
  'pannello solare', 'buono', false, -- linea el. di alimentazione
  'Via Rossi', '1', 'Miglianico', 'CH' -- indirizzo
);
-- Aggiorniamo l'attraversamento pedonale appena creato cambiando il valore
-- dell'attributo `alim_in_pozzetto_di_derivazione` da false a true.
UPDATE impianto
SET alim_in_pozzetto_di_derivazione = true
WHERE codice = 'attrped1';


-- Creiamo un segnale stradale ancora non installato.
INSERT INTO impianto VALUES (
  'ss1', 'segnale stradale', -- codice, tipo
  'qdc1', NULL, -- controllato_da, lampione
  '(53.46383, 22.38483)', 230, false, -- lon_lat, altezza, installato
  NULL, NULL, -- intervento
  'staffa a muro', NULL, 'acciaio inossidabile', -- sostegno
  'linea trifase', NULL, false, -- linea el. di alimentazione
  'Via Cagliari', '341', 'Palermo', 'PA' -- indirizzo
);



-- Creiamo degli operatori con relativi numeri di telefono.
INSERT INTO operatore(
  matricola, nome, cognome, email,
  ind_via, ind_numero_civico, ind_comune, ind_cap
) VALUES
  ('12', 'Gino', 'Rosi', 'gino@ro.si', 'via bui', '4', 'Sassa', '67100'),
  ('77', 'Marco', 'Fè', 'marco@fe.it', 'Via Arti', '18', 'Roma', '38201'),
  ('94', 'Anna', 'Ari', 'annari@a.b', 'via vecchia', '1', 'Terni', '53411');

INSERT INTO telefono(matricola_operatore, numero) VALUES
  ('12', '3331234567'),
  ('12', '3289874538'),
  ('77', '3362847493'),
  ('94', '3639383739');


-- Associamo delle missioni agli operatori creati.
INSERT INTO missione(matricola_operatore, data) VALUES
  ('12', '2014-09-26'), ('94', '2014-09-26'), ('94', '2014-02-02'),
  ('12', '2014-02-02'), ('12', '2014-09-10'), ('12', '2014-06-22'),
  ('12', '2014-07-31'), ('12', '2014-11-01'), ('94', '2014-02-25'),
  ('77', '2014-12-01');

-- Un esempio di come correggeremmo la data della missione di Anna Ari del
-- 2014-02-25 al giorno 2014-03-25.
--
--   UPDATE missione
--   SET data = '2014-02-25'
--   WHERE matricola_operatore = '94' AND data = '2014-12-25';

-- Un esempio di come cancelleremmo la missione di Gino Rosi del 2014-11-1.
--
--   DELETE FROM missione
--   WHERE matricola_operatore = '12' AND data = '2014-11-01';


-- Creiamo degli interventi associati alle missioni create.
INSERT INTO
  intervento(codice_impianto, matricola_operatore, data, tipo, descrizione)
VALUES
  ('attrped1', '94', '2014-02-25', 'censimento', NULL),
  ('attrped1', '12', '2014-09-10', 'ispezione', NULL),
  ('qdc1', '94', '2014-02-02', 'censimento', 'Censimento e lettura quadro'),
  ('lamp2', '77', '2014-12-01', 'ispezione', NULL),
  ('ss1', '77', '2014-12-01', 'installazione', NULL),
  ('lamp1', '94', '2014-09-26', 'manutenzione', 'Riparato danno al sostegno');


-- Creiamo delle letture.
INSERT INTO lettura(matricola_operatore, data, codice_impianto, kilowatt_ora)
VALUES
  ('94', '2014-02-02', 'qdc1', 33.0232312),
  ('12', '2014-06-22', 'qdc1', 44.3222441),
  ('94', '2014-02-25', 'qdc1', 41.0002329),
  ('94', '2014-02-02', 'qdc2', 26.2472345),
  ('12', '2014-07-31', 'qdc2', 51.5382743);
