

-- 1) Creation de la base de donnees
CREATE DATABASE IF NOT EXISTS ecommerce
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ecommerce;

-- On supprime les tables si elles existent deja (pour pouvoir relancer le script)
DROP TABLE IF EXISTS commande_produits;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS sous_categories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS utilisateurs;



CREATE TABLE utilisateurs (
    id_utilisateur   INT AUTO_INCREMENT PRIMARY KEY,
    nom              VARCHAR(50)  NOT NULL,
    prenom           VARCHAR(50)  NOT NULL,
    email            VARCHAR(100) NOT NULL UNIQUE,
    telephone        VARCHAR(8)   NOT NULL,
    mot_de_passe     VARCHAR(255) NOT NULL,
    date_inscription DATETIME DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE categories (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(50) NOT NULL
);



CREATE TABLE sous_categories (
    id_sous_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_sous_categorie VARCHAR(50) NOT NULL,
    id_categorie INT NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie)
        ON DELETE CASCADE
);



CREATE TABLE produits (
    id_produit INT AUTO_INCREMENT PRIMARY KEY,
    nom_produit VARCHAR(150) NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    image VARCHAR(255),
    id_sous_categorie INT NOT NULL,
    FOREIGN KEY (id_sous_categorie) REFERENCES sous_categories(id_sous_categorie)
        ON DELETE CASCADE
);



CREATE TABLE commandes (
    id_commande INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telephone VARCHAR(8) NOT NULL,
    localisation VARCHAR(150) NOT NULL,
    date_commande DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
        ON DELETE SET NULL
);



CREATE TABLE commande_produits (
    id_commande_produit INT AUTO_INCREMENT PRIMARY KEY,
    id_commande INT NOT NULL,
    nom_produit VARCHAR(150) NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    image VARCHAR(255),
    quantite INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande)
        ON DELETE CASCADE
);



INSERT INTO categories (id_categorie, nom_categorie) VALUES
(1, 'Vetements'),
(2, 'Gaming'),
(3, 'Maison'),
(4, 'Telephones & Accessoires');



INSERT INTO sous_categories (id_sous_categorie, nom_sous_categorie, id_categorie) VALUES
(1,  'Homme',             1),
(2,  'Femme',             1),
(3,  'Enfant',            1),
(4,  'Chaussures',        1),
(5,  'PC',                2),
(6,  'Consoles',          2),
(7,  'Audio & Casques',   2),
(8,  'Salon',             3),
(9,  'Cuisine',           3),
(10, 'Decoration',        3),
(11, 'Smartphones',       4),
(12, 'Montres Connectees',4),
(13, 'Accessoires',       4);


