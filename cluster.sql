-- Création d'un cluster sur la colonne location de la table glpi_tickets
-- Les clusters regroupent physiquement les lignes de données en fonction des valeurs des colonnes de regroupement spécifiées
CREATE CLUSTER clst_glpi_tickets_location (location) 
    SINGLE TABLESPACE admin 
    SIZE 1024M
    HASHKEYS 100;

COMMIT;