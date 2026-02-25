<%@ page import="model.User, model.Atoandro, dao.AtoandroDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    ArrayList<ArrayList<Atoandro>> groupes = new ArrayList<>();
    String erreur = null;
    try {
        AtoandroDAO dao = new AtoandroDAO();
        for (int g = 1; g <= 4; g++) {
            groupes.add(dao.getByGroupe(g));
        }
    } catch (AppException e) { erreur = e.getMessage(); }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Atoandro - Dejeuner</title>
    <link rel="stylesheet" href="../css/atoandro.css">
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
        <a href="atoandro.jsp" class="active">Dejeuner</a>
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
        <a href="menu.jsp" class="back-link">&larr; Retour au menu</a>

        <% if (erreur != null) { %>
            <div class="error"><%= erreur %></div>
        <% } else { %>

        <% String[] badgeClasses = {"badge-1","badge-2","badge-3","badge-4"}; %>
        <% for (int g = 0; g < 4; g++) { %>
            <div class="section-title">Groupe <%= (g+1) %></div>
            <table class="list-table">
                <thead><tr><th>#</th><th>Nom</th><th>Groupe</th></tr></thead>
                <tbody>
                <% int n = 1; for (Atoandro a : groupes.get(g)) { %>
                    <tr>
                        <td><%= n++ %></td>
                        <td><%= a.getNom() %></td>
                        <td><span class="badge <%= badgeClasses[g] %>">Groupe <%= (g+1) %></span></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>

        <% } %>
    </div>
    </div><!-- /page-layout -->
</body>
</html>
