-- Activer le mode script Oracle pour permettre la création d'objets de base de données
alter session set "_ORACLE_SCRIPT"=true;

-- Supprimer l'utilisateur glpiAdmin et tous ses objets associés
DROP USER glpiAdmin_cergy CASCADE;
DROP USER glpiAdmin_pau CASCADE;
DROP USER glpiAdmin CASCADE;

-- Supprimer l'espace de table admin et tous ses objets, y compris les fichiers de données
DROP TABLESPACE cergyAdmin INCLUDING CONTENTS AND DATAFILES;
-- Supprimer l'espace de table admin et tous ses objets, y compris les fichiers de données
DROP TABLESPACE pauAdmin INCLUDING CONTENTS AND DATAFILES;
