-- Déclencheur pour générer des identifiants uniques avant l'insertion dans la table glpi_entities
CREATE OR REPLACE TRIGGER glpi_entities_trigger
BEFORE INSERT ON glpi_entities
FOR EACH ROW
BEGIN
    SELECT glpi_entities_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtient la prochaine valeur de la séquence et l'assigne à l'ID de la nouvelle ligne
END;
/

-- Déclencheur pour générer des identifiants uniques avant l'insertion dans la table glpi_tickets
CREATE OR REPLACE TRIGGER glpi_tickets_trigger
BEFORE INSERT ON glpi_tickets
FOR EACH ROW
BEGIN
    SELECT glpi_tickets_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtient la prochaine valeur de la séquence et l'assigne à l'ID de la nouvelle ligne
END;
/

-- Déclencheur pour générer des identifiants uniques avant l'insertion dans la table glpi_treated_tickets
CREATE OR REPLACE TRIGGER glpi_treated_tickets_trigger
BEFORE INSERT ON glpi_treated_tickets
FOR EACH ROW
BEGIN
    SELECT glpi_treated_tickets_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtient la prochaine valeur de la séquence et l'assigne à l'ID de la nouvelle ligne
END;
/

-- Déclencheur pour générer des identifiants uniques avant l'insertion dans la table glpi_users
CREATE OR REPLACE TRIGGER glpi_users_trigger
BEFORE INSERT ON glpi_users
FOR EACH ROW
BEGIN
    SELECT glpi_users_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtient la prochaine valeur de la séquence et l'assigne à l'ID de la nouvelle ligne
END;
/

-- Déclencheur pour générer des identifiants uniques avant l'insertion dans la table glpi_admin
CREATE OR REPLACE TRIGGER glpi_admin_trigger
BEFORE INSERT ON glpi_admin
FOR EACH ROW
BEGIN
    SELECT glpi_admin_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtient la prochaine valeur de la séquence et l'assigne à l'ID de la nouvelle ligne
END;
/

-- Déclencheur pour générer des identifiants uniques avant l'insertion dans la table glpi_notifications
CREATE OR REPLACE TRIGGER glpi_notifications_trigger
BEFORE INSERT ON glpi_notifications
FOR EACH ROW
BEGIN
    SELECT glpi_notifications_seq.NEXTVAL INTO :NEW.id FROM dual; -- Obtient la prochaine valeur de la séquence et l'assigne à l'ID de la nouvelle ligne
END;
/

-- Déclencheur pour créer un utilisateur externe après l'insertion dans glpi_users
/*
CREATE OR REPLACE TRIGGER create_user_trigger
AFTER INSERT ON glpi_users
FOR EACH ROW
BEGIN
    create_user_procedure(:NEW.last_name, :NEW.id, :NEW.password); -- Appel de la procédure stockée pour créer un utilisateur externe avec les informations du nouvel utilisateur
END;
/
*/

-- Déclencheur pour ajouter un administrateur externe après l'insertion dans glpi_admin
/*
CREATE OR REPLACE TRIGGER add_admin_trigger
AFTER INSERT ON glpi_admin
FOR EACH ROW
BEGIN
    add_admin_procedure(:NEW.user_id); -- Appel de la procédure stockée pour ajouter un administrateur externe avec les informations du nouvel administrateur
END;
/
*/

CREATE OR REPLACE TRIGGER trg_user_id_last_updater_notification
AFTER UPDATE OF user_id_last_updater ON glpi_tickets
FOR EACH ROW
DECLARE
    v_user_id_1 glpi_users.id%TYPE;
    v_user_id_2 glpi_users.id%TYPE;
BEGIN
    -- Récupérer les IDs des utilisateurs concernés
    SELECT id INTO v_user_id_1 FROM glpi_users WHERE id = :OLD.user_id_last_updater;
    SELECT id INTO v_user_id_2 FROM glpi_users WHERE id = :NEW.user_id_last_updater;

    -- Insérer une nouvelle notification
    INSERT INTO glpi_notifications (id, user_id_1, user_id_2, tickets_id)
    VALUES (glpi_notifications_seq.NEXTVAL, v_user_id_1, v_user_id_2, :NEW.id);
END;
/

CREATE OR REPLACE TRIGGER trg_delete_user
BEFORE DELETE ON glpi_users
FOR EACH ROW
BEGIN
    -- Supprimer l'utilisateur Oracle correspondant
    EXECUTE IMMEDIATE 'DROP USER ' || :OLD.last_name || '_' || :OLD.first_name || ' CASCADE';
END;
/

COMMIT;