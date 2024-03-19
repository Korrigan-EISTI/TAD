CREATE OR REPLACE PROCEDURE close_ticket (
    p_ticket_id IN NUMBER
) AS
BEGIN
    -- Insérer dans la table glpi_treated_tickets en fonction des données du ticket existant
    INSERT INTO glpi_treated_tickets (id, ticket_id, entites_id, name, date, closedDate, solveDate, glpi_tickets_category_id, location, items_id)
    SELECT
        glpi_treated_tickets_seq.NEXTVAL,
        id,
        entites_id,
        name,
        date,
        SYSTIMESTAMP,
        CASE WHEN USER IN (SELECT GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTEE = USER AND GRANTED_ROLE = 'ADMIN_ROLE') THEN SYSTIMESTAMP ELSE NULL END,
        glpi_tickets_category_id,
        location,
        items_id
    FROM
        glpi_tickets
    WHERE
        id = p_ticket_id;
        
    -- Supprimer le ticket traité de la table glpi_tickets
    DELETE FROM glpi_tickets WHERE id = p_ticket_id;
    
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE reopen_closed_ticket (
    p_ticket_id IN NUMBER
) AS
BEGIN
    -- Insérer dans la table glpi_tickets en fonction des données du ticket traité existant
    INSERT INTO glpi_tickets (id, entites_id, name, date, user_id_last_updater, glpi_tickets_category_id, status, location, items_id)
    SELECT
        ticket_id,
        entites_id,
        name,
        date,
        NULL, -- Réinitialiser l'utilisateur ayant mis à jour le ticket
        glpi_tickets_category_id,
        TRUE, -- Définir le statut du ticket sur ouvert
        location,
        items_id
    FROM
        glpi_treated_tickets
    WHERE
        ticket_id = p_ticket_id;
        
    -- Supprimer le ticket traité de la table glpi_treated_tickets
    DELETE FROM glpi_treated_tickets WHERE ticket_id = p_ticket_id;
    
    COMMIT;
END;
/

COMMIT;