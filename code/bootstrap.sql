-- Impostiamo alcune opzioni di PostgreSQL.

-- Impadiamo l'utilizzo di un "pager" (come `less`) in modo da non dover
-- interrompere l'esecuzione di script che stampano risultati.
\pset pager off

-- Imponiamo alla console del db di interrompere l'esecuzione degli script al
-- primo errore incontrato (utile per il testing, dove eseguiamo questo script e
-- possiamo esaminare eventuali errori uno alla volta).
\set ON_ERROR_STOP on

-- Non riportiamo il tempo impiegato dalle query dopo la loro esecuzione.
\timing off

-- Non riportiamo il numero di righe nei risultati delle query.
\pset footer off


-- Distruzione del database (se esiste) in modo da partire con una "tavola
-- bianca".
DROP DATABASE IF EXISTS illuminazione_pubblica;

-- Creazione del database.
CREATE DATABASE illuminazione_pubblica;

-- Connessione al database (sintassi specifica di PostgreSQL).
\c illuminazione_pubblica

-- Attivazione di alcune estensioni necessarie ad utilizzare le funzioni
-- geografiche di PostgreSQL.
CREATE EXTENSION cube;
CREATE EXTENSION earthdistance;
