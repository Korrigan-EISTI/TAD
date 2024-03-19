CREATE ROLE admin_role;
CREATE ROLE technician_role;
CREATE ROLE end_user_role;

CREATE USER admin_user IDENTIFIED BY password;
CREATE USER technician_user IDENTIFIED BY password;
CREATE USER end_user IDENTIFIED BY password;

GRANT admin_role TO admin_user;
GRANT technician_role TO technician_user;
GRANT end_user_role TO end_user;

GRANT ALL PRIVILEGES TO admin_role;
-- Pour le rôle de technicien
GRANT SELECT, INSERT, UPDATE ON tickets_table TO technician_role;

-- Pour le rôle d'utilisateur final
GRANT SELECT, INSERT ON tickets_table TO end_user_role;

COMMIT;