alter session set "_ORACLE_SCRIPT"=true;

CREATE TABLESPACE admin
    DATAFILE 'admin.dbf' SIZE 1024M
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;
    
CREATE ROLE technician_role;
CREATE ROLE simple_user_role;

-- Création des rôles supplémentaires pour les techniciens à Pau et à Cergy
CREATE ROLE pau_technician_role;
CREATE ROLE cergy_technician_role;


CREATE USER glpiAdmin IDENTIFIED BY glpiAdmin;

GRANT DBA TO glpiAdmin;

COMMIT;