-- Déclencheur pour gérer les opérations sur les tickets sur le site de Pau
CREATE OR REPLACE TRIGGER insert_ticket_pau
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromPau
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Pau', :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Pau',
            priority = :NEW.priority
        WHERE
            id = :NEW.id;
    ELSIF DELETING THEN
        -- Supprimer de la table glpi_tickets
        DELETE FROM glpi_tickets WHERE id = :OLD.id;
    END IF;
END;
/

COMMIT;