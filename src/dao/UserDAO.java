package dao;

import exception.AppException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import utils.Connexion;

public class UserDAO {

    public User authenticate(String email, String motDePasse) throws AppException {
        String sql = "SELECT * FROM users WHERE email = ? AND mot_de_passe = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, motDePasse);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUser(rs);
            }
            throw new AppException("Email ou mot de passe incorrect");

        } catch (AppException e) {
            throw e;
        } catch (Exception e) {
            throw new AppException("Erreur lors de l'authentification", e);
        }
    }


    

    private User mapUser(ResultSet rs) throws Exception {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setNom(rs.getString("nom"));
        user.setPrenom(rs.getString("prenom"));
        user.setEmail(rs.getString("email"));
        user.setMotDePasse(rs.getString("mot_de_passe"));
        return user;
    }
}
