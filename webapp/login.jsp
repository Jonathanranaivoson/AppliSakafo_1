<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>
<%@ page import="exception.AppException" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (email != null && password != null) {
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.authenticate(email, password);
            
            if (user != null) {
                session.setAttribute("user", user);
                response.sendRedirect("pages/menu.jsp");
            } else {
                response.sendRedirect("index.jsp?error=1");
            }
        } catch (AppException e) {
            out.println("<p>Erreur: " + e.getMessage() + "</p>");
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>
