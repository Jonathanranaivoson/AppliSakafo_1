<%@ page import="model.User, model.MenuJournalier, model.Atoandro, model.Hariva, model.MenuMaraina, model.SemaineGroupe, dao.MenuJournalierDAO, dao.AtoandroDAO, dao.HarivaDAO, dao.MenuMarainaDAO, dao.SemaineGroupeDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Groupe en cours (par defaut 1, ou via parametre)
    int groupeActuel = 1;
    String paramGroupe = request.getParameter("groupe");
    if (paramGroupe != null) {
        try { groupeActuel = Integer.parseInt(paramGroupe); } catch (Exception e) {}
    }

    ArrayList<MenuJournalier> menus = new ArrayList<>();
    ArrayList<Atoandro> tousAtoandro = new ArrayList<>();
    ArrayList<Hariva> tousHariva = new ArrayList<>();
    ArrayList<MenuMaraina> tousMenuMaraina = new ArrayList<>();
    SemaineGroupe semaineActuelle = null;
    String erreur = null;

    // Vérifier si un groupe vient d'être terminé
    Integer groupeTermine = (Integer) session.getAttribute("groupeTermine");
    if (groupeTermine != null) {
        session.removeAttribute("groupeTermine");
    }

    // Erreur venant de action-menu.jsp
    String erreurAction = (String) session.getAttribute("erreurAction");
    if (erreurAction != null) { session.removeAttribute("erreurAction"); }

    try {
        MenuJournalierDAO mjDAO = new MenuJournalierDAO();
        menus = mjDAO.getByGroupe(groupeActuel);
        tousAtoandro = new AtoandroDAO().getAll();
        tousHariva = new HarivaDAO().getAll();
        tousMenuMaraina = new MenuMarainaDAO().getAll();
        
        // Récupérer la semaine du groupe actuel
        SemaineGroupeDAO sgDAO = new SemaineGroupeDAO();
        semaineActuelle = sgDAO.getByGroupe(groupeActuel);

        // Vérification automatique : si tous les menus sont "fait" et pas de paramètre groupe, passer au suivant
        if (!menus.isEmpty() && paramGroupe == null && groupeTermine == null) {
            boolean tousFaits = true;
            for (MenuJournalier mj : menus) {
                if (!mj.isFait()) {
                    tousFaits = false;
                    break;
                }
            }
            // Si tous faits et qu'il y a un groupe suivant, rediriger
            if (tousFaits) {
                int groupeSuivant = groupeActuel < 4 ? (groupeActuel + 1) : 1;
                response.sendRedirect("menu.jsp?groupe=" + groupeSuivant);
                return;
            }
        }

    } catch (AppException e) {
        erreur = e.getMessage();
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu Principal - AppliSakafo</title>
    <link rel="stylesheet" href="../css/menu.css">
    <link rel="stylesheet" href="../css/sidebar.css">
</head>
<body>
    <div class="header">
        <h1>AppliSakafo</h1>
        <div class="user-info">
            <span>Bienvenue, <%= user.getPrenom() %> <%= user.getNom() %></span>
            <a href="logout.jsp" class="logout-btn">Deconnexion</a>
        </div>
    </div>

    <!-- Navigation -->
    <div class="nav-links">
        <a href="menu.jsp" class="active">Accueil</a>
        <a href="maraina.jsp">Petit-Dejeuner</a>
        <a href="atoandro.jsp">Dejeuner</a>
        <a href="hariva.jsp">Diner</a>
        <a href="menu-hebdo.jsp">Menu</a>
        <a href="statistique.jsp">Statistiques</a>
    </div>

    <div class="page-layout">
        <aside class="sidebar">
            <div class="sidebar-title">Actions</div>
            <a href="ajouter-recette.jsp"><span class="sidebar-icon">📋</span> Ajouter Recettes</a>
            <a href="recettes-ajoutees.jsp"><span class="sidebar-icon">📋</span> Recettes ajoutees</a>
            <a href="menu-dimanche.jsp"><span class="sidebar-icon">📋</span> Menu Dimanche</a>
            <div class="search-bar">
                <form action="recherche.jsp" method="GET">
                    <input type="text" name="query" placeholder="Rechercher une recette..." required>
                    <input type="image" src="../images/loupe.png" alt="Rechercher">
                </form>

</div>

        </aside>
    <div class="container">

        <!-- Affichage de la période de la semaine -->
        <a href="config-semaines.jsp?groupe=<%= groupeActuel %>" class="semaine-info" title="Cliquer pour configurer les dates">
            <span class="semaine-icon">📋</span>
            <% if (semaineActuelle != null) { %>
                <span class="semaine-text">Semaine du <%= semaineActuelle.getPeriodeFormatee() %></span>
            <% } else { %>
                <span class="semaine-text">Semaine non definie - Cliquer pour configurer</span>
            <% } %>
            <span class="semaine-hint">📋 Configurer</span>
        </a>

        <!-- Selecteur de semaine/groupe -->
        <div class="section-title">Menu de la semaine - Groupe <%= groupeActuel %></div>
        <div class="groupe-selector">
            <span>Semaine :</span>
            <% for (int g = 1; g <= 4; g++) { %>
                <a href="menu.jsp?groupe=<%= g %>" class="groupe-btn <%= (g == groupeActuel) ? "active" : "" %>">
                    Groupe <%= g %>
                </a>
            <% } %>
        </div>

        <% if (erreur != null) { %>
            <div class="error"><%= erreur %></div>
        <% } %>
        <% if (erreurAction != null) { %>
            <div class="error"><%= erreurAction %></div>
        <% } %>
        <% if (menus.isEmpty() && erreur == null) { %>
            <div class="error">Aucun menu trouve pour ce groupe.</div>
        <% } else if (!menus.isEmpty()) { %>
        <!-- Tableau du menu de la semaine -->
        <table class="menu-table">
            <thead>
                <tr>
                    <th>Jour</th>
                    <th>Petit-Dejeuner</th>
                    <th>Boisson</th>
                    <th>Dejeuner</th>
                    <th>Diner</th>
                    <th>Fait</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (MenuJournalier mj : menus) { %>
                <tr class="<%= mj.isFait() ? "fait" : "" %>">
                    <td><strong><%= mj.getNomJour() %></strong></td>
                    <td><%= mj.getMenuMaraina().getMaraina().getNom() %></td>
                    <td><%= mj.getMenuMaraina().getBoisson().getNom() %></td>
                    <td><%= mj.getAtoandro().getNom() %></td>
                    <td><%= mj.getHariva().getNom() %></td>
                    <td>
                        <!-- Case a cocher Fait -->
                        <form method="post" action="action-menu.jsp" style="display:inline">
                            <input type="hidden" name="action" value="cocher">
                            <input type="hidden" name="menuId" value="<%= mj.getId() %>">
                            <input type="hidden" name="groupe" value="<%= groupeActuel %>">
                            <input type="hidden" name="fait" value="<%= !mj.isFait() %>">
                            <input type="checkbox" class="checkbox-fait"
                                <%= mj.isFait() ? "checked" : "" %>
                                onchange="this.form.submit()"
                                title="<%= mj.isFait() ? "Marquer non fait" : "Marquer comme fait" %>">
                        </form>
                    </td>
                    <td class="td-actions">
                        <!-- Bouton modifier -->
                        <button class="btn-modifier" onclick="ouvrirModal(<%= mj.getId() %>, '<%= mj.getNomJour() %>', <%= groupeActuel %>)">
                            Modifier
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>

    </div>
    </div><!-- /page-layout -->

    <footer class="footer">&copy; 2026 - Maison Amboanjobe. Tous droits reserves.</footer>

    <!-- Modal de modification -->
    <div class="modal-overlay" id="modalModif">
        <div class="modal">
            <h3 id="modalTitre">Modifier le menu</h3>

            <!-- Modifier Petit-Dejeuner -->
            <form method="post" action="action-menu.jsp" style="margin-bottom:15px">
                <input type="hidden" name="action" value="modifMaraina">
                <input type="hidden" name="menuId" id="modifMarainaMenuId">
                <input type="hidden" name="groupe" id="modifMarainaGroupe">
                <label style="font-weight:600;font-size:0.85rem;display:block;margin-bottom:5px">Petit-Dejeuner :</label>
                <select name="newMenuMarainaId" id="selectMaraina">
                    <optgroup label="Recettes existantes">
                    <% for (MenuMaraina mm : tousMenuMaraina) { if (mm.getMaraina().getGroupe() > 0) { %>
                        <option value="<%= mm.getId() %>"><%= mm.getMaraina().getNom() %> + <%= mm.getBoisson().getNom() %></option>
                    <% } } %>
                    </optgroup>
                    <optgroup label="Recettes ajoutees">
                    <% for (MenuMaraina mm : tousMenuMaraina) { if (mm.getMaraina().getGroupe() == 0) { %>
                        <option value="<%= mm.getId() %>">⭐ <%= mm.getMaraina().getNom() %> + <%= mm.getBoisson().getNom() %></option>
                    <% } } %>
                    </optgroup>
                </select>
                <button type="submit" class="btn-save" style="width:100%;margin-bottom:10px">Changer Petit-Dej</button>
            </form>

            <!-- Modifier Dejeuner -->
            <form method="post" action="action-menu.jsp" style="margin-bottom:15px">
                <input type="hidden" name="action" value="modifAtoandro">
                <input type="hidden" name="menuId" id="modifAtoandroMenuId">
                <input type="hidden" name="groupe" id="modifAtoandroGroupe">
                <label style="font-weight:600;font-size:0.85rem;display:block;margin-bottom:5px">Dejeuner :</label>
                <select name="newAtoandroId" id="selectAtoandro">
                    <optgroup label="Recettes existantes">
                    <% for (Atoandro a : tousAtoandro) { if (a.getGroupe() > 0) { %>
                        <option value="<%= a.getId() %>"><%= a.getNom() %> (Gr.<%= a.getGroupe() %>)</option>
                    <% } } %>
                    </optgroup>
                    <optgroup label="Recettes ajoutees">
                    <% for (Atoandro a : tousAtoandro) { if (a.getGroupe() == 0) { %>
                        <option value="<%= a.getId() %>">⭐ <%= a.getNom() %></option>
                    <% } } %>
                    </optgroup>
                </select>
                <button type="submit" class="btn-save" style="width:100%;margin-bottom:10px">Changer Dejeuner</button>
            </form>

            <!-- Modifier Diner -->
            <form method="post" action="action-menu.jsp" style="margin-bottom:15px">
                <input type="hidden" name="action" value="modifHariva">
                <input type="hidden" name="menuId" id="modifHarivaMenuId">
                <input type="hidden" name="groupe" id="modifHarivaGroupe">
                <label style="font-weight:600;font-size:0.85rem;display:block;margin-bottom:5px">Diner :</label>
                <select name="newHarivaId" id="selectHariva">
                    <optgroup label="Recettes existantes">
                    <% for (Hariva h : tousHariva) { if (h.getGroupe() > 0) { %>
                        <option value="<%= h.getId() %>"><%= h.getNom() %> (Gr.<%= h.getGroupe() %>)</option>
                    <% } } %>
                    </optgroup>
                    <optgroup label="Recettes ajoutees">
                    <% for (Hariva h : tousHariva) { if (h.getGroupe() == 0) { %>
                        <option value="<%= h.getId() %>">⭐ <%= h.getNom() %></option>
                    <% } } %>
                    </optgroup>
                </select>
                <button type="submit" class="btn-save" style="width:100%;margin-bottom:10px">Changer Diner</button>
            </form>

            <div class="modal-actions">
                <button class="btn-cancel" onclick="fermerModal()">Fermer</button>
            </div>
        </div>
    </div>

    <!-- Modal de confirmation de groupe terminé -->
    <div class="modal-overlay" id="modalTermine">
        <div class="modal modal-success">
            <div class="modal-success-icon">📋</div>
            <h3>Groupe <%= groupeActuel %> termine !</h3>
            <p class="modal-success-text">
                Felicitations ! Tous les menus du Groupe <%= groupeActuel %> ont ete cuisines.
            </p>
            <% if (groupeActuel < 4) { %>
                <p class="modal-success-text">Vous pouvez maintenant passer au Groupe <%= groupeActuel + 1 %>.</p>
            <% } else { %>
                <p class="modal-success-text">Tous les groupes sont termines ! Retour au Groupe 1.</p>
            <% } %>
            <div class="modal-actions" style="margin-top: 25px">
                <button class="btn-save" onclick="passerGroupeSuivant()" style="width: auto; padding: 12px 30px">
                    <%= groupeActuel < 4 ? "Passer au Groupe " + (groupeActuel + 1) : "Revenir au Groupe 1" %>
                </button>
                <button class="btn-cancel" onclick="fermerModalTermine()">Rester ici</button>
            </div>
        </div>
    </div>



    <script>
    function ouvrirModal(menuId, jour, groupe) {
        document.getElementById('modalTitre').textContent = 'Modifier - ' + jour;
        document.getElementById('modifMarainaMenuId').value = menuId;
        document.getElementById('modifMarainaGroupe').value = groupe;
        document.getElementById('modifAtoandroMenuId').value = menuId;
        document.getElementById('modifAtoandroGroupe').value = groupe;
        document.getElementById('modifHarivaMenuId').value = menuId;
        document.getElementById('modifHarivaGroupe').value = groupe;
        document.getElementById('modalModif').classList.add('active');
    }
    function fermerModal() {
        document.getElementById('modalModif').classList.remove('active');
    }
    function fermerModalTermine() {
        document.getElementById('modalTermine').classList.remove('active');
    }
    function passerGroupeSuivant() {
        var groupeActuel = <%= groupeActuel %>;
        var groupeSuivant = groupeActuel < 4 ? (groupeActuel + 1) : 1;
        window.location.href = 'menu.jsp?groupe=' + groupeSuivant;
    }

    // Fermer en cliquant en dehors
    document.getElementById('modalModif').addEventListener('click', function(e) {
        if (e.target === this) fermerModal();
    });

    <% if (groupeTermine != null) { %>
    // Afficher automatiquement la modal de groupe terminé
    document.getElementById('modalTermine').classList.add('active');
    <% } %>
    </script>
</body>
</html>
