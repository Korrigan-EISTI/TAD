-- Activer le mode script Oracle pour permettre la création d'objets de base de données
alter session set "_ORACLE_SCRIPT"=true;

-- Créer un espace de table pour les données d'administration
CREATE TABLESPACE admin
    DATAFILE 'admin.dbf' SIZE 1024M  -- Crée un fichier de données de 1024 Mo
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;  -- Configure l'auto-extension du fichier de données

-- Créer des rôles dans la base de données
CREATE ROLE technician_role;  -- Crée un rôle pour les techniciens
CREATE ROLE simple_user_role;  -- Crée un rôle pour les utilisateurs simples

-- Créer des rôles supplémentaires pour les techniciens à Pau et à Cergy
CREATE ROLE pau_technician_role;  -- Crée un rôle pour les techniciens à Pau
CREATE ROLE cergy_technician_role;  -- Crée un rôle pour les techniciens à Cergy

-- Créer un utilisateur pour l'administrateur GLPI
CREATE USER glpiAdmin IDENTIFIED BY glpiAdmin;  -- Crée un utilisateur avec le nom glpiAdmin et le mot de passe glpiAdmin

-- Accorder le rôle DBA à l'utilisateur glpiAdmin
GRANT DBA TO glpiAdmin;  -- Accorde le rôle de superadministrateur à l'utilisateur glpiAdmin

COMMIT;