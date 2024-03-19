-- Supprimer les tables si elles existent déjà
DROP TABLE IF EXISTS glpi_entities;
DROP TABLE IF EXISTS glpi_tickets;
DROP TABLE IF EXISTS glpi_users;
DROP TABLE IF EXISTS glpi_tickets_category;
DROP TABLE IF EXISTS glpi_notifications;
DROP TABLE IF EXISTS glpi_admin;
DROP TABLE IF EXISTS glpi_treated_tickets;

-- Créer la table glpi_entities pour représenter les entités associées aux tickets
CREATE TABLE glpi_entities (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    name VARCHAR(255) NOT NULL, -- Nom de l'entité
    location VARCHAR(255) NOT NULL -- Emplacement de l'entité
);

-- Créer la table glpi_tickets pour représenter les tickets
CREATE TABLE glpi_tickets (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    entites_id NUMBER(10) NOT NULL, -- Clé étrangère vers glpi_entities
    name VARCHAR(255) NOT NULL, -- Nom du ticket
    date TIMESTAMP NOT NULL default CURRENT_TIMESTAMP, -- Date de création du ticket
    user_id_last_updater NUMBER(10), -- ID de l'utilisateur ayant mis à jour le ticket
    glpi_tickets_category_id NUMBER(10) NOT NULL, -- Catégorie du ticket
    status BOOLEAN NOT NULL, -- Statut du ticket (ouvert/fermé)
    location VARCHAR(255) NOT NULL, -- Emplacement du ticket
    items_id NUMBER(10) NOT NULL, -- ID de l'élément associé au ticket (PC, Logiciel, etc)
    CONSTRAINT fk_tickets_entities FOREIGN KEY (entites_id) REFERENCES glpi_entities(id), -- Contrainte de clé étrangère vers glpi_entities
    CONSTRAINT fk_tickets_users FOREIGN KEY (user_id_last_updater) REFERENCES glpi_users(id), -- Contrainte de clé étrangère vers glpi_users
    CONSTRAINT fk_tickets_category FOREIGN KEY (glpi_tickets_category_id) REFERENCES glpi_tickets_category(id) -- Contrainte de clé étrangère vers glpi_tickets_category
);

-- Créer la table glpi_treated_tickets pour représenter les tickets traités
CREATE TABLE glpi_treated_tickets (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    ticket_id NUMBER(10) NOT NULL, -- ID du ticket associé
    entites_id NUMBER(10) NOT NULL, -- Clé étrangère vers glpi_entities
    name VARCHAR(255) NOT NULL, -- Nom du ticket traité
    date TIMESTAMP NOT NULL, -- Date de création du ticket traité
    closedDate TIMESTAMP NOT NULL, -- Date de fermeture du ticket
    wasSolved BOOLEAN NOT NULL, -- Si le ticket a été fermé résolu ou non-résolu
    glpi_tickets_category_id NUMBER(10) NOT NULL, -- Catégorie du ticket traité
    location VARCHAR(255) NOT NULL, -- Emplacement du ticket traité
    items_id NUMBER(10) NOT NULL, -- ID de l'élément associé au ticket (PC, Logiciel, etc) traité
    CONSTRAINT pk_treated_tickets PRIMARY KEY (id, ticket_id), -- Clé primaire composée
    CONSTRAINT fk_treated_tickets_entities FOREIGN KEY (entites_id) REFERENCES glpi_entities(id), -- Contrainte de clé étrangère vers glpi_entities
    CONSTRAINT fk_treated_tickets_category FOREIGN KEY (glpi_tickets_category_id) REFERENCES glpi_tickets_category(id), -- Contrainte de clé étrangère vers glpi_tickets_category
    CONSTRAINT fk_treated_tickets_items FOREIGN KEY (items_id) REFERENCES glpi_items(id) -- Contrainte de clé étrangère vers glpi_items
);

-- Créer la table glpi_users pour représenter les utilisateurs
CREATE TABLE glpi_users (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    email VARCHAR(255) NOT NULL UNIQUE, -- Adresse email de l'utilisateur
    name VARCHAR(255) NOT NULL, -- Nom de l'utilisateur
    first_name VARCHAR(255) NOT NULL, -- Prénom de l'utilisateur
    password VARCHAR(255) NOT NULL -- Mot de passe de l'utilisateur
);

-- Créer la table glpi_admin pour représenter les administrateurs
CREATE TABLE glpi_admin (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    user_id NUMBER(10) NOT NULL, -- Clé étrangère vers glpi_users
    location VARCHAR(255) NOT NULL, -- Emplacement de l'administrateur
    CONSTRAINT fk_admin_users FOREIGN KEY (user_id) REFERENCES glpi_users(id) -- Contrainte de clé étrangère vers glpi_users
);

-- Créer la table glpi_notifications pour représenter les notifications liées aux tickets
CREATE TABLE glpi_notifications (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    user_id_1 NUMBER(10) NOT NULL, -- ID de l'utilisateur 1
    user_id_2 NUMBER(10) NOT NULL, -- ID de l'utilisateur 2
    tickets_id NUMBER(10) NOT NULL, -- ID du ticket associé à la notification
    CONSTRAINT fk_notifications_user1 FOREIGN KEY (user_id_1) REFERENCES glpi_users(id), -- Contrainte de clé étrangère vers glpi_users pour user_id_1
    CONSTRAINT fk_notifications_user2 FOREIGN KEY (user_id_2) REFERENCES glpi_users(id), -- Contrainte de clé étrangère vers glpi_users pour user_id_2
    CONSTRAINT fk_notifications_tickets FOREIGN KEY (tickets_id) REFERENCES glpi_tickets(id) -- Contrainte de clé étrangère vers glpi_tickets pour tickets_id
);

COMMIT;