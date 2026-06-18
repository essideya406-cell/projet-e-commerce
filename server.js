const express = require("express");
const cors    = require("cors");
const path    = require("path");
const db      = require("./db");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.static("public"));

// ─── LOG TOUTES LES REQUETES ENTRANTES ──────────────────────────────────────
app.use((req, res, next) => {
    console.log("─────────────────────────────────────────");
    console.log(`[REQUETE] ${req.method} ${req.url}`);
    console.log(`[BODY]    `, req.body);
    next();
});

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "public", "index.html"));
});


// ─── INSCRIPTION ────────────────────────────────────────────────────────────
app.post("/api/inscription", async (req, res) => {
    console.log("[INSCRIPTION] Données reçues :", req.body);

    const { nom, prenom, email, telephone, mot_de_passe } = req.body;

    // Vérification champ par champ pour voir lequel manque
    console.log("[INSCRIPTION] nom        :", nom);
    console.log("[INSCRIPTION] prenom     :", prenom);
    console.log("[INSCRIPTION] email      :", email);
    console.log("[INSCRIPTION] telephone  :", telephone);
    console.log("[INSCRIPTION] mot_de_passe fourni :", mot_de_passe ? "OUI" : "NON");

    if (!nom || !prenom || !email || !telephone || !mot_de_passe) {
        const manquants = [];
        if (!nom)          manquants.push("nom");
        if (!prenom)       manquants.push("prenom");
        if (!email)        manquants.push("email");
        if (!telephone)    manquants.push("telephone");
        if (!mot_de_passe) manquants.push("mot_de_passe");
        console.error("[INSCRIPTION] ERREUR - Champs manquants :", manquants);
        return res.status(400).json({ success: false, message: "Champs manquants : " + manquants.join(", ") });
    }

    try {
        console.log("[INSCRIPTION] Connexion à la base de données...");

        const existant = await db.query(
            "SELECT id_utilisateur FROM utilisateurs WHERE email = ?",
            [email]
        );
        console.log("[INSCRIPTION] Résultat vérification email existant :", existant);

        if (existant.length > 0) {
            console.warn("[INSCRIPTION] Email déjà utilisé :", email);
            return res.status(409).json({ success: false, message: "Cet email est déjà utilisé" });
        }

        console.log("[INSCRIPTION] Insertion dans la table utilisateurs...");
        const result = await db.query(
            "INSERT INTO utilisateurs (nom, prenom, email, telephone, mot_de_passe) VALUES (?, ?, ?, ?, ?)",
            [nom, prenom, email, telephone, mot_de_passe]
        );
        console.log("[INSCRIPTION] INSERT réussi, insertId :", Number(result.insertId));

        res.json({ success: true, message: "Compte créé avec succès" });

    } catch (err) {
        console.error("[INSCRIPTION] ERREUR SQL / base de données :");
        console.error("  Message :", err.message);
        console.error("  Code    :", err.code);
        console.error("  SQL     :", err.sql);
        console.error("  Stack   :", err.stack);
        res.status(500).json({ success: false, message: "Erreur serveur : " + err.message });
    }
});


// ─── CONNEXION ───────────────────────────────────────────────────────────────
app.post("/api/connexion", async (req, res) => {
    console.log("[CONNEXION] Données reçues :", { email: req.body.email, mot_de_passe: req.body.mot_de_passe ? "****" : "NON" });

    const { email, mot_de_passe } = req.body;

    if (!email || !mot_de_passe) {
        console.error("[CONNEXION] ERREUR - Champs manquants");
        return res.status(400).json({ success: false, message: "Champs manquants" });
    }

    try {
        console.log("[CONNEXION] Recherche utilisateur pour :", email);
        const rows = await db.query(
            "SELECT id_utilisateur, nom, prenom, email, telephone FROM utilisateurs WHERE email = ? AND mot_de_passe = ?",
            [email, mot_de_passe]
        );
        console.log("[CONNEXION] Résultats trouvés :", rows.length);

        if (rows.length === 0) {
            console.warn("[CONNEXION] Email ou mot de passe incorrect pour :", email);
            return res.status(401).json({ success: false, message: "Email ou mot de passe incorrect" });
        }

        const utilisateur = {
            id:        Number(rows[0].id_utilisateur),
            nom:       rows[0].nom,
            prenom:    rows[0].prenom,
            email:     rows[0].email,
            telephone: rows[0].telephone
        };
        console.log("[CONNEXION] Succès pour :", utilisateur.email);
        res.json({ success: true, message: "Connexion réussie", utilisateur });

    } catch (err) {
        console.error("[CONNEXION] ERREUR SQL :");
        console.error("  Message :", err.message);
        console.error("  Code    :", err.code);
        console.error("  Stack   :", err.stack);
        res.status(500).json({ success: false, message: "Erreur serveur : " + err.message });
    }
});


// ─── COMMANDE ────────────────────────────────────────────────────────────────
app.post("/api/commande", async (req, res) => {
    console.log("[COMMANDE] Données reçues :", req.body);

    const { nom, prenom, email, telephone, localisation, produit } = req.body;

    if (!nom || !prenom || !email || !telephone || !localisation || !produit) {
        const manquants = [];
        if (!nom)          manquants.push("nom");
        if (!prenom)       manquants.push("prenom");
        if (!email)        manquants.push("email");
        if (!telephone)    manquants.push("telephone");
        if (!localisation) manquants.push("localisation");
        if (!produit)      manquants.push("produit");
        console.error("[COMMANDE] ERREUR - Champs manquants :", manquants);
        return res.status(400).json({ success: false, message: "Champs manquants : " + manquants.join(", ") });
    }

    const prix = parseFloat(produit.prix) || 0;
    console.log("[COMMANDE] Prix calculé :", prix);

    try {
        console.log("[COMMANDE] Insertion dans commandes...");
        const resultCommande = await db.query(
            `INSERT INTO commandes (nom, prenom, email, telephone, localisation, total)
             VALUES (?, ?, ?, ?, ?, ?)`,
            [nom, prenom, email, telephone, localisation, prix]
        );
        const idCommande = Number(resultCommande.insertId);
        console.log("[COMMANDE] Commande insérée, id_commande :", idCommande);

        console.log("[COMMANDE] Insertion dans commande_produits...");
        await db.query(
            `INSERT INTO commande_produits (id_commande, nom_produit, prix, quantite)
             VALUES (?, ?, ?, ?)`,
            [idCommande, produit.nom || "", prix, 1]
        );
        console.log("[COMMANDE] Produit inséré avec succès");

        res.json({ success: true, message: "Commande enregistrée", id_commande: idCommande });

    } catch (err) {
        console.error("[COMMANDE] ERREUR SQL / base de données :");
        console.error("  Message :", err.message);
        console.error("  Code    :", err.code);
        console.error("  SQL     :", err.sql);
        console.error("  Stack   :", err.stack);
        res.status(500).json({ success: false, message: "Erreur serveur : " + err.message });
    }
});


const PORT = 3000;
app.listen(PORT, () => {
    console.log("═══════════════════════════════════════════");
    console.log(`  Serveur lancé sur http://localhost:${PORT}`);
    console.log("═══════════════════════════════════════════");
});