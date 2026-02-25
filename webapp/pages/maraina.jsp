<%@ page import="model.User, model.Maraina, model.Boisson, dao.MarainaDAO, dao.BoissonDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    ArrayList<Maraina> groupe1 = new ArrayList<>();
    ArrayList<Maraina> groupe2 = new ArrayList<>();
    ArrayList<Boisson> boissons = new ArrayList<>();
    String erreur = null;
    try {
        MarainaDAO mDAO = new MarainaDAO();
        groupe1 = mDAO.getByGroupe(1);
        groupe2 = mDAO.getByGroupe(2);
        boissons = new BoissonDAO().getAll();
    } catch (AppException e) { erreur = e.getMessage(); }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Maraina - Petit-Dejeuner</title>
    <link rel="stylesheet" href="../css/maraina.css">
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
        <a href="maraina.jsp" class="active">Petit-Dejeuner</a>
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
        <a href="menu.jsp" class="back-link">&larr; Retour au menu</a>

        <% if (erreur != null) { %>
            <div class="error"><%= erreur %></div>
        <% } else { %>

        <!-- Groupe 1 : Vary / Riz -->
        <div class="section-title">Groupe 1 - Vary / Riz</div>
        <table class="list-table">
            <thead><tr><th>#</th><th>Nom</th><th>Groupe</th></tr></thead>
            <tbody>
            <% int n = 1; for (Maraina m : groupe1) { %>
                <tr><td><%= n++ %></td><td><%= m.getNom() %></td><td><span class="badge-g1">Groupe 1</span></td></tr>
            <% } %>
            </tbody>
        </table>

        <!-- Groupe 2 : Extra -->
        <div class="section-title">Groupe 2 - Extra (non riz)</div>
        <table class="list-table">
            <thead><tr><th>#</th><th>Nom</th><th>Groupe</th></tr></thead>
            <tbody>
            <% n = 1; for (Maraina m : groupe2) { %>
                <tr><td><%= n++ %></td><td><%= m.getNom() %></td><td><span class="badge-g2">Groupe 2</span></td></tr>
            <% } %>
            </tbody>
        </table>

        <!-- Boissons -->
        <div class="section-title">Boissons</div>
        <table class="list-table">
            <thead><tr><th>#</th><th>Nom</th><th>Type</th></tr></thead>
            <tbody>
            <% n = 1; for (Boisson b : boissons) { %>
                <tr><td><%= n++ %></td><td><%= b.getNom() %></td><td><span class="badge-boisson">Boisson</span></td></tr>
            <% } %>
            </tbody>
        </table>

        <% } %>
    </div>
    </div><!-- /page-layout -->
</body>
</html>
