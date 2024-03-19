-- Création de la vue pour les tickets à Cergy
CREATE OR REPLACE VIEW cergy_tickets AS
SELECT *
FROM glpi_tickets
WHERE UPPER(location) = 'CERGY';

-- Création de la vue pour les tickets à Pau
CREATE OR REPLACE VIEW pau_tickets AS
SELECT *
FROM glpi_tickets
WHERE UPPER(location) = 'PAU';

GRANT SELECT, INSERT, DELETE, UPDATE on cergy_tickets TO cergy_technician_role;
GRANT SELECT, INSERT, DELETE, UPDATE on pau_tickets TO pau_technician_role;

COMMIT;