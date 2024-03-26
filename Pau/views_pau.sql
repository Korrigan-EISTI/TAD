<<<<<<< HEAD
CREATE OR REPLACE VIEW selectTicketFromPau AS SELECT * FROM glpi_tickets WHERE location = 'Pau';

GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromPau TO technician_role;

=======
CREATE OR REPLACE VIEW selectTicketFromPau AS SELECT * FROM glpi_tickets;

GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromPau TO technician_role;
>>>>>>> 8cde769 (MELVYN !!!!!!!!!)
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromPau TO simple_user_role;

COMMIT;