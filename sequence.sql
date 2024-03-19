-- Suppression des séquences existantes
DROP SEQUENCE glpi_entities_seq;  -- Supprime la séquence pour la table glpi_entities
DROP SEQUENCE glpi_tickets_seq;  -- Supprime la séquence pour la table glpi_tickets
DROP SEQUENCE glpi_treated_tickets_seq;  -- Supprime la séquence pour la table glpi_treated_tickets
DROP SEQUENCE glpi_users_seq;  -- Supprime la séquence pour la table glpi_users
DROP SEQUENCE glpi_admin_seq;  -- Supprime la séquence pour la table glpi_admin
DROP SEQUENCE glpi_notifications_seq;  -- Supprime la séquence pour la table glpi_notifications

-- Création de nouvelles séquences
CREATE SEQUENCE glpi_entities_seq START WITH 1 INCREMENT BY 1;  -- Crée une nouvelle séquence pour la table glpi_entities, commençant à 1 avec un pas de 1
CREATE SEQUENCE glpi_tickets_seq START WITH 1 INCREMENT BY 1;  -- Crée une nouvelle séquence pour la table glpi_tickets, commençant à 1 avec un pas de 1
CREATE SEQUENCE glpi_treated_tickets_seq START WITH 1 INCREMENT BY 1;  -- Crée une nouvelle séquence pour la table glpi_treated_tickets, commençant à 1 avec un pas de 1
CREATE SEQUENCE glpi_users_seq START WITH 1 INCREMENT BY 1;  -- Crée une nouvelle séquence pour la table glpi_users, commençant à 1 avec un pas de 1
CREATE SEQUENCE glpi_admin_seq START WITH 1 INCREMENT BY 1;  -- Crée une nouvelle séquence pour la table glpi_admin, commençant à 1 avec un pas de 1
CREATE SEQUENCE glpi_notifications_seq START WITH 1 INCREMENT BY 1;  -- Crée une nouvelle séquence pour la table glpi_notifications, commençant à 1 avec un pas de 1
