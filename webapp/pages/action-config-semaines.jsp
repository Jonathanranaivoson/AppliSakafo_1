<%@ page import="dao.SemaineGroupeDAO, exception.AppException" %>
<%
    // Verifier session
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String groupeStr = request.getParameter("groupe");
    String dateDebut = request.getParameter("dateDebut");
    String dateFin = request.getParameter("dateFin");
    String redirect = request.getParameter("redirect");
    String action = request.getParameter("action");

    try {
        int groupe = Integer.parseInt(groupeStr);
        SemaineGroupeDAO sgDAO = new SemaineGroupeDAO();
        
        if ("insert".equals(action)) {
            // Insertion d'un nouveau groupe
            sgDAO.insert(groupe, dateDebut, dateFin);
            session.setAttribute("succesConfig", "✅ Groupe " + groupe + " créé avec succès !");
        } else {
            // Mise à jour d'un groupe existant
            sgDAO.update(groupe, dateDebut, dateFin);
            session.setAttribute("succesConfig", "✅ Dates du Groupe " + groupe + " mises à jour avec succès !");
        }
    } catch (AppException e) {
        session.setAttribute("succesConfig", "❌ Erreur : " + e.getMessage());
    } catch (Exception e) {
        session.setAttribute("succesConfig", "❌ Erreur lors de la mise à jour : " + e.getMessage());
    }

    // Redirection selon la source
    if ("menu".equals(redirect)) {
        response.sendRedirect("menu.jsp?groupe=" + groupeStr);
    } else if ("groupe".equals(redirect)) {
        response.sendRedirect("config-semaines.jsp?groupe=" + groupeStr);
    } else {
        response.sendRedirect("config-semaines.jsp?groupe=" + groupeStr);
    }
%>
