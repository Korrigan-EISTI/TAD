-- Création d'un cluster sur la colonne location de la table glpi_tickets
-- Les clusters regroupent physiquement les lignes de données en fonction des valeurs des colonnes de regroupement spécifiées
DROP CLUSTER clst_glpi_tickets_location;

CREATE CLUSTER clst_glpi_tickets_location
(
    location VARCHAR(255)
)
SIZE 1024
HASHKEYS 100;

COMMIT;