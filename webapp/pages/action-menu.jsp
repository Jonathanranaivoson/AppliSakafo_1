<%@ page import="dao.MenuJournalierDAO, exception.AppException" %>
<%
    // Verifier session
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String action = request.getParameter("action");
    String menuIdStr = request.getParameter("menuId");
    String groupeStr = request.getParameter("groupe");
    int groupe = 1;

    try { groupe = Integer.parseInt(groupeStr); } catch (Exception e) {}

    MenuJournalierDAO mjDAO = new MenuJournalierDAO();

    try {
        int menuId = Integer.parseInt(menuIdStr);

        if ("cocher".equals(action)) {
            String faitStr = request.getParameter("fait");
            boolean fait = "true".equals(faitStr);
            mjDAO.cocherFait(menuId, fait);

        } else if ("modifAtoandro".equals(action)) {
            int newId = Integer.parseInt(request.getParameter("newAtoandroId"));
            mjDAO.updateAtoandro(menuId, newId);

        } else if ("modifHariva".equals(action)) {
            int newId = Integer.parseInt(request.getParameter("newHarivaId"));
            mjDAO.updateHariva(menuId, newId);

        } else if ("modifMaraina".equals(action)) {
            int newId = Integer.parseInt(request.getParameter("newMenuMarainaId"));
            mjDAO.updateMenuMaraina(menuId, newId);
        }

    } catch (AppException e) {
        session.setAttribute("erreurAction", e.getMessage());
    } catch (Exception e) {
        session.setAttribute("erreurAction", "Erreur lors de l'action");
    }

    // Rediriger vers la page source
    String source = request.getParameter("source");
    if ("hebdo".equals(source)) {
        response.sendRedirect("menu-hebdo.jsp");
    } else {
        response.sendRedirect("menu.jsp?groupe=" + groupe);
    }
%>
