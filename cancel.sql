-- Activer le mode script Oracle pour permettre la création d'objets de base de données
alter session set "_ORACLE_SCRIPT"=true;

-- Supprimer l'utilisateur glpiAdmin et tous ses objets associés
DROP USER glpiAdmin CASCADE;

-- Supprimer les tables spécifiées
DROP TABLE glpi_treated_tickets;
DROP TABLE glpi_notifications;
DROP TABLE glpi_tickets;
DROP TABLE glpi_admin;
DROP TABLE glpi_users;
DROP TABLE glpi_entities;

-- Supprimer les rôles spécifiés
DROP ROLE technician_role;
DROP ROLE simple_user_role;
DROP ROLE pau_technician_role;
DROP ROLE cergy_technician_role;

-- Supprimer l'espace de table admin et tous ses objets, y compris les fichiers de données
DROP TABLESPACE admin INCLUDING CONTENTS AND DATAFILES;
