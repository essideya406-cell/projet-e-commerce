
function commander(nom, prix, img) {
  localStorage.setItem("nomproduit",  nom);
  localStorage.setItem("prixproduit", prix);
  localStorage.setItem("imgproduit",  img || "");
  window.location.href = "commande.html";
}


function ajouterAuPanier(nom, prix, img) {
  try {
    var p = JSON.parse(localStorage.getItem("panier")) || [];
    var idx = p.findIndex(function(i){ return i.nom === nom; });
    if (idx >= 0) { p[idx].qte++; }
    else { p.push({ nom: nom, prix: parseFloat(prix), img: img || "", qte: 1 }); }
    localStorage.setItem("panier", JSON.stringify(p));
  } catch(e) {}

  if (window.parent && window.parent !== window) {
    window.parent.postMessage({
      type: "ajouterPanier",
      nom:  nom,
      prix: prix,
      img:  img || ""
    }, "*");
  }

  
  var btns = document.querySelectorAll('.btn-panier-active');
  btns.forEach(function(b) {
    if (b.dataset.nom === nom) {
      var orig = b.innerHTML;
      b.innerHTML = '<i class="ti ti-check"></i> Ajouté !';
      b.style.background = '#dcfce7';
      b.style.color = '#16a34a';
      b.style.borderColor = '#bbf7d0';
      setTimeout(function() {
        b.innerHTML = orig;
        b.style.background = '';
        b.style.color = '';
        b.style.borderColor = '';
      }, 1500);
    }
  });
}


function initBoutons() {
  var cartes = document.querySelectorAll('.pc[onclick]');
  cartes.forEach(function(carte) {
    
    var onclickStr = carte.getAttribute('onclick');
    
    var match = onclickStr.match(/commander\s*\(\s*'([^']*)'\s*,\s*'?([^',\)]*)'?\s*(?:,\s*'([^']*)')?\s*\)/);
    if (!match) return;

    var nom  = match[1] || "";
    var prix = match[2] || "0";
    var img  = match[3] || "";

  
    carte.removeAttribute('onclick');
    carte.style.cursor = 'default';

    if (!carte.querySelector('.pc-actions')) {
      var actions = document.createElement('div');
      actions.className = 'pc-actions';
      actions.innerHTML =
        '<button class="btn-panier btn-panier-active" data-nom="'+nom+'" ' +
          'onclick="event.stopPropagation(); ajouterAuPanier(\''+escQ(nom)+'\',\''+escQ(prix)+'\',\''+escQ(img)+'\')">' +
          '<i class="ti ti-shopping-cart-plus"></i> Panier' +
        '</button>' +
        '<button class="btn-commander-direct" ' +
          'onclick="event.stopPropagation(); commander(\''+escQ(nom)+'\',\''+escQ(prix)+'\',\''+escQ(img)+'\')">' +
          '<i class="ti ti-bolt"></i> Acheter' +
        '</button>';
      carte.appendChild(actions);
    }
  });
}

function escQ(str) {
  return String(str).replace(/\\/g,'\\\\').replace(/'/g,"\\'");
}

//contact
function dd() {
  var el = document.getElementById("date");
  if (el) { var d = new Date(); el.value = d.toLocaleDateString("fr-FR"); }
}
function extraire() {}
function verifier() { return true; }

// auto
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initBoutons);
} else {
  initBoutons();
}
function passerCommande() {
  var p = getPanier();

  if (p.length === 0) return;

  localStorage.setItem("commande", JSON.stringify(p));

  fermerPanier();

  document.getElementById("iframe-contenu").src = "commande.html";
}
