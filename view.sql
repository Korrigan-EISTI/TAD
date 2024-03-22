DROP DATABASE LINK link_glpiAdmin_glpiAdmin_cergy;
DROP DATABASE LINK link_glpiAdmin_glpiAdmin_pau;

CREATE DATABASE LINK link_glpiAdmin_glpiAdmin_cergy CONNECT TO glpiAdmin_cergy IDENTIFIED BY cergy USING '127.0.0.1:1521';
CREATE DATABASE LINK link_glpiAdmin_glpiAdmin_pau CONNECT TO glpiAdmin_pau IDENTIFIED BY pau USING '127.0.0.1:1521';

CREATE OR REPLACE VIEW selectAllTickets AS SELECT * FROM glpi_tickets@link_glpiAdmin_glpiAdmin_cergy UNION SELECT * FROM glpi_tickets@link_glpiAdmin_glpiAdmin_pau;
CREATE OR REPLACE VIEW selectAllClosedTickets AS SELECT * FROM glpi_treated_tickets@link_glpiAdmin_glpiAdmin_cergy UNION SELECT * FROM glpi_treated_tickets@link_glpiAdmin_glpiAdmin_pau;
CREATE OR REPLACE VIEW selectAllUsers AS SELECT * FROM glpi_users@link_glpiAdmin_glpiAdmin_cergy UNION SELECT * FROM glpi_users@link_glpiAdmin_glpiAdmin_pau;

COMMIT;