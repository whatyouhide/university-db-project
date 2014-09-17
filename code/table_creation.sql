-- Impianto.
CREATE TABLE impianto(
  codice CodiceImpianto PRIMARY KEY,
  tipo TipoImpianto,
  -- Nota: REFERENCES è aggiunto in seguito, quando la relazione
  -- quadro_di_controllo sarà stata creata.
  controllato_da CodiceImpianto,
  codice_lampione CodiceImpianto REFERENCES impianto(codice),
  lon_lat point,
  altezza integer,
  descrizione_intervento_richiesto text,
  tipo_intervento_richiesto varchar(200),
  sost_tipo TipoSostegno,
  sost_stato_di_conservazione varchar(200),
  alim_tipo_alimentazione TipoLineaElettricaDiAlimentazione,
  alim_stato_di_conservazione varchar(200),
  alim_in_pozzetto_di_derivazione boolean,
  ind_via varchar(200),
  ind_numero_civico_di_riferimento varchar(10),
  ind_comune varchar(100),
  ind_provincia Provincia
);

-- Sorgenti di illuminazione.
CREATE TABLE sorgente_di_illuminazione(
  id serial PRIMARY KEY,
  da_sostituire boolean,
  tipo_lampada varchar(100),
  stato_di_conservazione varchar(200),
  codice_impianto CodiceImpianto REFERENCES impianto(codice)
);

-- Quadri di controllo.
CREATE TABLE quadro_di_controllo(
  codice_impianto CodiceImpianto PRIMARY KEY,
  numero_uscite integer,
  stato_di_funzionamento varchar(200),

  FOREIGN KEY (codice_impianto)
  REFERENCES impianto(codice) DEFERRABLE INITIALLY DEFERRED
);

-- RVF8
-- TODO commentare
ALTER TABLE sorgente_di_illuminazione
ADD CONSTRAINT cnstr_no_qdc CHECK (NOT check_impianto_e_qdc(codice_impianto));

-- Aggiungiamo la foreign key della relazione quadro_di_controllo verso la
-- relazione `impianto`. Lo facciamo qui e non durante la creazione della
-- tabella `impianto` in quanto in quel momento la relazione
-- `quadro_di_controllo` ancora non era stata creata.
ALTER TABLE impianto
  ADD FOREIGN KEY (controllato_da) REFERENCES quadro_di_controllo(codice_impianto);

-- RFV3
-- TODO commentare
ALTER TABLE impianto ADD CONSTRAINT check_impianto_e_qdc CHECK (
  tipo <> 'quadro di controllo' OR check_impianto_e_qdc(codice)
);

-- RVF6
-- TODO commentare
ALTER TABLE impianto ADD CONSTRAINT check_sost_tipo CHECK (
  sost_tipo <> 'immerso in pozzetto' OR tipo = 'quadro di controllo'
);

-- RVF4
-- TODO commentare
ALTER TABLE impianto ADD CONSTRAINT codice_lampione_chk CHECK (
  codice_lampione IS NULL OR tipo = 'attraversamento pedonale'
);

-- RVF9
-- TODO commentare
ALTER TABLE impianto ADD CONSTRAINT check_controllato_da CHECK (
  controllato_da IS NOT NULL OR tipo = 'quadro di controllo'
);

-- Operatori.
CREATE TABLE operatore(
  matricola MatricolaOperatore PRIMARY KEY,
  nome varchar(100),
  cognome varchar(100),
  email varchar(100),
  ind_via varchar(100),
  ind_numero_civico varchar(10),
  ind_comune varchar(100),
  ind_cap varchar(5)
);


-- Missioni.
CREATE TABLE missione(
  matricola_operatore MatricolaOperatore,
  data date,

  PRIMARY KEY (matricola_operatore, data),

  FOREIGN KEY (matricola_operatore)
  REFERENCES operatore(matricola) ON DELETE SET NULL
);


-- Telefoni.
CREATE TABLE telefono(
  matricola_operatore MatricolaOperatore,
  numero NumeroDiTelefono,

  PRIMARY KEY (matricola_operatore, numero),

  FOREIGN KEY (matricola_operatore)
  REFERENCES operatore(matricola) ON DELETE CASCADE
);


-- Interventi.
CREATE TABLE intervento(
  codice_impianto CodiceImpianto,
  matricola_operatore MatricolaOperatore,
  data date,
  tipo TipoIntervento,
  descrizione text,

  PRIMARY KEY (codice_impianto, matricola_operatore, data),

  FOREIGN KEY (matricola_operatore, data)
  REFERENCES missione(matricola_operatore, data) ON DELETE RESTRICT,

  FOREIGN KEY (codice_impianto)
  REFERENCES impianto(codice) ON DELETE SET NULL
);


-- Letture.
CREATE TABLE lettura(
  matricola_operatore MatricolaOperatore,
  data date,
  codice_impianto CodiceImpianto,
  kilowatt_ora double precision,
  PRIMARY KEY (matricola_operatore, data, codice_impianto),

  FOREIGN KEY (matricola_operatore, data)
  REFERENCES missione(matricola_operatore, data),

  FOREIGN KEY (codice_impianto)
  REFERENCES impianto(codice)
);
