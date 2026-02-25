<%@ page import="model.User, model.Atoandro, model.Hariva, model.Maraina, model.RecetteAjoutee, dao.AtoandroDAO, dao.HarivaDAO, dao.MarainaDAO, dao.RecetteAjouteeDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String query = request.getParameter("query");
    if (query == null) query = "";
    query = query.trim();

    ArrayList<Maraina> resultatsMaraina = new ArrayList<>();
    ArrayList<Atoandro> resultatsAtoandro = new ArrayList<>();
    ArrayList<Hariva> resultatsHariva = new ArrayList<>();
    ArrayList<RecetteAjoutee> resultatsAjoutees = new ArrayList<>();
    String erreur = null;
    int totalResultats = 0;

    if (!query.isEmpty()) {
        try {
            resultatsMaraina = new MarainaDAO().searchByNom(query);
            resultatsAtoandro = new AtoandroDAO().searchByNom(query);
            resultatsHariva = new HarivaDAO().searchByNom(query);
            resultatsAjoutees = new RecetteAjouteeDAO().searchByNom(query);
            totalResultats = resultatsMaraina.size() + resultatsAtoandro.size()
                           + resultatsHariva.size() + resultatsAjoutees.size();
        } catch (AppException e) {
            erreur = e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche - AppliSakafo</title>
    <link rel="stylesheet" href="../css/menu.css">
    <link rel="stylesheet" href="../css/sidebar.css">
    <link rel="stylesheet" href="../css/recherche.css">
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
            <a href="ajouter-recette.jsp"><span class="sidebar-icon">📋</span> Ajouter Recettes</a>
            <a href="recettes-ajoutees.jsp"><span class="sidebar-icon">📋</span> Recettes ajoutees</a>
            <a href="menu-dimanche.jsp"><span class="sidebar-icon">📋</span> Menu Dimanche</a>
            <div class="search-bar">
                <form action="recherche.jsp" method="GET">
                    <input type="text" name="query" placeholder="Rechercher une recette..." value="<%= query %>" required>
                    <input type="image" src="../images/loupe.png" alt="Rechercher" style="width: 25px; vertical-align: middle;">
                </form>
            </div>
        </aside>

        <div class="container">

            <!-- Barre de recherche principale -->
            <div class="recherche-header">
                <h2 class="section-title">Recherche de recettes</h2>
                <form action="recherche.jsp" method="GET" class="recherche-form">
                    <div class="recherche-input-wrapper">
                        <img src="../images/loupe.png" alt="" class="recherche-icon">
                        <input type="text" name="query" value="<%= query %>" placeholder="Tapez le nom d'une recette..." required class="recherche-input">
                    </div>
                    <button type="submit" class="recherche-btn">Rechercher</button>
                </form>
            </div>

            <% if (erreur != null) { %>
                <div class="error"><%= erreur %></div>
            <% } %>

            <% if (!query.isEmpty()) { %>
                <div class="recherche-resume">
                    <span class="recherche-query">Resultats pour "<strong><%= query %></strong>"</span>
                    <span class="recherche-count"><%= totalResultats %> resultat<%= totalResultats > 1 ? "s" : "" %> trouve<%= totalResultats > 1 ? "s" : "" %></span>
                </div>
            <% } %>

            <% if (!query.isEmpty() && totalResultats == 0 && erreur == null) { %>
                <div class="recherche-vide">
                    <div class="recherche-vide-icon">🔍</div>
                    <h3>Aucun resultat</h3>
                    <p>Aucune recette ne correspond a "<strong><%= query %></strong>".</p>
                    <p>Essayez avec un autre mot-cle.</p>
                </div>
            <% } %>

            <!-- Resultats Petit-Dejeuner -->
            <% if (!resultatsMaraina.isEmpty()) { %>
            <div class="recherche-section">
                <div class="recherche-section-header">
                    <span class="recherche-section-icon">☀️</span>
                    <h3>Petit-Dejeuner</h3>
                    <span class="recherche-section-count"><%= resultatsMaraina.size() %></span>
                </div>
                <div class="recherche-cards">
                    <% for (Maraina m : resultatsMaraina) { %>
                    <div class="recherche-card">
                        <div class="recherche-card-type petit-dejeuner">Petit-Dej</div>
                        <div class="recherche-card-nom"><%= m.getNom() %></div>
                        <div class="recherche-card-info">Groupe <%= m.getGroupe() %></div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <!-- Resultats Dejeuner -->
            <% if (!resultatsAtoandro.isEmpty()) { %>
            <div class="recherche-section">
                <div class="recherche-section-header">
                    <span class="recherche-section-icon">🍲</span>
                    <h3>Dejeuner</h3>
                    <span class="recherche-section-count"><%= resultatsAtoandro.size() %></span>
                </div>
                <div class="recherche-cards">
                    <% for (Atoandro a : resultatsAtoandro) { %>
                    <div class="recherche-card">
                        <div class="recherche-card-type dejeuner">Dejeuner</div>
                        <div class="recherche-card-nom"><%= a.getNom() %></div>
                        <div class="recherche-card-info">Groupe <%= a.getGroupe() %></div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <!-- Resultats Diner -->
            <% if (!resultatsHariva.isEmpty()) { %>
            <div class="recherche-section">
                <div class="recherche-section-header">
                    <span class="recherche-section-icon">🌙</span>
                    <h3>Diner</h3>
                    <span class="recherche-section-count"><%= resultatsHariva.size() %></span>
                </div>
                <div class="recherche-cards">
                    <% for (Hariva h : resultatsHariva) { %>
                    <div class="recherche-card">
                        <div class="recherche-card-type diner">Diner</div>
                        <div class="recherche-card-nom"><%= h.getNom() %></div>
                        <div class="recherche-card-info">Groupe <%= h.getGroupe() %></div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <!-- Resultats Recettes Ajoutees -->
            <% if (!resultatsAjoutees.isEmpty()) { %>
            <div class="recherche-section">
                <div class="recherche-section-header">
                    <span class="recherche-section-icon">📋</span>
                    <h3>Recettes Ajoutees</h3>
                    <span class="recherche-section-count"><%= resultatsAjoutees.size() %></span>
                </div>
                <div class="recherche-cards">
                    <% for (RecetteAjoutee r : resultatsAjoutees) { %>
                    <div class="recherche-card">
                        <div class="recherche-card-type ajoutee"><%= r.getTypeRepasLabel() %></div>
                        <div class="recherche-card-nom"><%= r.getNom() %></div>
                        <div class="recherche-card-info">Ajoutee le <%= r.getDateAjout() %></div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <% if (query.isEmpty()) { %>
                <div class="recherche-vide">
                    <div class="recherche-vide-icon">🍽️</div>
                    <h3>Rechercher une recette</h3>
                    <p>Utilisez la barre de recherche pour trouver une recette parmi les petits-dejeuners, dejeuners, diners et recettes ajoutees.</p>
                </div>
            <% } %>

        </div>
    </div>

    <footer class="footer">&copy; 2026 - Maison Amboanjobe. Tous droits reserves.</footer>
</body>
</html>
