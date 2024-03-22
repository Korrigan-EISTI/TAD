-- Déclencheur pour gérer les opérations sur les tickets sur le site de Fermat
CREATE OR REPLACE TRIGGER insert_ticket_fermat
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromFermat
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Fermat', :NEW.items_id, :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Fermat',
            items_id = :NEW.items_id,
            priority = :NEW.priority
        WHERE
            id = :NEW.id;
    ELSIF DELETING THEN
        -- Supprimer de la table glpi_tickets
        DELETE FROM glpi_tickets WHERE id = :OLD.id;
    END IF;
END;
/

show errors;

-- Déclencheur pour gérer les opérations sur les tickets dans le batiment Cauchy
CREATE OR REPLACE TRIGGER insert_ticket_cauchy
INSTEAD OF INSERT OR UPDATE OR DELETE ON selectTicketFromCauchy
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Insérer dans la table glpi_tickets
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Cauchy', :NEW.items_id, :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Cauchy',
            items_id = :NEW.items_id,
            priority = :NEW.priority
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
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Turing', :NEW.items_id, :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Turing',
            items_id = :NEW.items_id,
            priority = :NEW.priority
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
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Condorcet', :NEW.items_id, :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Condorcet',
            items_id = :NEW.items_id,
            priority = :NEW.priority
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
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Saint Martin', :NEW.items_id, :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Saint Martin',
            items_id = :NEW.items_id,
            priority = :NEW.priority
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
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        VALUES (:NEW.id, :NEW.entites_id, :NEW.name, :NEW.creation_date, :NEW.user_id_last_updater, :NEW.status, 'Saint Germain', :NEW.items_id, :NEW.priority);
    ELSIF UPDATING THEN
        -- Mettre à jour la table glpi_tickets
        UPDATE glpi_tickets
        SET
            entites_id = :NEW.entites_id,
            name = :NEW.name,
            creation_date = :NEW.creation_date,
            user_id_last_updater = :NEW.user_id_last_updater,
            status = :NEW.status,
            location = 'Saint Germain',
            items_id = :NEW.items_id,
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