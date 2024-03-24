DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Pau');
    END LOOP;
    COMMIT;
END;
/

DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Fermat');
    END LOOP;
    COMMIT;
END;
/

DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Condorcet');
    END LOOP;
    COMMIT;
END;
/

DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Turing');
    END LOOP;
    COMMIT;
END;
/

DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Cauchy');
    END LOOP;
    COMMIT;
END;
/

DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Saint Martin');
    END LOOP;
    COMMIT;
END;
/

DECLARE
    v_name VARCHAR2(255);
BEGIN
    FOR i IN 1..100 LOOP
        v_name := 'PC' || i;

        INSERT INTO glpi_entities (name, location)
        VALUES (v_name, 'Saint Germain');
    END LOOP;
    COMMIT;
END;
/

COMMIT;