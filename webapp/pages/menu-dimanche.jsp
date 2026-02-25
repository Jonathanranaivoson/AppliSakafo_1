<%@ page import="model.User, model.MenuDimanche, model.Maraina, model.Atoandro, model.Hariva, model.RecetteAjoutee, dao.MenuDimancheDAO, dao.MarainaDAO, dao.AtoandroDAO, dao.HarivaDAO, dao.RecetteAjouteeDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    ArrayList<MenuDimanche> menus = new ArrayList<>();
    // Listes pour dropdown combiné
    ArrayList<Maraina> listMaraina = new ArrayList<>();
    ArrayList<Atoandro> listAtoandro = new ArrayList<>();
    ArrayList<Hariva> listHariva = new ArrayList<>();
    ArrayList<RecetteAjoutee> recPdj = new ArrayList<>();
    ArrayList<RecetteAjoutee> recDej = new ArrayList<>();
    ArrayList<RecetteAjoutee> recDin = new ArrayList<>();
    String erreur = null;

    String successMsg = (String) session.getAttribute("successDimanche");
    if (successMsg != null) { session.removeAttribute("successDimanche"); }
    String erreurMsg = (String) session.getAttribute("erreurDimanche");
    if (erreurMsg != null) { session.removeAttribute("erreurDimanche"); }

    try {
        menus = new MenuDimancheDAO().getAll();
        listMaraina = new MarainaDAO().getAll();
        listAtoandro = new AtoandroDAO().getAll();
        listHariva = new HarivaDAO().getAll();
        RecetteAjouteeDAO raDAO = new RecetteAjouteeDAO();
        recPdj = raDAO.getByType("petit-dejeuner");
        recDej = raDAO.getByType("dejeuner");
        recDin = raDAO.getByType("diner");
    } catch (AppException e) { erreur = e.getMessage(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu Dimanche - AppliSakafo</title>
    <link rel="stylesheet" href="../css/menu-dimanche.css">
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
        <a href="menu-hebdo.jsp">Menu</a>
        <a href="statistique.jsp">Statistiques</a>
    </div>

    <div class="page-layout">
        <aside class="sidebar">
            <div class="sidebar-title">Actions</div>
            <a href="ajouter-recette.jsp">
                <span class="sidebar-icon">➕</span> Ajouter Recettes
            </a>
            <a href="recettes-ajoutees.jsp">
                <span class="sidebar-icon">📋</span> Recettes ajoutees
            </a>
            <a href="menu-dimanche.jsp" class="sb-active">
                <span class="sidebar-icon">🌟</span> Menu Dimanche
            </a>
            <div class="search-bar">
                <form action="recherche.jsp" method="GET">
                    <input type="text" name="query" placeholder="Rechercher une recette..." required>
                    <input type="image" src="../images/loupe.png" alt="Rechercher">
                </form>
            </div>
        </aside>
        <div class="container">
            <a href="menu.jsp" class="back-link">&larr; Retour au menu</a>

            <div class="notification">
                <span style="margin-right:10px">🌟</span>
                Menu special du dimanche — planifiez vos repas dominicaux
            </div>

            <% if (erreur != null) { %>
                <div class="error"><%= erreur %></div>
            <% } %>
            <% if (successMsg != null) { %>
                <div class="success-msg"><%= successMsg %></div>
            <% } %>
            <% if (erreurMsg != null) { %>
                <div class="error"><%= erreurMsg %></div>
            <% } %>

            <!-- Formulaire d'insertion -->
            <div class="section-title">Inserer un nouveau menu dimanche</div>
            <div class="form-card">
                <form method="post" action="action-dimanche.jsp">
                    <input type="hidden" name="action" value="inserer">
                    <div class="form-group">
                        <label>Type de repas :</label>
                        <select name="type_repas" id="typeRepas" required onchange="changerType()">
                            <option value="petit-dejeuner">Petit-Dejeuner</option>
                            <option value="dejeuner">Dejeuner</option>
                            <option value="diner">Diner</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Plat :</label>
                        <!-- Dropdown Petit-Dej -->
                        <select name="plat_pdj" id="platPdj">
                            <optgroup label="--- Recettes existantes ---">
                            <% for (Maraina m : listMaraina) { %>
                                <option value="<%= m.getNom() %>"><%= m.getNom() %></option>
                            <% } %>
                            </optgroup>
                            <% if (!recPdj.isEmpty()) { %>
                            <optgroup label="--- Recettes ajoutees ---">
                            <% for (RecetteAjoutee r : recPdj) { %>
                                <option value="<%= r.getNom() %>"><%= r.getNom() %> (ajoutee)</option>
                            <% } %>
                            </optgroup>
                            <% } %>
                        </select>
                        <!-- Dropdown Dejeuner -->
                        <select name="plat_dej" id="platDej" style="display:none">
                            <optgroup label="--- Recettes existantes ---">
                            <% for (Atoandro a : listAtoandro) { %>
                                <option value="<%= a.getNom() %>"><%= a.getNom() %></option>
                            <% } %>
                            </optgroup>
                            <% if (!recDej.isEmpty()) { %>
                            <optgroup label="--- Recettes ajoutees ---">
                            <% for (RecetteAjoutee r : recDej) { %>
                                <option value="<%= r.getNom() %>"><%= r.getNom() %> (ajoutee)</option>
                            <% } %>
                            </optgroup>
                            <% } %>
                        </select>
                        <!-- Dropdown Diner -->
                        <select name="plat_din" id="platDin" style="display:none">
                            <optgroup label="--- Recettes existantes ---">
                            <% for (Hariva h : listHariva) { %>
                                <option value="<%= h.getNom() %>"><%= h.getNom() %></option>
                            <% } %>
                            </optgroup>
                            <% if (!recDin.isEmpty()) { %>
                            <optgroup label="--- Recettes ajoutees ---">
                            <% for (RecetteAjoutee r : recDin) { %>
                                <option value="<%= r.getNom() %>"><%= r.getNom() %> (ajoutee)</option>
                            <% } %>
                            </optgroup>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Date du dimanche :</label>
                        <input type="date" name="date_menu" required>
                    </div>
                    <button type="submit" class="btn-insert">Valider</button>
                </form>
            </div>

            <!-- Liste des menus dimanche -->
            <div class="section-title">Menus dimanche enregistres</div>
            <% if (menus.isEmpty()) { %>
                <div class="empty-msg">Aucun menu dimanche enregistre.</div>
            <% } else { %>
            <table class="list-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Plat</th>
                        <th>Type</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                <% int n = 1; for (MenuDimanche md : menus) {
                    String badgeClass = md.getTypeRepas().equals("dejeuner") ? "badge-dej" :
                                        md.getTypeRepas().equals("diner") ? "badge-din" : "badge-pdj";
                %>
                    <tr>
                        <td><%= n++ %></td>
                        <td><%= md.getNomPlat() %></td>
                        <td><span class="badge <%= badgeClass %>"><%= md.getTypeRepasLabel() %></span></td>
                        <td><%= md.getDateMenu() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>

        </div>
    </div>

    <script>
    function changerType() {
        var type = document.getElementById('typeRepas').value;
        document.getElementById('platPdj').style.display = (type === 'petit-dejeuner') ? 'block' : 'none';
        document.getElementById('platDej').style.display = (type === 'dejeuner') ? 'block' : 'none';
        document.getElementById('platDin').style.display = (type === 'diner') ? 'block' : 'none';
        // Enable/disable pour le submit
        document.getElementById('platPdj').disabled = (type !== 'petit-dejeuner');
        document.getElementById('platDej').disabled = (type !== 'dejeuner');
        document.getElementById('platDin').disabled = (type !== 'diner');
    }
    // Init
    changerType();
    </script>
</body>
</html>