INSERT INTO produits (nom_produit, prix, image, id_sous_categorie) VALUES
('pantalon', 19.99, './images/pant.jpg', 1),
('chemise', 14.99, './images/chemise.webp', 1),
('veste', 49.99, './images/jacket.jpg', 1),
('set homme', 60, './images/sethomme .jpg', 1),
('pantalon a pince', 85, './images/pantalonh.jpg', 1),
('short', 40, './images/short.jpg', 1),
('set djean', 140, './images/setdjeanh.jpg', 1),
('set plage', 95, './images/setplage.jpg', 1),
('pull', 35, './images/pull.jpg', 1),
('veste', 120, './images/doudoun.jpg', 1),
('costume chic', 200, './images/costume.jpg', 1),
('pull', 30, './images/pullh.jpg', 1),
('Robe long', 109.99, './images/robe.webp', 2),
('set djeans', 100, './images/setdjeans.jpg', 2),
('robe blanc', 90.99, './images/téléchargement.webp', 2),
('Robe rose', 50.99, './images/roberose.jpg', 2),
('Robe satin', 150.99, './images/robesatin.webp', 2),
('robe chic', 80, './images/robelong.jpg', 2),
('jupe blanc', 90, './images/jupe.webp', 2),
('jupe vert', 50.50, './images/jupevert.jpg', 2),
('pull hivers', 70.50, './images/pullhivers.jpg', 2),
('pull ete', 60.50, './images/pullete.jpg', 2),
('pantalons a pince', 100, './images/pantalonapince.jpg', 2),
('pantalonlarge', 90.50, './images/pantalonlarge.jpg', 2),
('cachecolfemme', 20.50, './images/cachecolfemme.jpg', 2),
('pantalon', 30.50, './images/pantalonf.jpg', 2),
('burkinni', 60, './images/burkini.jpg', 2),
('ensemble fille', 60.50, './images/ensemblef.jpg', 3),
('robe fille', 30.50, './images/Vestido Amarelo Floral Com Alças Finas Para Meninas Jovens.jpg', 3),
('jupe fille', 40, './images/jupeenf.jpg', 3),
('pantalon large fille', 20, './images/pantalonlargeenf.jpg', 3),
('set djeans', 80, './images/setdjeans.jpg', 3),
('ensemble garcon', 50.99, './images/ensemblegarcon.jpg', 3),
('tenue garcon blanc', 60.99, './images/setblac2pc.jpg', 3),
('pantalon a pince', 30, './images/pantalonapincegarcon.jpg', 3),
('set bebe', 20, './images/setbebe.jpg', 3),
('robe bebe', 40, './images/robebebe.jpg', 3),
('robe bebe hivers', 50, './images/robebebeete.jpg', 3),
('set bebe garcon', 30, './images/setbebegarcon.jpg', 3),
('ensemble fille et garcon', 100, './images/ensemblefetg.jpg', 3),
('botillons bebe', 10, './images/botillonbebe.jpg', 3),
('chaussures de course', 29.99, './images/runningshoes.jpg', 4),
('blanc chaussures', 64.99, './images/whaite shoes.jpg', 4),
('chaussures marron', 49.99, './images/ssss.jpg', 4),
('air force blanc', 110, './images/airforce.jpg', 4),
('puma rouge', 80, './images/puma.jpg', 4),
('tallon chic', 250, './images/tallonred.jpg', 4),
('tallon chic', 80, './images/sandales.jpg', 4),
('claquette', 75, './images/claquetteh.jpg', 4),
('chaussures bebe', 45, './images/chf.jpg', 4),
('PC MSI Thin 15 B13UDX RTX3050', 1349.99, './images/gaming/msi-pc-gaming.jpg', 5),
('PC ASUS TUF Gaming A15 RTX2050', 999.99, './images/gaming/pc asus tuf .jpg', 5),
('PC LENOVO LOQ 15IAX9 RTX3050', 1279.99, './images/gaming/pc gaming loq.jpg', 5),
('PC ASUS Vivobook 16X RTX3050', 1549.99, './images/gaming/pc asus vivobook.jpg', 5),
('PC HP Victus 15 RYZEN 5 RTX2050', 1129.99, './images/gaming/pc gaming victus.jpg', 5),
('PC Gigabyte AERO X16 RTX5070', 2849.99, './images/gaming/pc gigabite AERO.jpg', 5),
('PC Dell Alienware 16 RTX3050', 1649.99, './images/gaming/pc gaming dell.jpg', 5),
('PC Lenovo LOQ 15ARP10E RTX3050', 1899.99, './images/gaming/pc loq 2.jpg', 5),
('PC Gigabyte G6KF RTX4060', 2049.99, './images/gaming/pc gaming gigabite.jpg', 5),
('PC Lenovo Legion 5 RTX5050', 2699.99, './images/gaming/pc legion .jpg', 5),
('PC Gigabyte GAMING A16 RTX5050', 2399.99, './images/gaming/pc gigabite 2.jpg', 5),
('PC Dell Alienware 16X RTX5070', 3049.99, './images/gaming/pc dell alianware.jpg', 5),
('PS5 Slim', 649.99, './images/ps5.jpg', 6),
('Nintendo Switch 1', 399.99, './images/switch1.jpg', 6),
('PS4 Slim', 379.99, './images/ps4.jpg', 6),
('XBOX ONE', 449.99, './images/xbox 1.jfif', 6),
('XBOX SERIES X', 549.99, './images/xbox serie x.jfif', 6),
('PS4 PRO', 529.99, './images/ps4 pro.avif', 6),
('PS5 PRO', 899.99, './images/console-ps5-pro.jpg', 6),
('Switch 2', 599.99, './images/switch 2.jpg', 6),
('Nintendo 3DS XL', 199.99, './images/nintendo 3DS XL.jpg', 6),
('Nintendo Switch Lite', 199.99, './images/switch lite .jpg', 6),
('XBOX SERIES S', 449.99, './images/xbox series s.jpg', 6),
('Steam Deck', 749.99, './images/steam-deck.jpg', 6),
('Écouteurs XIAOMI Redmi Buds 6', 29.99, './images/gaming/ecouteurs sans files xiaomi.jpg', 7),
('Casque Havit HV-H2232D RGB', 49.99, './images/gaming/casque havit .jpg', 7),
('Casque Alastor T-DAGGER USB', 59.99, './images/gaming/casque gamer alastor.jpg', 7),
('Casque Baracuda BGH-011 PEARL RGB', 69.99, './images/gaming/casque baracuda.jpg', 7),
('Casque Gamer T-Wolf RGB', 54.99, './images/gaming/casque gamer t-wolf.jpg', 7),
('Écouteurs Hama', 39.99, './images/gaming/ecouteurs Hama.jpg', 7),
('Casque Redragon Hylas H260 RGB', 64.99, './images/gaming/casque redragon.jpg', 7),
('Casque Gamer Havic RGB', 79.99, './images/gaming/casque gamer havic.jpg', 7),
('Casque White Shark PEACOCK RGB', 79.99, './images/gaming/casque white shark.jpg', 7),
('Casque MEETION MT-HP099', 99.99, './images/gaming/casque meetion.jpg', 7),
('Casque AQIRYS ALTAIR', 109.99, './images/gaming/casque AQIRYS.jpg', 7),
('Écouteurs Redmi Buds 6 / Blanc', 149.99, './images/gaming/ecouteurs redmi.jpg', 7),
('Canapé Moderne 3 Places', 499.99, './images/maison/canape moderne.jpg', 8),
('Table Basse en Bois', 149.99, './images/maison/table basse bois.jpg', 8),
('Meuble TV Moderne', 299.99, './images/maison/meuble tv moderne.jpg', 8),
('Fauteuil Confort', 229.99, './images/maison/fauteuil confort.jpg', 8),
('Tapis Salon Gris', 89.99, './images/maison/tapis salon gris.jpg', 8),
('Lampadaire Design', 79.99, './images/maison/lampadaire design.jpg', 8),
('Bibliothèque Moderne', 189.99, './images/maison/bibliotheque moderne.jpg', 8),
('Étagère Murale', 49.99, './images/maison/etagere murale.jpg', 8),
('Pouf Rond Salon', 59.99, './images/maison/pouf rond.jpg', 8),
('Rideaux Salon', 69.99, './images/maison/rideaux salon.jpg', 8),
('Coussin Décoratif', 19.99, './images/maison/coussin decoratif.jpg', 8),
('Table d’Appoint', 99.99, './images/maison/table appoint.jpg', 8),
('Réfrigérateur Samsung', 899.99, './images/maison/refrigerateur samsung.jpg', 9),
('Four Encastrable Bosch', 499.99, './images/maison/four bosch.jpg', 9),
('Micro-ondes LG', 149.99, './images/maison/micro onde lg.jpg', 9),
('Machine à Café Delonghi', 299.99, './images/maison/machine cafe delonghi.jpg', 9),
('Blender Philips', 89.99, './images/maison/blender philips.jpg', 9),
('Grille-Pain Tefal', 49.99, './images/maison/grille pain tefal.jpg', 9),
('Bouilloire Électrique', 39.99, './images/maison/bouilloire.jpg', 9),
('Robot Cuisine Moulinex', 349.99, './images/maison/robot cuisine.jpg', 9),
('Friteuse Air Fryer', 129.99, './images/maison/air fryer.jpg', 9),
('Mixeur Plongeant', 59.99, './images/maison/mixeur plongeant.jpg', 9),
('Set Casseroles Inox', 99.99, './images/maison/casseroles inox.jpg', 9),
('Plaque Induction', 279.99, './images/maison/plaque induction.jpg', 9),
('Miroir Rond Design', 89.99, './images/maison/miroir rond.jpg', 10),
('Horloge Murale Moderne', 49.99, './images/maison/horloge murale.jpg', 10),
('Vase Décoratif', 39.99, './images/maison/vase decoratif.jpg', 10),
('Cadre Photo Élégant', 29.99, './images/maison/cadre photo.jpg', 10),
('Plante Artificielle', 24.99, './images/maison/plante artificielle.jpg', 10),
('Lampe de Table Moderne', 69.99, './images/maison/lampe table.jpg', 10),
('Guirlande LED Décorative', 19.99, './images/maison/guirlande led.jpg', 10),
('Statue Moderne', 79.99, './images/maison/statue moderne.jpg', 10),
('Lot de Bougies Parfumées', 34.99, './images/maison/bougies parfumees.jpg', 10),
('Panneau Décoratif Mural', 59.99, './images/maison/panneau mural.jpg', 10),
('Lampe Murale', 24.99, './images/maison/lampe murale.jpg', 10),
('Fontaine Intérieure Zen', 99.99, './images/maison/fontaine zen.jpg', 10),
('iphone 17 256GB', 799.99, './images/teleEtAcces/iphone 17.jfif', 11),
('Samsung Galaxy S25 256GB', 699.99, './images/teleEtAcces/samsung Galaxy S25.jpg', 11),
('iphone 17 PRO MAX 256GB', 1179.99, './images/teleEtAcces/iphone 17 pro max .jfif', 11),
('Nothing Phone 1 256GB', 449.99, './images/teleEtAcces/nothing phone 1.jpg', 11),
('Samsung A17 5G 128GB', 249.99, './images/teleEtAcces/samsung A17 5G.jpg', 11),
('samsung Galaxy S26 Ultra 5G 512GB', 1349.99, './images/teleEtAcces/samsung Galaxy S26 Ultra .jpg', 11),
('Google Pixel 7 126GB', 899.99, './images/teleEtAcces/google pixel 9.jfif', 11),
('iphone 15 126GB', 599.99, './images/teleEtAcces/iphone 15.jfif', 11),
('Xiaomi Redmi 15', 199.99, './images/teleEtAcces/Redmi 15.webp', 11),
('Samsung A56 256GB', 419.99, './images/teleEtAcces/samsung A56.jfif', 11),
('Google Pixel 10 PRO XL', 1249.99, './images/teleEtAcces/pixel 10 pro XL.jfif', 11),
('iphone air 256GB', 849.99, './images/teleEtAcces/iphone air.jfif', 11),
('Apple Watch Series 10', 499.99, './images/teleEtAcces/apple watch series 10.jpg', 12),
('Samsung Galaxy Watch 7', 349.99, './images/teleEtAcces/samsung galaxy watch 7.jpg', 12),
('Samsung Galaxy Watch Ultra', 599.99, './images/teleEtAcces/samsung galaxy watch ultra.jpg', 12),
('Xiaomi Watch S4', 199.99, './images/teleEtAcces/xiaomi watch s4.jpg', 12),
('Huawei Watch Fit 4', 179.99, './images/teleEtAcces/huawei watch fit 4.jpg', 12),
('Huawei Watch GT 5', 299.99, './images/teleEtAcces/huawei watch gt 5.jpg', 12),
('Garmin Venu 3', 449.99, './images/teleEtAcces/garmin venu 3.jpg', 12),
('Amazfit Balance', 229.99, './images/teleEtAcces/amazfit balance.jpg', 12),
('Redmi Watch 5', 99.99, './images/teleEtAcces/redmi watch 5.jpg', 12),
('OnePlus Watch 3', 279.99, './images/teleEtAcces/oneplus watch 3.png', 12),
('Google Pixel Watch 3', 399.99, './images/teleEtAcces/google pixel watch 3.jpg', 12),
('Honor Watch 5', 149.99, './images/teleEtAcces/honor watch 5.jpg', 12),
('Power Bank Anker 20000mAh', 79.99, './images/teleEtAcces/anker powerbank.jpg', 13),
('Chargeur USB-C 65W', 39.99, './images/teleEtAcces/chargeur usbc.jpg', 13),
('Coque iPhone 17', 24.99, './images/teleEtAcces/coque iphone.jpg', 13),
('Coque Samsung S25', 24.99, './images/teleEtAcces/coque samsung.jpg', 13),
('Clavier Bluetooth Logitech', 89.99, './images/teleEtAcces/clavier bluetooth.jpg', 13),
('Souris Logitech MX Master 3', 99.99, './images/teleEtAcces/logitech mx master 3.jpg', 13),
('Trépied Smartphone', 29.99, './images/teleEtAcces/tripod smartphone.jpg', 13),
('Support Téléphone Voiture', 19.99, './images/teleEtAcces/support voiture.jpg', 13),
('Batterie MagSafe Apple', 89.99, './images/teleEtAcces/batterie magsafe.jpg', 13),
('Station Charge Sans Fil 3-en-1', 69.99, './images/teleEtAcces/station charge sans fil.jpg', 13),
('Tapis Souris XXL Legion', 29.99, './images/teleEtAcces/tapis souris lzgion.jpg', 13),
('SSD Externe Samsung T9 1To', 129.99, './images/teleEtAcces/ssd samsung t9.jpg', 13);



INSERT INTO utilisateurs (nom, prenom, email, telephone, mot_de_passe) VALUES
('Ben Salah', 'Eya',   'eya.bensalah@example.com',   '20123456', 'motdepasse123'),
('Trabelsi',  'Ahmed', 'ahmed.trabelsi@example.com', '21987654', 'azerty123');



INSERT INTO commandes (id_utilisateur, nom, prenom, email, telephone, localisation, total) VALUES
(1,    'Ben Salah', 'Eya',   'eya.bensalah@example.com', '20123456', 'Tunis, Tunisie',  129.98),
(NULL, 'Karray',    'Sami',  'sami.karray@example.com',  '22334455', 'Sfax, Tunisie',    49.99);

-- Commande 1 : 1x "pantalon" + 1x "Robe long"
INSERT INTO commande_produits (id_commande, nom_produit, prix, image, quantite) VALUES
(1, 'pantalon',  19.99,  './images/pant.jpg', 1),
(1, 'Robe long', 109.99, './images/robe.webp', 1);

-- Commande 2 : 1x "veste"
INSERT INTO commande_produits (id_commande, nom_produit, prix, image, quantite) VALUES
(2, 'veste', 49.99, './images/jacket.jpg', 1);
