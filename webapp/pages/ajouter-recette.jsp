<%@ page import="model.User, model.Boisson, dao.BoissonDAO, java.util.ArrayList" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../index.jsp"); return; }

    ArrayList<Boisson> boissons = new ArrayList<>();
    try { boissons = new BoissonDAO().getAll(); } catch (Exception e) {}

    String successMsg = (String) session.getAttribute("successRecette");
    if (successMsg != null) { session.removeAttribute("successRecette"); }
    String erreurMsg = (String) session.getAttribute("erreurRecette");
    if (erreurMsg != null) { session.removeAttribute("erreurRecette"); }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter Recette - AppliSakafo</title>
    <link rel="stylesheet" href="../css/ajouter-recette.css">
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
            <a href="ajouter-recette.jsp" class="sb-active">
                <span class="sidebar-icon">📋</span> Ajouter Recettes
            </a>
            <a href="recettes-ajoutees.jsp">
                <span class="sidebar-icon">📋</span> Recettes ajoutees
            </a>
            <a href="menu-dimanche.jsp">
                <span class="sidebar-icon">📋</span> Menu Dimanche
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

            <div class="section-title">Ajouter une nouvelle recette</div>

            <% if (successMsg != null) { %>
                <div class="success-msg"><%= successMsg %></div>
            <% } %>
            <% if (erreurMsg != null) { %>
                <div class="error"><%= erreurMsg %></div>
            <% } %>

            <div class="form-card">
                <form method="post" action="action-recette.jsp">
                    <input type="hidden" name="action" value="ajouter">
                    <div class="form-group">
                        <label>Nom de la recette :</label>
                        <input type="text" name="nom" required placeholder="Ex: Poulet roti, Soupe de legumes...">
                    </div>
                    <div class="form-group">
                        <label>Type de repas :</label>
                        <select name="type_repas" required onchange="toggleBoisson(this.value)">
                            <option value="petit-dejeuner">Petit-Dejeuner</option>
                            <option value="dejeuner">Dejeuner</option>
                            <option value="diner">Diner</option>
                        </select>
                    </div>
                    <div class="form-group" id="boissonGroup">
                        <label>Boisson associee :</label>
                        <select name="boisson_id">
                            <% for (Boisson b : boissons) { %>
                                <option value="<%= b.getId() %>"><%= b.getNom() %></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn-insert">Inserer la recette</button>
                </form>
                <script>
                function toggleBoisson(val) {
                    document.getElementById('boissonGroup').style.display = (val === 'petit-dejeuner') ? 'block' : 'none';
                }
                </script>
            </div>

        </div>
    </div>
</body>
</html>
