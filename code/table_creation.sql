-- Impianto.
CREATE TABLE impianto(
  codice CodiceImpianto PRIMARY KEY,
  tipo TipoImpianto,
  -- Nota: REFERENCES è aggiunto in seguito, quando la relazione
  -- quadro_di_controllo sarà stata creata.
  controllato_da CodiceImpianto,
  codice_lampione CodiceImpianto,
  lon_lat point,
  altezza integer,
  installato boolean,
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
  ind_provincia Provincia,

  -- Se il codice di un lampione viene aggiornato, propaghiamo l'aggiornamento.
  -- Se un lampione viene distrutto, settiamo le foreign key a NULL.
  FOREIGN KEY (codice_lampione)
    REFERENCES impianto(codice)
    ON UPDATE CASCADE ON DELETE SET NULL,

  -- RVF13
  CONSTRAINT cnstr_tipo_e_descrizione CHECK (
    (tipo_intervento_richiesto IS NULL AND descrizione_intervento_richiesto IS NULL)
    OR
    (tipo_intervento_richiesto IS NOT NULL AND descrizione_intervento_richiesto IS NOT NULL)
  ),

  -- RVF6
  CONSTRAINT cnstr_sost_immerso_in_pozzetto CHECK (
    sost_tipo <> 'immerso in pozzetto' OR tipo = 'quadro di controllo'
  ),

  -- RVF4
  CONSTRAINT cnstr_codice_lampione CHECK (
    codice_lampione IS NULL OR tipo = 'attraversamento pedonale'
  ),

  -- RVF9
  CONSTRAINT cnstr_controllato_da CHECK (
    controllato_da IS NOT NULL OR tipo = 'quadro di controllo'
  )
);


-- Sorgenti di illuminazione.
CREATE TABLE sorgente_di_illuminazione(
  id serial PRIMARY KEY,
  da_sostituire boolean,
  tipo_lampada varchar(100),
  stato_di_conservazione varchar(200),
  codice_impianto CodiceImpianto,

  -- Se l'impianto a cui appartengono delle sorgenti di illuminazione viene
  -- distrutto, distruggiamo anche tutte le sorgenti di illuminazione associate.
  FOREIGN KEY (codice_impianto)
    REFERENCES impianto(codice)
    ON UPDATE CASCADE ON DELETE CASCADE
);


-- Quadri di controllo.
--
-- Si noti come l'inserimento di un quadro di controllo va eseguito in una
-- *transaction* SQL. Il motivo di ciò è che un quadro di controllo ha un
-- vincolo di chiave esterna verso un impianto ma l'impianto può essere un
-- quadro di controllo solo se esiste un quadro di controllo nella relazione
-- `quadro_di_controllo`. Per ovviare a questo problema si è utilizzato il
-- costrutto DEFFERRED INITIALLY DEFERRED, che consente di rimandare il check
-- del vincolo a quando la transazione sarà conclusa (con un COMMIT).
--
-- Nello specifico, va inserito *prima* un quadro di controllo e poi l'impianto
-- associato (sempre nella stessa transazione) in quanto PostgreSQL support
-- l'utilizzo di DEFERRABLE solo con vincoli di alcuni tipi, tra i quali
-- REFERENCES. Vincoli imposti tramite chiamate a funzioni esterne (come la
-- funzione già definita `check_impianto_e_qdc` che verrà utilizzata per
-- aggiungere un constraint alle relazioni `sorgente_di_illuminazione` e
-- `impianto`) non sono supportati. Seguendo l'ordine di inserimento descritto,
-- questi vincoli verranno eseguiti alla fine della transazione, quando non ci
-- saranno incongruenze.
CREATE TABLE quadro_di_controllo(
  codice_impianto CodiceImpianto PRIMARY KEY,
  numero_uscite smallint,
  stato_di_funzionamento varchar(200),

  -- Se l'impianto associato a un quadro di controllo viene distrutto, anche il
  -- quadro di controllo sarà distrutto (non può esistere un quadro di controllo
  -- senza un impianto associato).
  FOREIGN KEY (codice_impianto)
    REFERENCES impianto(codice)
    ON UPDATE CASCADE ON DELETE CASCADE
    DEFERRABLE INITIALLY DEFERRED
);


