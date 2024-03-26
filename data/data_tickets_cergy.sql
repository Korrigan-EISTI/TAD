DECLARE
    t_name VARCHAR2(255);
    t_location VARCHAR2(255);
BEGIN
    FOR i IN 1..600 LOOP
        SELECT location INTO t_location FROM glpiAdmin_cergy.glpi_entities WHERE id = i;
        t_name := 'Ticket' || i;

        INSERT INTO glpiAdmin_cergy.glpi_tickets (entites_id, user_id_last_updater, name, status, priority, location)
        VALUES (i, 1, t_name, 0, 2, t_location);
    END LOOP;
    COMMIT;
END;
/

INSERT INTO glpiAdmin_cergy.selectTicketFromFermat (entites_id, name, user_id_last_updater, status, priority)
VALUES (50, 'myCergyTicket', 1, 0, 2);

UPDATE glpiAdmin_cergy.selectTicketFromFermat SET priority = 5 WHERE name = 'myCergyTicket';

Exec glpiAdmin_cergy.close_ticket_cergy(601);
Exec glpiAdmin_cergy.reopen_ticket_cergy(601);


COMMIT;