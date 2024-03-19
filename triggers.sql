-- Création des séquences pour chaque table
-- Les séquences génèrent des identifiants uniques pour chaque table
CREATE SEQUENCE glpi_entities_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_tickets_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_treated_tickets_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_users_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_admin_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_notifications_seq START WITH 1 INCREMENT BY 1;

-- Déclencheurs pour chaque table pour récupérer les identifiants uniques avant l'insertion
-- Les déclencheurs assurent l'assignation automatique des identifiants à chaque insertion
CREATE OR REPLACE TRIGGER glpi_entities_trigger
BEFORE INSERT ON glpi_entities
FOR EACH ROW
BEGIN
    SELECT glpi_entities_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtenir la prochaine valeur de la séquence et l'assigner à l'ID de la nouvelle ligne
END;

CREATE OR REPLACE TRIGGER glpi_tickets_trigger
BEFORE INSERT ON glpi_tickets
FOR EACH ROW
BEGIN
    SELECT glpi_tickets_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtenir la prochaine valeur de la séquence et l'assigner à l'ID de la nouvelle ligne
END;

CREATE OR REPLACE TRIGGER glpi_treated_tickets_trigger
BEFORE INSERT ON glpi_treated_tickets
FOR EACH ROW
BEGIN
    SELECT glpi_treated_tickets_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtenir la prochaine valeur de la séquence et l'assigner à l'ID de la nouvelle ligne
END;

CREATE OR REPLACE TRIGGER glpi_users_trigger
BEFORE INSERT ON glpi_users
FOR EACH ROW
BEGIN
    SELECT glpi_users_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtenir la prochaine valeur de la séquence et l'assigner à l'ID de la nouvelle ligne
END;

CREATE OR REPLACE TRIGGER glpi_admin_trigger
BEFORE INSERT ON glpi_admin
FOR EACH ROW
BEGIN
    SELECT glpi_admin_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtenir la prochaine valeur de la séquence et l'assigner à l'ID de la nouvelle ligne
END;

CREATE OR REPLACE TRIGGER glpi_notifications_trigger
BEFORE INSERT ON glpi_notifications
FOR EACH ROW
BEGIN
    SELECT glpi_notifications_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtenir la prochaine valeur de la séquence et l'assigner à l'ID de la nouvelle ligne
END;

-- Déclencheur pour la vue cergy_tickets
-- Le déclencheur permet de manipuler les opérations d'insertion, de mise à jour et de suppression sur la vue cergy_tickets
CREATE OR REPLACE TRIGGER cergy_tickets_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE ON cergy_tickets
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Effectuer l'insertion dans la table glpi_tickets
        INSERT INTO glpi_tickets (id, entites_id, name, date, user_id_last_updater, glpi_tickets_category_id, status, location, items_id)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.date, :NEW.user_id_last_updater, :NEW.glpi_tickets_category_id, :NEW.status, :NEW.location, :NEW.items_id);
    ELSIF UPDATING THEN
        -- Effectuer la mise à jour dans la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            date = :NEW.date,
            user_id_last_updater = :NEW.user_id_last_updater,
            glpi_tickets_category_id = :NEW.glpi_tickets_category_id,
            status = :NEW.status,
            location = :NEW.location,
            items_id = :NEW.items_id
        WHERE
            id = :NEW.id;
    ELSIF DELETING THEN
        -- Effectuer la suppression dans la table glpi_tickets
        DELETE FROM glpi_tickets WHERE id = :OLD.id;
    END IF;
END;
/

-- Déclencheur pour la vue pau_tickets (de manière similaire)
-- Ce déclencheur fonctionne de manière similaire à celui de la vue cergy_tickets
CREATE OR REPLACE TRIGGER pau_tickets_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE ON pau_tickets
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Effectuer l'insertion dans la table glpi_tickets
        INSERT INTO glpi_tickets (id, entites_id, name, date, user_id_last_updater, glpi_tickets_category_id, status, location, items_id)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.date, :NEW.user_id_last_updater, :NEW.glpi_tickets_category_id, :NEW.status, :NEW.location, :NEW.items_id);
    ELSIF UPDATING THEN
        -- Effectuer la mise à jour dans la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            date = :NEW.date,
            user_id_last_updater = :NEW.user_id_last_updater,
            glpi_tickets_category_id = :NEW.glpi_tickets_category_id,
            status = :NEW.status,
            location = :NEW.location,
            items_id = :NEW.items_id
        WHERE
            id = :NEW.id;
    ELSIF DELETING THEN
        -- Effectuer la suppression dans la table glpi_tickets
        DELETE FROM glpi_tickets WHERE id = :OLD.id;
    END IF;
END;
/

-- Déclencheur pour créer un utilisateur dans le système externe après l'insertion dans glpi_users
-- Ce déclencheur appelle une procédure stockée pour créer un utilisateur dans un système externe
CREATE OR REPLACE TRIGGER create_user_trigger
AFTER INSERT ON glpi_users
FOR EACH ROW
BEGIN
    create_user_procedure(:NEW.name, :NEW.password); -- Appel de la procédure stockée avec les informations du nouvel utilisateur
END;
/

-- Déclencheur pour ajouter un administrateur dans le système externe après l'insertion dans glpi_admin
-- Ce déclencheur appelle une procédure stockée pour ajouter un administrateur dans un système externe
CREATE OR REPLACE TRIGGER add_admin_trigger
AFTER INSERT ON glpi_admin
FOR EACH ROW
BEGIN
    add_admin_procedure(:NEW.user_id, :NEW.location); -- Appel de la procédure stockée avec les informations du nouvel administrateur
END;
/

COMMIT;