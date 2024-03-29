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

COMMIT;