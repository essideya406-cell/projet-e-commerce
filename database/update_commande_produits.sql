
USE ecommerce;

DROP TABLE IF EXISTS commande_produits;

CREATE TABLE commande_produits (
    id_commande_produit INT AUTO_INCREMENT PRIMARY KEY,
    id_commande   INT NOT NULL,
    nom_produit   VARCHAR(150) NOT NULL,
    prix          DECIMAL(10,2) NOT NULL,
    image         VARCHAR(255),
    quantite      INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande)
        ON DELETE CASCADE
);
