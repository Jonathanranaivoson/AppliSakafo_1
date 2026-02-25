<%@ page import="model.User, model.RecetteAjoutee, dao.RecetteAjouteeDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    ArrayList<RecetteAjoutee> pdj = new ArrayList<>();
    ArrayList<RecetteAjoutee> dej = new ArrayList<>();
    ArrayList<RecetteAjoutee> din = new ArrayList<>();
    String erreur = null;
    try {
        RecetteAjouteeDAO dao = new RecetteAjouteeDAO();
        pdj = dao.getByType("petit-dejeuner");
        dej = dao.getByType("dejeuner");
        din = dao.getByType("diner");
    } catch (AppException e) { erreur = e.getMessage(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recettes Ajoutees - AppliSakafo</title>
    <link rel="stylesheet" href="../css/recettes-ajoutees.css">
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
            <a href="recettes-ajoutees.jsp" class="sb-active">
                <span class="sidebar-icon">📋</span> Recettes ajoutees
            </a>
            <a href="menu-dimanche.jsp">
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

            <% if (erreur != null) { %>
                <div class="error"><%= erreur %></div>
            <% } else { %>

            <!-- Petit-Dejeuner -->
            <div class="section-title">Petit-Dejeuner (<%= pdj.size() %>)</div>
            <% if (pdj.isEmpty()) { %>
                <div class="empty-msg">Aucune recette petit-dejeuner ajoutee.</div>
            <% } else { %>
            <table class="list-table">
                <thead><tr><th>#</th><th>Nom</th><th>Type</th><th>Date ajout</th></tr></thead>
                <tbody>
                <% int n = 1; for (RecetteAjoutee r : pdj) { %>
                    <tr>
                        <td><%= n++ %></td>
                        <td><%= r.getNom() %></td>
                        <td><span class="badge badge-pdj">Petit-Dej</span></td>
                        <td><%= r.getDateAjout() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>

            <!-- Dejeuner -->
            <div class="section-title">Dejeuner (<%= dej.size() %>)</div>
            <% if (dej.isEmpty()) { %>
                <div class="empty-msg">Aucune recette dejeuner ajoutee.</div>
            <% } else { %>
            <table class="list-table">
                <thead><tr><th>#</th><th>Nom</th><th>Type</th><th>Date ajout</th></tr></thead>
                <tbody>
                <% int n2 = 1; for (RecetteAjoutee r : dej) { %>
                    <tr>
                        <td><%= n2++ %></td>
                        <td><%= r.getNom() %></td>
                        <td><span class="badge badge-dej">Dejeuner</span></td>
                        <td><%= r.getDateAjout() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>

            <!-- Diner -->
            <div class="section-title">Diner (<%= din.size() %>)</div>
            <% if (din.isEmpty()) { %>
                <div class="empty-msg">Aucune recette diner ajoutee.</div>
            <% } else { %>
            <table class="list-table">
                <thead><tr><th>#</th><th>Nom</th><th>Type</th><th>Date ajout</th></tr></thead>
                <tbody>
                <% int n3 = 1; for (RecetteAjoutee r : din) { %>
                    <tr>
                        <td><%= n3++ %></td>
                        <td><%= r.getNom() %></td>
                        <td><span class="badge badge-din">Diner</span></td>
                        <td><%= r.getDateAjout() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>

            <% } %>
        </div>
    </div>
</body>
</html>
