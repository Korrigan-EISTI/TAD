DROP DATABASE LINK link_glpiAdmin_glpiAdmin_cergy;
DROP DATABASE LINK link_glpiAdmin_glpiAdmin_pau;

CREATE DATABASE LINK link_glpiAdmin_glpiAdmin_cergy CONNECT TO glpiAdmin_cergy IDENTIFIED BY cergy USING 'remote_cergy_tns_entry';
CREATE DATABASE LINK link_glpiAdmin_glpiAdmin_pau CONNECT TO glpiAdmin_pau IDENTIFIED BY pau USING 'remote_pau_tns_entry';

CREATE OR REPLACE VIEW selectAllTickets AS SELECT * FROM glpi_tickets@link_glpiAdmin_glpiAdmin_cergy UNION SELECT * FROM glpi_tickets@link_glpiAdmin_glpiAdmin_pau;
CREATE OR REPLACE VIEW selectAllClosedTickets AS SELECT * FROM glpi_treated_tickets@link_glpiAdmin_glpiAdmin_cergy UNION SELECT * FROM glpi_treated_tickets@link_glpiAdmin_glpiAdmin_pau;
CREATE OR REPLACE VIEW selectAllUsers AS SELECT * FROM glpi_users@link_glpiAdmin_glpiAdmin_cergy UNION SELECT * FROM glpi_users@link_glpiAdmin_glpiAdmin_pau;

COMMIT;