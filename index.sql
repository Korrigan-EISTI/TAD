-- Création d'un index sur la colonne location de la table glpi_tickets
-- Cet index accélérera les opérations de recherche basées sur la localisation des tickets
CREATE INDEX idx_glpi_tickets_location ON glpi_tickets(location);

-- Création d'un index sur la colonne entites_id de la table glpi_tickets
-- Cet index améliorera les performances des requêtes impliquant les entités des tickets
CREATE INDEX idx_glpi_tickets_entities_id ON glpi_tickets(entites_id);

-- Création d'un index sur la colonne entites_id de la table glpi_treated_tickets
-- Cet index améliorera les performances des requêtes impliquant les entités des tickets traités
CREATE INDEX idx_glpi_treated_tickets_entities_id ON glpi_treated_tickets(entites_id);

-- Création d'un index sur la colonne email de la table glpi_users
-- Cet index améliorera les performances des requêtes impliquant l'email des utilisateurs
CREATE UNIQUE INDEX idx_glpi_users_email ON glpi_users(email);

-- Création d'un index sur la colonne user_id_1 de la table glpi_notifications
-- Cet index améliorera les performances des requêtes impliquant l'ID de l'utilisateur 1 dans les notifications
CREATE INDEX idx_glpi_notifications_user_id_1 ON glpi_notifications(user_id_1);

-- Création d'un index sur la colonne user_id_2 de la table glpi_notifications
-- Cet index améliorera les performances des requêtes impliquant l'ID de l'utilisateur 2 dans les notifications
CREATE INDEX idx_glpi_notifications_user_id_2 ON glpi_notifications(user_id_2);

COMMIT;