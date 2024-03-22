DROP SEQUENCE glpi_entities_seq;
DROP SEQUENCE glpi_tickets_seq;
DROP SEQUENCE glpi_treated_tickets_seq;
DROP SEQUENCE glpi_users_seq;
DROP SEQUENCE glpi_admin_seq;
DROP SEQUENCE glpi_notifications_seq;

CREATE SEQUENCE glpi_entities_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_tickets_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_treated_tickets_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_users_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_admin_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_notifications_seq START WITH 1 INCREMENT BY 1;