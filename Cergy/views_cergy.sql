CREATE OR REPLACE VIEW selectTicketFromFermat AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'FERMAT';
CREATE OR REPLACE VIEW selectTicketFromCondorcet AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'CONDORCET';
CREATE OR REPLACE VIEW selectTicketFromTuring AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'TURING';
CREATE OR REPLACE VIEW selectTicketFromCauchy AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'CAUCHY';
CREATE OR REPLACE VIEW selectTicketFromMartin AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'SAINT MARTIN';
CREATE OR REPLACE VIEW selectTicketFromGermain AS SELECT * FROM glpi_tickets WHERE UPPER(location) = 'SAINT GERMAIN';

GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromFermat TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromCondorcet TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromCauchy TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromTuring TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromMartin TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromGermain TO technician_role;

GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromFermat TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromCondorcet TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromCauchy TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromTuring TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromMartin TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON selectTicketFromGermain TO simple_user_role;

COMMIT;