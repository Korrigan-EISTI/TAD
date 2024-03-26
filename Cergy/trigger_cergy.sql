-- Déclencheur pour gérer les opérations sur les tickets sur le site de Fermat
CREATE OR REPLACE TRIGGER insert_ticket_fermat
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromFermat
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Fermat', :NEW.priority);
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

-- Déclencheur pour gérer les opérations sur les tickets dans le batiment Cauchy
CREATE OR REPLACE TRIGGER insert_ticket_cauchy
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromCauchy
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Cauchy', :NEW.priority);
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

-- Déclencheur pour gérer les opérations sur les tickets à Cergy
CREATE OR REPLACE TRIGGER insert_ticket_turing
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromTuring
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Turing', :NEW.priority);
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

-- Déclencheur pour gérer les opérations sur les tickets à Cergy
CREATE OR REPLACE TRIGGER insert_ticket_condorcet
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromCondorcet
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Condorcet', :NEW.priority);
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

-- Déclencheur pour gérer les opérations sur les tickets à Cergy
CREATE OR REPLACE TRIGGER insert_ticket_martin
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromMartin
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Saint Martin', :NEW.priority);
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

-- Déclencheur pour gérer les opérations sur les tickets à Cergy
CREATE OR REPLACE TRIGGER insert_ticket_Germain
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromGermain
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (entites_id, name, user_id_last_updater, status, location, priority)
        VALUES (:NEW.entites_id, :NEW.name, :NEW.user_id_last_updater, :NEW.status, 'Saint Germain', :NEW.priority);
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