-- RFV3
-- Controlliamo che un impianto abbia il tipo "quadro di controllo" se e solo se
-- è effettivamente un quadro di controllo. Aggiungiamo questo constraint qui in
-- modo da essere sicuri dell'esistenza della relazione `quadro_di_controllo`.
ALTER TABLE impianto ADD CONSTRAINT check_impianto_e_qdc CHECK (
  tipo <> 'quadro di controllo' OR check_impianto_e_qdc(codice)
);


-- RVF8
-- Controlliamo che una sorgente di illuminazione non possa essere associata a
-- un quadro di controllo. Questo check si trova qui in modo da essere sicuri
-- dell'esistenza della relazione `quadro_di_controllo`.
ALTER TABLE sorgente_di_illuminazione ADD CONSTRAINT cnstr_no_qdc CHECK (
  NOT check_impianto_e_qdc(codice_impianto)
);


-- Aggiungiamo la foreign key della relazione `quadro_di_controllo` verso la
-- relazione `impianto`. Lo facciamo qui e non durante la creazione della
-- tabella `impianto` in quanto in quel momento la relazione
-- `quadro_di_controllo` ancora non era stata creata.
--
-- Con l'azione ON DELETE SET NULL specifichiamo che, se si prova a distruggere
-- un quadro di controllo referenziato da almeno un impianto (quadro di
-- controllo che controlla l'impianto), il database blocca l'operazione e non
-- permette la distruzione in quanto un impianto deve essere necessariamente
-- controllato da un quadro di controllo.
ALTER TABLE impianto
  ADD FOREIGN KEY (controllato_da)
  REFERENCES quadro_di_controllo(codice_impianto)
  ON UPDATE CASCADE ON DELETE NO ACTION;


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

  -- Non viene permesso di distruggere un operatore se ci sono missioni che lo
  -- referenziano.
  FOREIGN KEY (matricola_operatore)
    REFERENCES operatore(matricola)
    ON UPDATE CASCADE ON DELETE NO ACTION
);


-- Telefoni.
CREATE TABLE telefono(
  matricola_operatore MatricolaOperatore,
  numero NumeroDiTelefono,

  PRIMARY KEY (matricola_operatore, numero),

  -- Se un operatore viene distrutto, vengono distrutti anche tutti i numeri di
  -- telefono ad esso associati.
  FOREIGN KEY (matricola_operatore)
    REFERENCES operatore(matricola)
    ON UPDATE CASCADE ON DELETE CASCADE
);


-- Interventi.
CREATE TABLE intervento(
  codice_impianto CodiceImpianto,
  matricola_operatore MatricolaOperatore,
  data date,
  tipo TipoIntervento,
  descrizione text,

  PRIMARY KEY (codice_impianto, matricola_operatore, data),

  -- Una missione non può essere distrutta se essa è referenziata da un
  -- intervento.
  FOREIGN KEY (matricola_operatore, data)
    REFERENCES missione(matricola_operatore, data)
    ON UPDATE CASCADE ON DELETE NO ACTION,

  -- Un impianto non può essere distrutto se esso è referenziato da un
  -- intervento.
  FOREIGN KEY (codice_impianto)
    REFERENCES impianto(codice)
    ON UPDATE CASCADE ON DELETE NO ACTION
);


-- Letture.
CREATE TABLE lettura(
  matricola_operatore MatricolaOperatore,
  data date,
  codice_impianto CodiceImpianto,
  kilowatt_ora double precision,

  PRIMARY KEY (matricola_operatore, data, codice_impianto),

  -- Una missione non può essere distrutta se referenziata da una lettura.
  FOREIGN KEY (matricola_operatore, data)
    REFERENCES missione(matricola_operatore, data)
    ON UPDATE CASCADE ON DELETE SET NULL,

  -- Un impianto non può essere distrutto se esso è referenziato da una
  -- lettura.
  FOREIGN KEY (codice_impianto)
    REFERENCES quadro_di_controllo(codice_impianto)
    ON UPDATE CASCADE ON DELETE NO ACTION,

  -- RVF12
  CONSTRAINT cnstr_no_letture_stesso_giorno UNIQUE(data, codice_impianto)
);
