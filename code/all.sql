-- Impostiamo tre impostazioni della console di PostgreSQL: la prima impedisce
-- l'utilizzo di un "pager" (come `less`) in modo da non dover interrompere
-- l'esecuzione di script che stampano risultati, mentre la seconda impone alla
-- console del db di interrompere l'esecuzione degli script al primo errore
-- incontrato (utile per il testing, dove eseguiamo questo script e possiamo
-- esaminare eventuali errori uno alla volta). La terza impostazione è per non
-- riportare il tempo impiegato dalle query dopo la loro esecuzione.
\set ON_ERROR_STOP on
\pset pager off
\timing off

-- Eseguiamo tutti gli altri script.
\ir bootstrap.sql
\ir domains.sql
\ir functions.sql
\ir table_creation.sql
\ir create_update_delete.sql
\ir op3.sql
\ir op4.sql
\ir op5.sql
\ir op6.sql
\ir op7.sql
\ir op8.sql
\ir op9.sql
