-- Procédure pour clore un ticket
-- Cette procédure clôture un ticket en le déplaçant vers la table des tickets traités
CREATE OR REPLACE PROCEDURE close_ticket (
    p_ticket_id IN NUMBER
) AS
BEGIN
    -- Insérer dans la table glpi_treated_tickets en fonction des données du ticket existant
    INSERT INTO glpi_treated_tickets (id, ticket_id, entites_id, name, date, closedDate, wasSolved, glpi_tickets_category_id, location, items_id)
    SELECT
        glpi_treated_tickets_seq.NEXTVAL,
        id,
        entites_id,
        name,
        date,
        SYSTIMESTAMP,
        CASE WHEN USER IN (SELECT GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTEE = USER AND GRANTED_ROLE = 'ADMIN_ROLE') THEN SYSTIMESTAMP ELSE NULL END,
        TRUE, -- Le ticket est considéré comme résolu lorsqu'il est clos
        glpi_tickets_category_id,
        location,
        items_id
    FROM
        glpi_tickets
    WHERE
        id = p_ticket_id;
        
    -- Supprimer le ticket traité de la table glpi_tickets
    DELETE FROM glpi_tickets WHERE id = p_ticket_id;
    
    COMMIT; -- Validation des changements dans la base de données
END;
/

-- Procédure pour rouvrir un ticket fermé
-- Cette procédure rouvre un ticket en le déplaçant de la table des tickets traités à la table des tickets ouverts
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
    
    COMMIT; -- Validation des changements dans la base de données
END;
/

-- Procédure pour créer un nouvel utilisateur
-- Cette procédure crée un nouvel utilisateur dans le système avec un rôle par défaut.
CREATE OR REPLACE PROCEDURE create_user_procedure (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
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

-- Procédure pour ajouter un administrateur avec un rôle spécifique basé sur son emplacement
-- Cette procédure attribue un rôle spécifique à un utilisateur en fonction de son emplacement.
CREATE OR REPLACE PROCEDURE add_admin_procedure (
    p_user_id IN NUMBER,
    p_location IN VARCHAR2
)
AS
BEGIN
    DECLARE
        v_username VARCHAR2(255);
    BEGIN
        -- Récupérer le nom d'utilisateur à partir de l'ID fourni
        SELECT name INTO v_username FROM glpi_users WHERE id = p_user_id;
        -- Attribuer un rôle spécifique basé sur l'emplacement de l'administrateur
        EXECUTE IMMEDIATE 'GRANT ' || LOWER(p_location) || '_technician_role TO ' || v_username;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('L''utilisateur avec l''ID fourni n''existe pas.');
    END;
END add_admin_procedure;
/

COMMIT;