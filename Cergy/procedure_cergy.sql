-- Procédure pour fermer un ticket en tenant compte de la priorité
CREATE OR REPLACE PROCEDURE close_ticket_cergy (
    p_ticket_id IN NUMBER  -- ID du ticket à fermer
) AS
    v_technician_role_exists NUMBER(1);  -- Variable pour stocker l'existence de rôles de technicien
    v_priority NUMBER(1); -- Variable pour stocker la priorité du ticket
BEGIN
    -- Vérifier si l'utilisateur actuel possède l'un des rôles de technicien pour Cergy ou Pau
    SELECT COUNT(*) INTO v_technician_role_exists
    FROM USER_ROLE_PRIVS
    WHERE GRANTED_ROLE IN ('TECHNICIAN_ROLE');

    -- Récupérer la priorité du ticket
    SELECT priority INTO v_priority
    FROM glpiAdmin_cergy.glpi_tickets
    WHERE id = p_ticket_id;

    -- Insérer dans la table glpi_treated_tickets en fonction des données du ticket existant
    EXECUTE IMMEDIATE '
        INSERT INTO glpiAdmin_cergy.glpi_treated_tickets (id, ticket_id, entites_id, name, creation_date, closedDate, solvedStatus, previousPriority, location)
        SELECT glpiAdmin_cergy.glpi_treated_tickets_seq.NEXTVAL, id, entites_id, name, creation_date, SYSTIMESTAMP, CASE WHEN :tech_role_exists > 0 THEN 1 ELSE 0 END, priority, location
        FROM glpiAdmin_cergy.glpi_tickets
        WHERE id = :ticket_id'
    USING v_technician_role_exists, p_ticket_id;

    -- Supprimer le ticket traité de la table glpi_tickets
    DELETE FROM glpiAdmin_cergy.glpi_notifications WHERE tickets_id = p_ticket_id;
    DELETE FROM glpiAdmin_cergy.glpi_tickets WHERE id = p_ticket_id;

    -- Si la priorité du ticket est élevée (5), notifier les administrateurs
    IF v_priority = 5 THEN
        -- Ajouter ici la logique pour notifier les administrateurs
        DBMS_OUTPUT.PUT_LINE('Ticket fermé avec priorité élevée. Notification envoyée aux administrateurs.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

GRANT EXECUTE ON close_ticket_cergy to technician_role;
GRANT EXECUTE ON close_ticket_cergy to simple_user_role;

-- Procédure pour rouvrir un ticket en tenant compte de la priorité
CREATE OR REPLACE PROCEDURE reopen_ticket_cergy (
    p_ticket_id IN NUMBER  -- ID du ticket à rouvrir
) AS
    v_priority NUMBER(1); -- Variable pour stocker la priorité du ticket
BEGIN

    -- Récupérer la priorité du ticket
    SELECT previousPriority INTO v_priority
    FROM glpiAdmin_cergy.glpi_treated_tickets
    WHERE ticket_id = p_ticket_id;

    -- Insérer dans la table glpi_tickets en fonction des données du ticket traité
    EXECUTE IMMEDIATE '
        INSERT INTO glpiAdmin_cergy.glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, priority, location)
        SELECT :ticket_id, entites_id, name, SYSTIMESTAMP, NULL, 0, :priority, location
        FROM glpiAdmin_cergy.glpi_treated_tickets
        WHERE ticket_id = :ticket_id'
    USING p_ticket_id, v_priority, p_ticket_id;

    -- Supprimer le ticket traité de la table glpi_treated_tickets
    DELETE FROM glpiAdmin_cergy.glpi_treated_tickets WHERE ticket_id = p_ticket_id;

    COMMIT;

    -- Si la priorité du ticket est élevée (5), notifier les administrateurs
    IF v_priority = 5 THEN
        -- Ajouter ici la logique pour notifier les administrateurs
        DBMS_OUTPUT.PUT_LINE('Ticket réouvert avec priorité élevée. Notification envoyée aux administrateurs.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

GRANT EXECUTE ON reopen_ticket_cergy to technician_role;
GRANT EXECUTE ON reopen_ticket_cergy to simple_user_role;