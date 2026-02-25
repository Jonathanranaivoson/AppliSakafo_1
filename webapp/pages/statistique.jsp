<%@ page import="model.User, java.sql.*, java.util.ArrayList, utils.Connexion, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    // Classe interne pour stocker les stats
    class StatRecette {
        String nom; String type; int nbFois; String derniereFois;
        StatRecette(String n, String t, int nb, String d) { nom=n; type=t; nbFois=nb; derniereFois=d; }
    }

    ArrayList<StatRecette> stats = new ArrayList<>();
    String erreur = null;
    try {
        Connection conn = Connexion.getConnection();

        // Stats dejeuner (atoandro)
        String sqlA = "SELECT a.nom, COUNT(mj.id) AS nb, MAX(mj.date_fait) AS dernier " +
            "FROM atoandro a JOIN menu_journalier mj ON mj.id_atoandro = a.id " +
            "WHERE mj.fait = true GROUP BY a.nom ORDER BY nb DESC";
        PreparedStatement psA = conn.prepareStatement(sqlA);
        ResultSet rsA = psA.executeQuery();
        while (rsA.next()) {
            stats.add(new StatRecette(rsA.getString("nom"), "Dejeuner", rsA.getInt("nb"),
                rsA.getString("dernier") != null ? rsA.getString("dernier") : "-"));
        }
        rsA.close(); psA.close();

        // Stats diner (hariva)
        String sqlH = "SELECT h.nom, COUNT(mj.id) AS nb, MAX(mj.date_fait) AS dernier " +
            "FROM hariva h JOIN menu_journalier mj ON mj.id_hariva = h.id " +
            "WHERE mj.fait = true GROUP BY h.nom ORDER BY nb DESC";
        PreparedStatement psH = conn.prepareStatement(sqlH);
        ResultSet rsH = psH.executeQuery();
        while (rsH.next()) {
            stats.add(new StatRecette(rsH.getString("nom"), "Diner", rsH.getInt("nb"),
                rsH.getString("dernier") != null ? rsH.getString("dernier") : "-"));
        }
        rsH.close(); psH.close();

        // Stats petit-dej (maraina via menu_maraina)
        String sqlM = "SELECT m.nom, COUNT(mj.id) AS nb, MAX(mj.date_fait) AS dernier " +
            "FROM maraina m JOIN menu_maraina mm ON mm.id_maraina = m.id " +
            "JOIN menu_journalier mj ON mj.id_menu_maraina = mm.id " +
            "WHERE mj.fait = true GROUP BY m.nom ORDER BY nb DESC";
        PreparedStatement psM = conn.prepareStatement(sqlM);
        ResultSet rsM = psM.executeQuery();
        while (rsM.next()) {
            stats.add(new StatRecette(rsM.getString("nom"), "Petit-Dej", rsM.getInt("nb"),
                rsM.getString("dernier") != null ? rsM.getString("dernier") : "-"));
        }
        rsM.close(); psM.close();
        conn.close();
    } catch (Exception e) { erreur = "Erreur lors de la recuperation des statistiques"; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Statistiques - AppliSakafo</title>
    <link rel="stylesheet" href="../css/statistique.css">
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
        <a href="statistique.jsp" class="active">Statistiques</a>
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

        <div class="section-title">Statistiques des recettes cuisinees</div>

        <div class="info-box">
            Les statistiques s'affichent uniquement pour les menus marques comme <strong>"Fait"</strong>.
            Cochez les menus dans la page principale pour voir les statistiques ici.
        </div>

        <% if (erreur != null) { %>
            <div class="error"><%= erreur %></div>
        <% } else if (stats.isEmpty()) { %>
            <div class="info-box">Aucune recette n'a encore ete marquee comme faite.</div>
        <% } else { %>

        <table class="list-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Recette</th>
                    <th>Type</th>
                    <th>Nombre de fois</th>
                    <th>Derniere fois</th>
                </tr>
            </thead>
            <tbody>
            <% int n = 1; for (Object o : stats) {
                StatRecette s = (StatRecette) o;
                String badgeClass = s.type.equals("Dejeuner") ? "badge-dej" : s.type.equals("Diner") ? "badge-din" : "badge-pdj";
            %>
                <tr>
                    <td><%= n++ %></td>
                    <td><%= s.nom %></td>
                    <td><span class="badge <%= badgeClass %>"><%= s.type %></span></td>
                    <td class="nb-fois"><%= s.nbFois %></td>
                    <td><%= s.derniereFois %></td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <% } %>
    </div>
    </div><!-- /page-layout -->

    <footer class="footer">Maison Amboanjobe - Copyright 2026</footer>
</body>
</html>
