<%@ page import="dao.MenuDimancheDAO, exception.AppException" %>
<%
    // Action handler pour le menu dimanche
    String action = request.getParameter("action");
    if (action == null) { response.sendRedirect("menu-dimanche.jsp"); return; }

    if ("inserer".equals(action)) {
        String typeRepas = request.getParameter("type_repas");
        String dateMenu = request.getParameter("date_menu");

        // Récupérer le plat selon le type
        String nomPlat = null;
        if ("petit-dejeuner".equals(typeRepas)) {
            nomPlat = request.getParameter("plat_pdj");
        } else if ("dejeuner".equals(typeRepas)) {
            nomPlat = request.getParameter("plat_dej");
        } else if ("diner".equals(typeRepas)) {
            nomPlat = request.getParameter("plat_din");
        }

        if (nomPlat == null || nomPlat.trim().isEmpty() || dateMenu == null || dateMenu.trim().isEmpty()) {
            session.setAttribute("erreurDimanche", "Veuillez remplir tous les champs.");
            response.sendRedirect("menu-dimanche.jsp");
            return;
        }

        try {
            new MenuDimancheDAO().insert(nomPlat.trim(), typeRepas, dateMenu);
            String label = typeRepas.equals("petit-dejeuner") ? "Petit-Dejeuner" :
                           typeRepas.equals("dejeuner") ? "Dejeuner" : "Diner";
            session.setAttribute("successDimanche", "Menu dimanche ajoute : \"" + nomPlat.trim() + "\" (" + label + ") pour le " + dateMenu);
        } catch (AppException e) {
            session.setAttribute("erreurDimanche", "Erreur : " + e.getMessage());
        }
        response.sendRedirect("menu-dimanche.jsp");
        return;
    }

    response.sendRedirect("menu-dimanche.jsp");
%>
