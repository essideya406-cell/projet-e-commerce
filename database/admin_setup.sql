-- ═══════════════════════════════════════════════════════
--  MISE À JOUR BASE DE DONNÉES – Ajout compte Admin
--  À exécuter dans phpMyAdmin → onglet SQL
-- ═══════════════════════════════════════════════════════

-- 1. Ajouter la colonne "role" à la table utilisateurs
--    (si elle n'existe pas déjà)
ALTER TABLE utilisateurs 
ADD COLUMN IF NOT EXISTS role VARCHAR(20) NOT NULL DEFAULT 'client';

-- 2. Ajouter la colonne date_inscription si elle n'existe pas
ALTER TABLE utilisateurs 
ADD COLUMN IF NOT EXISTS date_inscription DATETIME DEFAULT CURRENT_TIMESTAMP;

-- 3. Ajouter la colonne date_commande à la table commandes si elle n'existe pas
ALTER TABLE commandes 
ADD COLUMN IF NOT EXISTS date_commande DATETIME DEFAULT CURRENT_TIMESTAMP;

-- 4. Créer le compte administrateur
--    Email    : admin@supermarket.com
--    Mot de passe : Admin1234
--    (changez ces valeurs selon vos préférences)
INSERT INTO utilisateurs (nom, prenom, email, telephone, mot_de_passe, role)
VALUES ('Admin', 'Super', 'admin@supermarket.com', '00000000', 'Admin1234', 'admin')
ON DUPLICATE KEY UPDATE role = 'admin';

-- ✅ Vérification : voir les comptes admin
SELECT id_utilisateur, nom, prenom, email, role FROM utilisateurs WHERE role = 'admin';
