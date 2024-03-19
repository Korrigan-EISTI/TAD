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

COMMIT;