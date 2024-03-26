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

GRANT EXECUTE ON create_users_procedure to technician_role;

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

CREATE OR REPLACE PROCEDURE scan_and_check_users
IS
    v_user_count NUMBER;
BEGIN
    -- Pour chaque utilisateur Oracle
    FOR oracle_user IN (SELECT username FROM all_users WHERE username NOT IN ('SYS','SYSTEM'))
    LOOP
        -- Vérifier si un utilisateur GLPI correspondant existe
        SELECT COUNT(*) INTO v_user_count
        FROM glpi_users
        WHERE CONCAT(glpi_users.last_name, '_', glpi_users.first_name) = oracle_user.username;
        
        -- Si aucun utilisateur GLPI correspondant n'est trouvé
        IF v_user_count = 0 THEN
            EXECUTE IMMEDIATE 'DROP USER ' oracle_user;
        END IF;
    END LOOP;
END;
/

GRANT EXECUTE ON scan_and_check_users to technician_role;

COMMIT;