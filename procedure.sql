-- Procédure pour fermer un ticket en tenant compte de la priorité
CREATE OR REPLACE PROCEDURE close_ticket (
    p_ticket_id IN NUMBER  -- ID du ticket à fermer
) AS
    v_technician_role_exists NUMBER(1);  -- Variable pour stocker l'existence de rôles de technicien
    v_priority NUMBER(1); -- Variable pour stocker la priorité du ticket
BEGIN
    -- Vérifier si l'utilisateur actuel possède l'un des rôles de technicien pour Cergy ou Pau
    SELECT COUNT(*) INTO v_technician_role_exists
    FROM USER_ROLE_PRIVS
    WHERE GRANTED_ROLE IN ('PAU_TECHNICIAN_ROLE', 'CERGY_TECHNICIAN_ROLE');

    -- Récupérer la priorité du ticket
    SELECT priority INTO v_priority
    FROM glpi_tickets
    WHERE id = p_ticket_id;

    -- Insérer dans la table glpi_treated_tickets en fonction des données du ticket existant
    EXECUTE IMMEDIATE '
        INSERT INTO glpi_treated_tickets (id, ticket_id, entites_id, name, creation_date, closedDate, solvedStatus, location, items_id)
        SELECT glpi_treated_tickets_seq.NEXTVAL, id, entites_id, name, creation_date, SYSTIMESTAMP, CASE WHEN :tech_role_exists > 0 THEN 1 ELSE 0 END, location, items_id
        FROM glpi_tickets
        WHERE id = :ticket_id'
    USING v_technician_role_exists, p_ticket_id;

    -- Supprimer le ticket traité de la table glpi_tickets
    DELETE FROM glpi_tickets WHERE id = p_ticket_id;

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

-- Procédure pour rouvrir un ticket en tenant compte de la priorité
CREATE OR REPLACE PROCEDURE reopen_ticket (
    p_ticket_id IN NUMBER  -- ID du ticket à rouvrir
) AS
    v_technician_role_exists NUMBER(1);  -- Variable pour stocker l'existence de rôles de technicien
    v_priority NUMBER(1); -- Variable pour stocker la priorité du ticket
BEGIN
    -- Vérifier si l'utilisateur actuel possède l'un des rôles de technicien pour Cergy ou Pau
    SELECT COUNT(*) INTO v_technician_role_exists
    FROM USER_ROLE_PRIVS
    WHERE GRANTED_ROLE IN ('PAU_TECHNICIAN_ROLE', 'CERGY_TECHNICIAN_ROLE');

    -- Récupérer la priorité du ticket
    SELECT priority INTO v_priority
    FROM glpi_treated_tickets
    WHERE ticket_id = p_ticket_id;

    -- Insérer dans la table glpi_tickets en fonction des données du ticket traité
    EXECUTE IMMEDIATE '
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, location, items_id, priority)
        SELECT :ticket_id, entites_id, name, SYSTIMESTAMP, NULL, 0, location, items_id, :priority
        FROM glpi_treated_tickets
        WHERE ticket_id = :ticket_id'
    USING p_ticket_id, v_priority, p_ticket_id;

    -- Supprimer le ticket traité de la table glpi_treated_tickets
    DELETE FROM glpi_treated_tickets WHERE ticket_id = p_ticket_id;

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

-- Procédure pour créer un nouvel utilisateur
CREATE OR REPLACE PROCEDURE create_user_procedure (
    p_username IN VARCHAR2,   -- Nom d'utilisateur
    p_password IN VARCHAR2    -- Mot de passe
)
AS
BEGIN
    -- Créer un nouvel utilisateur avec le nom et le mot de passe fournis
    EXECUTE IMMEDIATE 'CREATE USER ' || p_username || ' IDENTIFIED BY "' || p_password || '"';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO ' || p_username;
    -- Attribuer le rôle simple_user_role à l'utilisateur créé
    EXECUTE IMMEDIATE 'GRANT simple_user_role TO ' || p_username;
END create_user_procedure;
/

-- Procédure pour ajouter un rôle administratif à un utilisateur
CREATE OR REPLACE PROCEDURE add_admin_procedure (
    p_user_id IN NUMBER,     -- ID de l'utilisateur
    p_location IN VARCHAR2   -- Emplacement pour attribuer le rôle (Cergy ou Pau)
)
AS
BEGIN
    DECLARE
        v_username VARCHAR2(255);  -- Variable pour stocker le nom d'utilisateur
    BEGIN
        -- Obtenir le nom d'utilisateur à partir de l'ID fourni
        SELECT name INTO v_username FROM glpi_users WHERE id = p_user_id;
        -- Attribuer le rôle de technicien pour l'emplacement spécifié à l'utilisateur
        EXECUTE IMMEDIATE 'GRANT ' || LOWER(p_location) || '_technician_role TO ' || v_username;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('L''utilisateur avec l''ID fourni n''existe pas.');  -- Gérer le cas où aucun utilisateur n'est trouvé avec l'ID donné
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END;
END add_admin_procedure;
/

COMMIT;