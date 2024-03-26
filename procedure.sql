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
    WHERE GRANTED_ROLE IN ('TECHNICIAN_ROLE');

    -- Récupérer la priorité du ticket
    SELECT priority INTO v_priority
    FROM glpi_tickets
    WHERE id = p_ticket_id;

    -- Insérer dans la table glpi_treated_tickets en fonction des données du ticket existant
    EXECUTE IMMEDIATE '
        INSERT INTO glpi_treated_tickets (id, ticket_id, entites_id, name, creation_date, closedDate, solvedStatus, previousPriority, location)
        SELECT glpi_treated_tickets_seq.NEXTVAL, id, entites_id, name, creation_date, SYSTIMESTAMP, CASE WHEN :tech_role_exists > 0 THEN 1 ELSE 0 END, priority, location
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
-- Avertissement : Procédure créée avec erreurs de compilation.
CREATE OR REPLACE PROCEDURE reopen_ticket (
    p_ticket_id IN NUMBER  -- ID du ticket à rouvrir
) AS
    v_priority NUMBER(1); -- Variable pour stocker la priorité du ticket
BEGIN

    -- Récupérer la priorité du ticket
    SELECT previousPriority INTO v_priority
    FROM glpi_treated_tickets
    WHERE ticket_id = p_ticket_id;

    -- Insérer dans la table glpi_tickets en fonction des données du ticket traité
    EXECUTE IMMEDIATE '
        INSERT INTO glpi_tickets (id, entites_id, name, creation_date, user_id_last_updater, status, priority, location)
        SELECT :ticket_id, entites_id, name, SYSTIMESTAMP, NULL, 0, :priority, location
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

-- Beaucoup trop long mais j'ai pas d'autre solution pour l'instant
CREATE OR REPLACE PROCEDURE create_users_procedure AS
BEGIN
    FOR user_rec IN (SELECT id, email, last_name, first_name, password FROM glpi_users) LOOP
        DECLARE
            user_count NUMBER;
        BEGIN
            -- Check if user already exists
            SELECT COUNT(*) INTO user_count FROM all_users WHERE username = upper(user_rec.last_name || '_' || user_rec.first_name);

            -- If user does not exist, create user and grant privileges
            IF user_count = 0 THEN
                EXECUTE IMMEDIATE 'CREATE USER ' || user_rec.last_name || '_' || user_rec.first_name ||
                                  ' IDENTIFIED BY "' || user_rec.password || '"';

                EXECUTE IMMEDIATE 'GRANT CONNECT TO ' || user_rec.last_name || '_' || user_rec.first_name;

                EXECUTE IMMEDIATE 'GRANT simple_user_role TO ' || user_rec.last_name || '_' || user_rec.first_name;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                -- Handle exceptions (e.g., log the error)
                DBMS_OUTPUT.PUT_LINE('Error creating user: ' || SQLERRM);
        END;
    END LOOP;
END create_users_procedure;
/

CREATE OR REPLACE PROCEDURE add_admin_procedure (
    p_user_id IN NUMBER     -- ID de l'utilisateur
)
AS
    v_first_name VARCHAR2(32767);  -- Variable pour stocker le prénom de l'utilisateur
    v_last_name VARCHAR2(32767);    -- Variable pour stocker le nom de famille de l'utilisateur
BEGIN
    -- Obtenir le prénom et le nom de famille de l'utilisateur à partir de l'ID fourni
    SELECT first_name, last_name INTO v_first_name, v_last_name FROM glpi_users WHERE id = p_user_id;

    -- Attribuer le rôle de technicien pour l'utilisateur spécifié
    EXECUTE IMMEDIATE 'GRANT technician_role TO ' || v_last_name || '_' || v_first_name;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('L''utilisateur avec l''ID fourni n''existe pas.');  -- Gérer le cas où aucun utilisateur n'est trouvé avec l'ID donné
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END add_admin_procedure;
/

COMMIT;