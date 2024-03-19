CREATE SEQUENCE glpi_entities_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_tickets_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_treated_tickets_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_users_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_admin_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE glpi_notifications_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER glpi_entities_trigger
BEFORE INSERT ON glpi_entities
FOR EACH ROW
BEGIN
    SELECT glpi_entities_seq.NEXTVAL INTO :NEW.id FROM dual;
END;

CREATE OR REPLACE TRIGGER glpi_tickets_trigger
BEFORE INSERT ON glpi_tickets
FOR EACH ROW
BEGIN
    SELECT glpi_tickets_seq.NEXTVAL INTO :NEW.id FROM dual;
END;

CREATE OR REPLACE TRIGGER glpi_treated_tickets_trigger
BEFORE INSERT ON glpi_treated_tickets
FOR EACH ROW
BEGIN
    SELECT glpi_treated_tickets_seq.NEXTVAL INTO :NEW.id FROM dual;
END;

CREATE OR REPLACE TRIGGER glpi_users_trigger
BEFORE INSERT ON glpi_users
FOR EACH ROW
BEGIN
    SELECT glpi_users_seq.NEXTVAL INTO :NEW.id FROM dual;
END;

CREATE OR REPLACE TRIGGER glpi_admin_trigger
BEFORE INSERT ON glpi_admin
FOR EACH ROW
BEGIN
    SELECT glpi_admin_seq.NEXTVAL INTO :NEW.id FROM dual;
END;

CREATE OR REPLACE TRIGGER glpi_notifications_trigger
BEFORE INSERT ON glpi_notifications
FOR EACH ROW
BEGIN
    SELECT glpi_notifications_seq.NEXTVAL INTO :NEW.id FROM dual;
END;

COMMIT;