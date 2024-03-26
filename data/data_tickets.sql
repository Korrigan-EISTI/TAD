-- On doit utiliser un user de preference pour evité que last_updater soit vide
DECLARE
    t_name VARCHAR2(255);
    t_location VARCHAR2(255);
BEGIN
    FOR i IN 1..700 LOOP
        SELECT location INTO t_location FROM glpi_entities WHERE id = i;
        t_name := 'Ticket' || i;

        INSERT INTO glpi_tickets (entites_id, name, status, priority, location)
        VALUES (i, t_name, 0, 2, t_location);
    END LOOP;
    COMMIT;
END;
/

COMMIT;