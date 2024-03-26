-- Déclencheur pour gérer les opérations sur les tickets sur le site de Pau
CREATE OR REPLACE TRIGGER insert_ticket_pau
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromPau
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Pau', :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = NVL(:NEW.entites_id, entites_id),
            name =  NVL(:NEW.name, name),
            user_id_last_updater =  NVL(:NEW.user_id_last_updater, user_id_last_updater),
            status = NVL(:NEW.status, status),
            priority =  NVL(:NEW.priority, priority)
        WHERE
            id = :NEW.id;
    ELSIF DELETING THEN
        -- Supprimer de la table glpi_tickets
        DELETE FROM glpi_tickets WHERE id = :OLD.id;
    END IF;
END;
/

COMMIT;