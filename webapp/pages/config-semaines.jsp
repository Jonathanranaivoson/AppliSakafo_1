<%@ page import="model.User, model.SemaineGroupe, dao.SemaineGroupeDAO, java.util.ArrayList, exception.AppException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Récupérer le groupe depuis l'URL (par défaut 1)
    int groupeConcerne = 1;
    String paramGroupe = request.getParameter("groupe");
    if (paramGroupe != null) {
        try { groupeConcerne = Integer.parseInt(paramGroupe); } catch (Exception e) {}
    }

    SemaineGroupe semaineActuelle = null;
    String erreur = null;
    String succes = null;

    // Message de succès après mise à jour
    String succesMsg = (String) session.getAttribute("succesConfig");
    if (succesMsg != null) {
        succes = succesMsg;
        session.removeAttribute("succesConfig");
    }

    try {
        SemaineGroupeDAO sgDAO = new SemaineGroupeDAO();
        semaineActuelle = sgDAO.getByGroupe(groupeConcerne);
    } catch (AppException e) {
        erreur = e.getMessage();
    }

    boolean existe = (semaineActuelle != null);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Configuration des semaines - AppliSakafo</title>
    <link rel="stylesheet" href="../css/menu.css">
    <link rel="stylesheet" href="../css/sidebar.css">
    <link rel="stylesheet" href="../css/ajouter-recette.css">
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
            <a href="menu.jsp?groupe=<%= groupeConcerne %>" class="back-link">&larr; Retour au menu</a>

            <div class="section-title">📋 Configuration du Groupe <%= groupeConcerne %></div>

            <% if (erreur != null) { %>
                <div class="error"><%= erreur %></div>
            <% } %>
            <% if (succes != null) { %>
                <div class="success" style="color: #2ECC71; padding: 15px; background: #eafaf1; border-radius: 12px; margin-bottom: 20px; border-left: 4px solid #2ECC71;">
                    <%= succes %>
                </div>
            <% } %>

            <p style="color: var(--text-muted); margin-bottom: 25px; font-size: 0.9rem;">
                Definissez les dates de debut et de fin pour le Groupe <%= groupeConcerne %> (semaine <%= groupeConcerne %>).
            </p>

            <div class="form-card" style="margin-bottom: 20px;">
                <h3 style="color: var(--accent); margin-bottom: 15px; font-size: 1.1rem;">
                    📋 Groupe <%= groupeConcerne %>
                    <% if (!existe) { %>
                        <span style="color: var(--text-muted); font-size: 0.8rem; font-weight: 500;">(Non configure)</span>
                    <% } %>
                </h3>
                <form method="post" action="action-config-semaines.jsp">
                    <input type="hidden" name="groupe" value="<%= groupeConcerne %>">
                    <input type="hidden" name="action" value="<%= existe ? "update" : "insert" %>">
                    <input type="hidden" name="redirect" value="groupe">
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 15px;">
                        <div>
                            <label style="display: block; font-weight: 600; margin-bottom: 6px; font-size: 0.85rem; color: var(--text-main);">
                                DATE DEBUT
                            </label>
                            <input type="date" name="dateDebut" value="<%= existe ? semaineActuelle.getDateDebut() : "" %>" required
                                   style="width: 100%; padding: 10px 12px; border: 2px solid var(--border); border-radius: 12px; font-size: 0.9rem;">
                        </div>
                        <div>
                            <label style="display: block; font-weight: 600; margin-bottom: 6px; font-size: 0.85rem; color: var(--text-main);">
                                DATE FIN
                            </label>
                            <input type="date" name="dateFin" value="<%= existe ? semaineActuelle.getDateFin() : "" %>" required
                                   style="width: 100%; padding: 10px 12px; border: 2px solid var(--border); border-radius: 12px; font-size: 0.9rem;">
                        </div>
                    </div>

                    <div style="display: flex; gap: 10px; align-items: center;">
                        <button type="submit" class="btn-save" style="width: auto; margin-bottom: 0;">
                            <%= existe ? "Enregistrer" : "Definir" %> Groupe <%= groupeConcerne %>
                        </button>
                        <% if (existe) { %>
                        <span style="color: var(--text-muted); font-size: 0.85rem;">
                            Actuellement : <%= semaineActuelle.getPeriodeFormatee() %>
                        </span>
                        <% } %>
                    </div>
                </form>
            </div>

        </div>
    </div>

    <footer class="footer">&copy; 2026 - Maison Amboanjobe. Tous droits reserves.</footer>
</body>
</html>
