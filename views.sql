-- Création de la vue pour les tickets à Cergy
CREATE OR REPLACE VIEW cergy_tickets AS
SELECT *
FROM glpi_tickets
WHERE UPPER(location) = 'CERGY';  -- Sélectionne tous les tickets situés à Cergy

-- Création de la vue pour les tickets à Pau
CREATE OR REPLACE VIEW pau_tickets AS
SELECT *
FROM glpi_tickets
WHERE UPPER(location) = 'PAU';  -- Sélectionne tous les tickets situés à Pau

-- Accorder des autorisations aux rôles de technicien pour accéder aux vues
GRANT SELECT, INSERT, DELETE, UPDATE ON cergy_tickets TO cergy_technician_role;  -- Accorde les autorisations aux techniciens à Cergy
GRANT SELECT, INSERT, DELETE, UPDATE ON pau_tickets TO pau_technician_role;  -- Accorde les autorisations aux techniciens à Pau

COMMIT;