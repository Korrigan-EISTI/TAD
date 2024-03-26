DECLARE
    t_name VARCHAR2(255);
    t_location VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        SELECT location INTO t_location FROM glpiAdmin_pau.glpi_entities WHERE id = i;
        t_name := 'Ticket' || i;

        INSERT INTO glpiAdmin_pau.glpi_tickets (entites_id, user_id_last_updater, name, status, priority, location)
        VALUES (i, 1, t_name, 0, 2, t_location);
    END LOOP;
    COMMIT;
END;
/

INSERT INTO glpiAdmin_pau.selectTicketFromPau (entites_id, name, user_id_last_updater, status, priority)
VALUES (50, 'myPauTicket', 1, 0, 2);

UPDATE glpiAdmin_pau.selectTicketFromPau SET priority = 5 WHERE name = 'myPauTicket';

Exec glpiAdmin_pau.close_ticket(101);
Exec glpiAdmin_pau.reopen_ticket(101);


COMMIT;