GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_treated_tickets TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_notifications TO simple_user_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_tickets TO simple_user_role;
GRANT SELECT, UPDATE ON glpi_entities TO simple_user_role;
GRANT SELECT, UPDATE ON glpi_users TO simple_user_role;

GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_treated_tickets TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_notifications TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_entities TO technician_role;
GRANT INSERT, DELETE, SELECT, UPDATE ON glpi_tickets TO technician_role;
GRANT SELECT, UPDATE ON glpi_users TO technician_role;
GRANT SELECT, UPDATE ON glpi_admin TO technician_role;

COMMIT;