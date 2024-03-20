import cx_Oracle

dsn = cx_Oracle.makedsn(host='Student-laptop', port=1521, service_name='XE')

# Connexion à la base de données Oracle
connection = cx_Oracle.connect(user='glpiAdmin', password='glpiAdmin', dsn=dsn)

sql_script = """
DROP TABLE glpi_treated_tickets;
DROP TABLE glpi_notifications;
DROP TABLE glpi_tickets;
DROP TABLE glpi_admin;
DROP TABLE glpi_users;
DROP TABLE glpi_entities;
"""

'''
CREATE TABLE glpi_users (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    email VARCHAR(255) NOT NULL UNIQUE, -- Adresse email de l'utilisateur
    name VARCHAR(255) NOT NULL, -- Nom de l'utilisateur
    first_name VARCHAR(255) NOT NULL, -- Prénom de l'utilisateur
    password VARCHAR(255) NOT NULL -- Mot de passe de l'utilisateur
);

CREATE TABLE glpi_entities (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    name VARCHAR(255) NOT NULL, -- Nom de l'entité
    location VARCHAR(255) NOT NULL -- Emplacement de l'entité
);

CREATE TABLE glpi_tickets (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    entites_id NUMBER(10) NOT NULL, -- Clé étrangère vers glpi_entities
    name VARCHAR(255) NOT NULL, -- Nom du ticket
    creation_date TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL, -- Date de création du ticket
    user_id_last_updater NUMBER(10), -- ID de l'utilisateur ayant mis à jour le ticket
    status NUMBER(1) NOT NULL CHECK (status IN (0, 1)),
    location VARCHAR(255) NOT NULL, -- Emplacement du ticket
    items_id NUMBER(10) NOT NULL, -- ID de l'élément associé au ticket (PC, Logiciel, etc)
    CONSTRAINT fk_tickets_entities FOREIGN KEY (entites_id) REFERENCES glpi_entities(id) -- Contrainte de clé étrangère vers glpi_entities
);

CREATE TABLE glpi_treated_tickets (
    id NUMBER(10), -- Clé primaire de la table
    ticket_id NUMBER(10) NOT NULL, -- ID du ticket associé
    entites_id NUMBER(10) NOT NULL, -- Clé étrangère vers glpi_entities
    name VARCHAR(255) NOT NULL, -- Nom du ticket traité
    creation_date TIMESTAMP NOT NULL, -- Date de création du ticket traité
    closedDate TIMESTAMP NOT NULL, -- Date de fermeture du ticket
    solvedStatus NUMBER(1) NOT NULL CHECK (solvedStatus IN (0, 1)), -- Si le ticket a été fermé résolu ou non-résolu
    location VARCHAR(255) NOT NULL, -- Emplacement du ticket traité
    items_id NUMBER(10) NOT NULL, -- ID de l'élément associé au ticket (PC, Logiciel, etc) traité
    CONSTRAINT pk_treated_tickets PRIMARY KEY (id, ticket_id), -- Clé primaire composée
    CONSTRAINT fk_treated_tickets_entities FOREIGN KEY (entites_id) REFERENCES glpi_entities(id) -- Contrainte de clé étrangère vers glpi_entities
);

CREATE TABLE glpi_admin (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    user_id NUMBER(10) NOT NULL, -- Clé étrangère vers glpi_users
    location VARCHAR(255) NOT NULL, -- Emplacement de l'administrateur
    CONSTRAINT fk_admin_users FOREIGN KEY (user_id) REFERENCES glpi_users(id) -- Contrainte de clé étrangère vers glpi_users
);

CREATE TABLE glpi_notifications (
    id NUMBER(10) PRIMARY KEY, -- Clé primaire de la table
    user_id_1 NUMBER(10) NOT NULL, -- ID de l'utilisateur 1
    user_id_2 NUMBER(10) NOT NULL, -- ID de l'utilisateur 2
    tickets_id NUMBER(10) NOT NULL, -- ID du ticket associé à la notification
    CONSTRAINT fk_notifications_user1 FOREIGN KEY (user_id_1) REFERENCES glpi_users(id), -- Contrainte de clé étrangère vers glpi_users pour user_id_1
    CONSTRAINT fk_notifications_user2 FOREIGN KEY (user_id_2) REFERENCES glpi_users(id), -- Contrainte de clé étrangère vers glpi_users pour user_id_2
    CONSTRAINT fk_notifications_tickets FOREIGN KEY (tickets_id) REFERENCES glpi_tickets(id) -- Contrainte de clé étrangère vers glpi_tickets pour tickets_id
);

"""
'''
try:
    # Exécution du script SQL dans une transaction
    cursor = connection.cursor()
    cursor.execute(sql_script)
    connection.commit()  # Valider la transaction
    cursor.close()
    print("Les instructions SQL ont été exécutées avec succès.")

except cx_Oracle.DatabaseError as e:
    error, = e.args
    print("Une erreur s'est produite:")
    print("Erreur Oracle:", error.message)

except Exception as e:
    print(f"Une erreur s'est produite : {str(e)}")

finally:
    # Fermeture de la connexion à la base de données
    if connection:
        connection.close()