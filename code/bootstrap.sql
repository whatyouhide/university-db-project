-- Distruzione del database (se esiste) in modo da partire con una lavagna
-- bianca.
DROP DATABASE IF EXISTS illuminazione_pubblica;

-- Creazione del database.
CREATE DATABASE illuminazione_pubblica;

-- Connessione al database (sintassi specifica di PostgreSQL).
\c illuminazione_pubblica
