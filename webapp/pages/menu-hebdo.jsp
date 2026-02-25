<%@ page import="model.User, model.MenuJournalier, model.Atoandro, model.Hariva, model.MenuMaraina, dao.MenuJournalierDAO, dao.AtoandroDAO, dao.HarivaDAO, dao.MenuMarainaDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    // Charger les 4 groupes
    ArrayList<ArrayList<MenuJournalier>> tousGroupes = new ArrayList<>();
    ArrayList<Atoandro> tousAtoandro = new ArrayList<>();
    ArrayList<Hariva> tousHariva = new ArrayList<>();
    ArrayList<MenuMaraina> tousMenuMaraina = new ArrayList<>();
    String erreur = null;

    String erreurAction = (String) session.getAttribute("erreurAction");
    if (erreurAction != null) { session.removeAttribute("erreurAction"); }

    try {
        MenuJournalierDAO mjDAO = new MenuJournalierDAO();
        for (int g = 1; g <= 4; g++) {
            tousGroupes.add(mjDAO.getByGroupe(g));
        }
        tousAtoandro = new AtoandroDAO().getAll();
        tousHariva = new HarivaDAO().getAll();
        tousMenuMaraina = new MenuMarainaDAO().getAll();
    } catch (AppException e) { erreur = e.getMessage(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu Hebdomadaire - AppliSakafo</title>
    <link rel="stylesheet" href="../css/menu-hebdo.css">
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
    <div class="nav-links">
        <a href="menu.jsp">Accueil</a>
        <a href="maraina.jsp">Petit-Dejeuner</a>
        <a href="atoandro.jsp">Dejeuner</a>
        <a href="hariva.jsp">Diner</a>
        <a href="menu-hebdo.jsp" class="active">Menu</a>
        <a href="statistique.jsp">Statistiques</a>
    </div>

    <div class="page-layout">
    <aside class="sidebar">
        <div class="sidebar-title">Navigation</div>
        <a href="ajouter-recette.jsp">Ajouter Recettes</a>
        <a href="recettes-ajoutees.jsp">Recettes ajoutees</a>
        <a href="menu-dimanche.jsp">Menu Dimanche</a>
        <div class="search-bar">
            <form action="recherche.jsp" method="GET">
                <input type="text" name="query" placeholder="Rechercher une recette..." required>
                <input type="image" src="../images/loupe.png" alt="Rechercher">
            </form>
        </div>
    </aside>
    <div class="container">
        <a href="menu.jsp" class="back-link">&larr; Retour au menu</a>

        <% if (erreur != null) { %>
            <div class="error"><%= erreur %></div>
        <% } else { %>

        <% if (erreurAction != null) { %>
            <div class="error"><%= erreurAction %></div>
        <% } %>

        <div class="group-colors">
            <span class="group-label gl-1">Groupe 1 = Semaine 1</span>
            <span class="group-label gl-2">Groupe 2 = Semaine 2</span>
            <span class="group-label gl-3">Groupe 3 = Semaine 3</span>
            <span class="group-label gl-4">Groupe 4 = Semaine 4</span>
        </div>

        <% String[] glClasses = {"gl-1","gl-2","gl-3","gl-4"}; %>
        <% for (int g = 0; g < 4; g++) { %>
            <div class="section-title">
                <span class="group-label <%= glClasses[g] %>">Tableau <%= (g+1) %> - Groupe <%= (g+1) %></span>
            </div>
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
                <% for (MenuJournalier mj : tousGroupes.get(g)) { %>
                    <tr class="<%= mj.isFait() ? "fait" : "" %>">
                        <td><strong><%= mj.getNomJour() %></strong></td>
                        <td><%= mj.getMenuMaraina().getMaraina().getNom() %></td>
                        <td><%= mj.getMenuMaraina().getBoisson().getNom() %></td>
                        <td><%= mj.getAtoandro().getNom() %></td>
                        <td><%= mj.getHariva().getNom() %></td>
                        <td>
                            <form method="post" action="action-menu.jsp" style="display:inline">
                                <input type="hidden" name="action" value="cocher">
                                <input type="hidden" name="menuId" value="<%= mj.getId() %>">
                                <input type="hidden" name="groupe" value="<%= (g+1) %>">
                                <input type="hidden" name="fait" value="<%= !mj.isFait() %>">
                                <input type="hidden" name="source" value="hebdo">
                                <input type="checkbox" class="checkbox-fait"
                                    <%= mj.isFait() ? "checked" : "" %>
                                    onchange="this.form.submit()"
                                    title="<%= mj.isFait() ? "Marquer non fait" : "Marquer comme fait" %>">
                            </form>
                        </td>
                        <td class="td-actions">
                            <button class="btn-modifier" onclick="ouvrirModal(<%= mj.getId() %>, '<%= mj.getNomJour() %>', <%= (g+1) %>)">
                                Modifier
                            </button>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>

        <% } %>
    </div>
    </div><!-- /page-layout -->

    <!-- Modal de modification -->
    <div class="modal-overlay" id="modalModif">
        <div class="modal">
            <h3 id="modalTitre">Modifier le menu</h3>

            <form method="post" action="action-menu.jsp" style="margin-bottom:15px">
                <input type="hidden" name="action" value="modifMaraina">
                <input type="hidden" name="menuId" id="modifMarainaMenuId">
                <input type="hidden" name="groupe" id="modifMarainaGroupe">
                <input type="hidden" name="source" value="hebdo">
                <label>Petit-Dejeuner :</label>
                <select name="newMenuMarainaId">
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
                <button type="submit" class="btn-save">Changer Petit-Dej</button>
            </form>

            <form method="post" action="action-menu.jsp" style="margin-bottom:15px">
                <input type="hidden" name="action" value="modifAtoandro">
                <input type="hidden" name="menuId" id="modifAtoandroMenuId">
                <input type="hidden" name="groupe" id="modifAtoandroGroupe">
                <input type="hidden" name="source" value="hebdo">
                <label>Dejeuner :</label>
                <select name="newAtoandroId">
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
                <button type="submit" class="btn-save">Changer Dejeuner</button>
            </form>

            <form method="post" action="action-menu.jsp" style="margin-bottom:15px">
                <input type="hidden" name="action" value="modifHariva">
                <input type="hidden" name="menuId" id="modifHarivaMenuId">
                <input type="hidden" name="groupe" id="modifHarivaGroupe">
                <input type="hidden" name="source" value="hebdo">
                <label>Diner :</label>
                <select name="newHarivaId">
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
                <button type="submit" class="btn-save">Changer Diner</button>
            </form>

            <div style="text-align:right">
                <button class="btn-cancel" onclick="fermerModal()">Fermer</button>
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
    document.getElementById('modalModif').addEventListener('click', function(e) {
        if (e.target === this) fermerModal();
    });
    </script>
</body>
</html>
