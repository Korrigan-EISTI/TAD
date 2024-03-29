-- Activer le mode script Oracle pour permettre la création d'objets de base de données
alter session set "_ORACLE_SCRIPT"=true;

-- Créer un espace de table pour les données d'administration
CREATE TABLESPACE cergyAdmin
    DATAFILE 'cergy.dbf' SIZE 1024M
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

-- Créer un espace de table pour les données d'administration
CREATE TABLESPACE pauAdmin
    DATAFILE 'pau.dbf' SIZE 1024M
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

-- Créer des rôles dans la base de données
CREATE ROLE technician_role;
CREATE ROLE simple_user_role;

GRANT CONNECT TO technician_role WITH ADMIN OPTION;
GRANT simple_user_role TO technician_role WITH ADMIN OPTION;
GRANT EXECUTE TO technician_role;

GRANT EXECUTE TO simple_user_role;

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin IDENTIFIED BY glpiAdmin;

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin;
GRANT CREATE USER TO glpiAdmin;
GRANT CREATE SESSION TO glpiAdmin;
GRANT CONNECT TO glpiAdmin WITH ADMIN OPTION;
GRANT technician_role TO glpiAdmin WITH ADMIN OPTION;
GRANT simple_user_role TO glpiAdmin WITH ADMIN OPTION;
GRANT INSERT, DELETE, SELECT, UPDATE, CREATE VIEW TO glpiAdmin WITH ADMIN OPTION;
GRANT EXECUTE TO glpiAdmin WITH ADMIN OPTION;

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin_cergy IDENTIFIED BY cergy DEFAULT TABLESPACE cergyAdmin;

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin_cergy;
GRANT CREATE USER TO glpiAdmin_cergy;
GRANT CREATE SESSION TO glpiAdmin_cergy;
GRANT CONNECT TO glpiAdmin_cergy WITH ADMIN OPTION;
GRANT technician_role TO glpiAdmin_cergy WITH ADMIN OPTION;
GRANT simple_user_role TO glpiAdmin_cergy WITH ADMIN OPTION;
GRANT INSERT, DELETE, SELECT, UPDATE, CREATE VIEW TO glpiAdmin_cergy WITH ADMIN OPTION;
GRANT EXECUTE TO glpiAdmin_cergy WITH ADMIN OPTION;

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin_pau IDENTIFIED BY pau DEFAULT TABLESPACE pauAdmin;

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin_pau;
GRANT CREATE USER TO glpiAdmin_pau;
GRANT CREATE SESSION TO glpiAdmin_pau;
GRANT CONNECT TO glpiAdmin_pau WITH ADMIN OPTION;
GRANT technician_role TO glpiAdmin_pau WITH ADMIN OPTION;
GRANT simple_user_role TO glpiAdmin_pau WITH ADMIN OPTION;
GRANT INSERT, DELETE, SELECT, UPDATE, CREATE VIEW TO glpiAdmin_pau WITH ADMIN OPTION;
GRANT EXECUTE TO glpiAdmin_pau WITH ADMIN OPTION;

COMMIT;