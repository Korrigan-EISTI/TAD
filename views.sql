CREATE VIEW IF NOT EXISTS cergy_tickets AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'CERGY';
CREATE VIEW IF NOT EXISTS pau_tickets AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'PAU';

COMMIT;