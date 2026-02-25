<%@ page import="dao.RecetteAjouteeDAO, exception.AppException" %>
<%
    // Action handler pour l'ajout de recettes
    String action = request.getParameter("action");
    if (action == null) { response.sendRedirect("ajouter-recette.jsp"); return; }

    if ("ajouter".equals(action)) {
        String nom = request.getParameter("nom");
        String typeRepas = request.getParameter("type_repas");

        if (nom == null || nom.trim().isEmpty() || typeRepas == null) {
            session.setAttribute("erreurRecette", "Veuillez remplir tous les champs.");
            response.sendRedirect("ajouter-recette.jsp");
            return;
        }

        int boissonId = 0;
        String boissonStr = request.getParameter("boisson_id");
        if (boissonStr != null) { try { boissonId = Integer.parseInt(boissonStr); } catch (Exception ex) {} }

        try {
            new RecetteAjouteeDAO().insert(nom.trim(), typeRepas, boissonId);
            String label = typeRepas.equals("petit-dejeuner") ? "Petit-Dejeuner" :
                           typeRepas.equals("dejeuner") ? "Dejeuner" : "Diner";
            session.setAttribute("successRecette", "Recette \"" + nom.trim() + "\" ajoutee en tant que " + label + " !");
        } catch (AppException e) {
            session.setAttribute("erreurRecette", "Erreur : " + e.getMessage());
        }
        response.sendRedirect("ajouter-recette.jsp");
        return;
    }

    response.sendRedirect("ajouter-recette.jsp");
%>
