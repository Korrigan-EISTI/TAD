-- Création des rôles
CREATE ROLE admin_role;
CREATE ROLE technician_role;
CREATE ROLE end_user_role;

-- Création des utilisateurs avec des mots de passe sécurisés
CREATE USER admin_user IDENTIFIED BY admin_password;
CREATE USER technician_user IDENTIFIED BY technician_password;
CREATE USER end_user IDENTIFIED BY end_user_password;

-- Attribution des rôles aux utilisateurs
GRANT admin_role TO admin_user;
GRANT technician_role TO technician_user;
GRANT end_user_role TO end_user;

-- Attribution des privilèges aux rôles
-- Pour le rôle admin
GRANT ALL PRIVILEGES TO admin_role;

-- Pour le rôle technicien
GRANT SELECT, INSERT, UPDATE ON tickets_table TO technician_role;

-- Pour le rôle d'utilisateur final
GRANT SELECT, INSERT ON tickets_table TO end_user_role;

COMMIT;