CREATE OR REPLACE VIEW selectTicketFromFermat AS 
SELECT * FROM glpi_tickets WHERE location = 'Fermat';

CREATE OR REPLACE VIEW selectTicketFromCondorcet AS 
SELECT * FROM glpi_tickets WHERE location = 'Condorcet';

CREATE OR REPLACE VIEW selectTicketFromTuring AS 
SELECT * FROM glpi_tickets WHERE location = 'Turing';

CREATE OR REPLACE VIEW selectTicketFromCauchy AS 
SELECT * FROM glpi_tickets WHERE location = 'Cauchy';

CREATE OR REPLACE VIEW selectTicketFromMartin AS 
SELECT * FROM glpi_tickets WHERE location = 'Saint Martin';

CREATE OR REPLACE VIEW selectTicketFromGermain AS
SELECT * FROM glpi_tickets WHERE location = 'Saint Germain';

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