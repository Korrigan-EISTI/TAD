-- Activer le mode script Oracle pour permettre la création d'objets de base de données
alter session set "_ORACLE_SCRIPT"=true;

-- Créer un espace de table pour les données d'administration
CREATE TABLESPACE admin
    DATAFILE 'admin.dbf' SIZE 1024M
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

-- Créer des rôles dans la base de données
CREATE ROLE technician_role;
CREATE ROLE simple_user_role;

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin IDENTIFIED BY glpiAdmin;

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin;

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin_cergy IDENTIFIED BY cergy;

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin_cergy;

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin_pau IDENTIFIED BY pau;

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin_pau;

COMMIT;