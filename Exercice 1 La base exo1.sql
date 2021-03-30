-- Evaluation base de données

-- Exercice 1 - La base exo1

-- -Créez le script d'implémentation des différentes tabLes sous MySQl

CREATE TABLE Client (
    cli_num int NOT NULL,
    cli_nom varchar(50) NOT NULL,
    cli_adresse varchar(50) NOT NULL,
    cli_tel varchar(30) NOT NULL
    ,CONSTRAINT Client_PK PRIMARY KEY (cli_num)
);
CREATE TABLE Commande (
    com_num int NOT NULL,
    cli_num int NOT NULL,
    com_date datetime NOT NULL,
    com_obs varchar(50) NOT NULL
    ,CONSTRAINT Commande_PK PRIMARY KEY (com_num)
    ,CONSTRAINT Commande_Client_FK FOREIGN KEY (cli_num) REFERENCES Client(cli_num)
);
CREATE TABLE Produit (
    pro_num int NOT NULL,
    pro_libelle varchar(50) NOT NULL,
    pro_description varchar(50) NOT NULL
    ,CONSTRAINT Produit_PK PRIMARY KEY (pro_num)
);
CREATE TABLE est_compose (
    com_num int NOT NULL,
    pro_num int NOT NULL,
    est_qte int NOT NULL
    ,CONSTRAINT est_compose_PK PRIMARY KEY (com_num, pro_num)
    ,CONSTRAINT est_compose_Commande_FK FOREIGN KEY (com_num) REFERENCES Commande(com_num)
    ,CONSTRAINT est_compose_Produit_FK FOREIGN KEY (pro_num) REFERENCES Produit(pro_num)
);

-- Créez un index sur le champ cli_nom de la table client

CREATE index_nomclient INDEX ON Client(cli_nom);
SHOW INDEX from Client