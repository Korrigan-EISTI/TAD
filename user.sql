-- Création des rôles de base
CREATE ROLE admin_role;
CREATE ROLE technician_role;
CREATE ROLE simple_user_role;

-- Création des rôles supplémentaires pour les techniciens à Pau et à Cergy
CREATE ROLE pau_technician_role;
CREATE ROLE cergy_technician_role;

GRANT SELECT, INSERT, DELETE, UPDATE TO cergy_technician_role on cergy_tickets;
GRANT SELECT, INSERT, DELETE, UPDATE TO pau_technician_role on pau_tickets;

COMMIT;
