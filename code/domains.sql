-- Creazione di domini custom in modo da facilitare la definizione delle colonne
-- e da poter riutilizzare codice.

-- Il codice di un impianto.
CREATE DOMAIN CodiceImpianto varchar(20);

-- La matricola di un operatore.
CREATE DOMAIN MatricolaOperatore varchar(20);

-- Numero di telefono.
CREATE DOMAIN NumeroDiTelefono varchar(10);

-- RVF1, RVF2
CREATE DOMAIN TipoImpianto varchar(24) NOT NULL CHECK (VALUE IN
  ('semaforo', 'segnale stradale', 'lampione',
  'attraversamento pedonale', 'quadro di controllo')
);

-- RVF10
CREATE DOMAIN TipoIntervento varchar(16) CHECK (VALUE IN
  ('censimento', 'installazione', 'manutenzione', 'ispezione')
);

-- RVF5
CREATE DOMAIN TipoSostegno varchar(19) CHECK (VALUE IN
  ('sostegno aereo', 'staffa a muro', 'palo a terra', 'immerso in pozzetto')
);

-- RVF7
CREATE DOMAIN TipoLineaElettricaDiAlimentazione varchar(15) CHECK (VALUE IN
  ('pannello solare', 'linea bifase', 'linea trifase')
);

-- RVF11
CREATE DOMAIN Provincia varchar(2) CHECK (VALUE IN (
    'AG', 'AL', 'AN', 'AO', 'AQ', 'AR', 'AP', 'AT', 'AV', 'BA', 'BT', 'BL',
    'BN', 'BG', 'BI', 'BO', 'BZ', 'BS', 'BR', 'CA', 'CL', 'CB', 'CI', 'CE',
    'CT', 'CZ', 'CH', 'CO', 'CS', 'CR', 'KR', 'CN', 'EN', 'FM', 'FE', 'FI',
    'FG', 'FC', 'FR', 'GE', 'GO', 'GR', 'IM', 'IS', 'SP', 'LT', 'LE', 'LC',
    'LI', 'LO', 'LU', 'MC', 'MN', 'MS', 'MT', 'VS', 'ME', 'MI', 'MO', 'MB',
    'NA', 'NO', 'NU', 'OG', 'OT', 'OR', 'PD', 'PA', 'PR', 'PV', 'PG', 'PU',
    'PE', 'PC', 'PI', 'PT', 'PN', 'PZ', 'PO', 'RG', 'RA', 'RC', 'RE', 'RI',
    'RM', 'RN', 'RO', 'SA', 'SS', 'SV', 'SI', 'SR', 'SO', 'TA', 'TE', 'TR',
    'TO', 'TP', 'TN', 'TV', 'TS', 'UD', 'VA', 'VE', 'VB', 'VC', 'VR', 'VV',
    'VI', 'VT'
));
