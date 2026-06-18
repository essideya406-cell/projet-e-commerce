document.getElementById("nom").innerText=localStorage.getItem("nomproduit");
document.getElementById("prix").innerText=localStorage.getItem("prixproduit");


function retourner() {
    window.location.href="tout.html";
}
function verifier() {
    let nom = document.getElementById("nomp").value;
    let prenom = document.getElementById("prenom").value;
    let email = document.getElementById("email").value;
    let tel = document.getElementById("telephone").value;
    let loc = document.getElementById("localisation").value;
    

    if (nom == "") {
        alert("Nom obligatoire");
        return false;
    }
    for (let i = 0; i < nom.length; i++) {
        if ((nom[i] < 'A' || nom[i] > 'Z') &&
            (nom[i] < 'a' || nom[i] > 'z') &&
            nom[i] !== ' ') {
            alert("Nom invalide");
            return false;
        }
    }

    if (prenom == "") {
        alert("Prénom obligatoire");
        return false;
    }
    for (let i = 0; i < prenom.length; i++) {
        if ((prenom[i] < 'A' || prenom[i] > 'Z') &&
            (prenom[i] < 'a' || prenom[i] > 'z') &&
            prenom[i] !== ' ') {
            alert("Prénom invalide");
            return false;
        }
    }
    if ( email === "" || email.indexOf("@") <= 0 || email.indexOf("@") !== email.lastIndexOf("@") || email.indexOf(".") <= email.indexOf("@") + 1 || email.endsWith(".")) {
    alert("Email incorrect");
    return false;
}


    if (tel == "" || tel.length != 8 || isNaN(tel)) {
        alert("Téléphone incorrect");
        return false;
    }
    if (loc == "") {
        alert("Localisation obligatoire");
        return false;
    }

    return true;

}
function dd() {
    let d = new Date();
    let jour = d.getDate();
    let mois = d.getMonth() + 1;
    let annee = d.getFullYear();

    document.getElementById("date").value = jour + "/" + mois + "/" + annee;
}


function extraire() {
    var xhr;

    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else {
        alert("Navigateur non compatible");
        return;
    }

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            alert(xhr.responseText);
        }
    };

    xhr.open("GET", "commande.txt", true);
    xhr.send();
}
