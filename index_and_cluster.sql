-- Création d'index
CREATE INDEX idx_glpi_tickets_location ON glpi_tickets(location);
CREATE INDEX idx_glpi_tickets_category_id ON glpi_tickets(glpi_tickets_category_id);

-- Création d'un cluster
CREATE CLUSTER clst_glpi_tickets_location (location) 
    SINGLE TABLESPACE users 
    SIZE 1024M
    HASHKEYS 100;
