<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO, model.User, exception.AppException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - AppliSakafo</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="login-container">
        <h2>AppliSakafo</h2>
        
        <%
            String error = null;
            
            if (request.getMethod().equals("POST")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                try {
                    UserDAO userDAO = new UserDAO();
                    User user = userDAO.authenticate(username, password);
                    
                    session.setAttribute("user", user);
                    response.sendRedirect("pages/menu.jsp");
                    return;
                } catch (AppException e) {
                    error = e.getMessage();
                }
            }
        %>
        
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
        
        <form method="post" action="index.jsp">
            <div class="form-group">
                <label for="username">Nom d'utilisateur</label>
                <input type="text" id="username" name="username" value="admin@applisakafo.com" required>
            </div>
            
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" name="password" value="admin123" required>
            </div>
            
            <input type="submit" value="Se connecter">
        </form>
    </div>
</body>
</html>